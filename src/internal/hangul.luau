--#[ Head Variables ]#--
local module = {}

--#[ Mdules ]#--
local canBe = require("../core/canBe")
local combine = require("../core/combine")
local disassemble = require("../core/disassemble")
local hasBatchim = require("../core/hasBatchim")
local removeLastCharacter = require("../core/removeLastCharacter")
local constants = require("./constants")

--#[ Variables ]#--
--

--#[ Functions ]#--
local function excludeLastHangulCharacter(
    source: string
): (string, string)
    local lastCharacterOffset = utf8.offset(source, -1)

    if not lastCharacterOffset then
        return "", ""
    end

    local restCharacters = string.sub(source, 0, lastCharacterOffset - 1)
    local lastCharacter = string.sub(source, lastCharacterOffset, #source)

    return restCharacters, lastCharacter
end

local function excludeLastElement<V>(
    array: { V }
): ({ V }, V)
    local lastElement = array[#array]
    local newArray = {}

    for index = 1, #array - 1 do
        local value = array[index]

        newArray[index] = value
    end

    return newArray, lastElement
end

local function splitHangulCharacters(
    string: string
): { string }
    local splited = {}

    for _, charCode in utf8.codes(string) do
        table.insert(splited, utf8.char(charCode))
    end

    return splited
end

local function isWhitespace(
    character: string
): boolean
    if character == "" then
        return false
    end

    return not not string.match(character, "^%s$");
end

local function joinString(
    ...: string
): string
    local strings = { ... }
    local concatted = table.concat(strings, "")

    return concatted
end

--#[ Main ]#--
function module.isHangulCharacter(
    character: string
): boolean
    if character == "" then
        return false
    end

    local charCode = utf8.codepoint(character)

    return charCode >= constants.COMPLETE_HANGUL_START_CHARCODE
        and charCode <= constants.COMPLETE_HANGUL_END_CHARCODE
end

function module.isHangulAlphabet(
    character: string
): boolean
    if character == "" then
        return false
    end

    local charCode = utf8.codepoint(character)

    return charCode >= constants.COMPLETE_HANGUL_ALPHABET_START_CHARCODE
        and charCode <= constants.COMPLETE_HANGUL_ALPHABET_END_CHARCODE
end

function module.isHangul(
    actual: string
): boolean
    for index, charCode in utf8.codes(actual) do
        if not (
            charCode >= constants.COMPLETE_HANGUL_START_CHARCODE
            and charCode <= constants.COMPLETE_HANGUL_END_CHARCODE
        ) and not (
            charCode >= constants.COMPLETE_HANGUL_ALPHABET_START_CHARCODE
            and charCode <= constants.COMPLETE_HANGUL_ALPHABET_END_CHARCODE
        ) then
            return false
        end
    end

    return true
end

function module.binaryAssembleAlphabets(
    source: string,
    nextCharacter: string
): string
    if source == "" then
        return nextCharacter
    end

    if canBe.canBeJungseong(`{ source }{ nextCharacter }`) then
        return combine.combineVowels(source, nextCharacter)
    end

    local isConsonantSource = canBe.canBeJungseong(source) == false

    if isConsonantSource and canBe.canBeJungseong(nextCharacter) then
        return combine.combineCharacter(source, nextCharacter)
    end

    return joinString(source, nextCharacter)
end

function module.linkHangulCharacters(
    source: string,
    nextCharacter: string
): string
    if source == "" then
        return nextCharacter
    end

    local sourceJamo = disassemble.disassembleToGroups(source)[1]
    local _, lastJamo = excludeLastElement(sourceJamo)

    return joinString(
        removeLastCharacter.removeLastCharacter(source),
        combine.combineCharacter(lastJamo, nextCharacter)
    )
end

function module.binaryAssembleCharacters(
    source: string,
    nextCharacter: string
): string
    if source == "" then
        return nextCharacter
    end

    assert(
        module.isHangulCharacter(source) or module.isHangulAlphabet(source),
        `Invaild source character: { source }. Source must be one character.`
    )

    assert(
        module.isHangulAlphabet(nextCharacter),
        `Invaild next character: { nextCharacter }. Next character must be one of the choseong, jungseong or jongseong.`
    )

    local sourceJamos = disassemble.disassembleToGroups(source)[1]
    local isSingleCharacter = #sourceJamos == 1

    if isSingleCharacter then
        local sourceCharacter = sourceJamos[1]

        return module.binaryAssembleAlphabets(sourceCharacter, nextCharacter)
    end

    local restJamos, lastJamo = excludeLastElement(sourceJamos)
    local _, secondaryLastJamo = excludeLastElement(restJamos)

    local needLinking = canBe.canBeChoseong(lastJamo) and canBe.canBeJungseong(nextCharacter)

    if needLinking then
        return module.linkHangulCharacters(source, nextCharacter)
    end

    if canBe.canBeJungseong(`{ lastJamo }{ nextCharacter }`) then
        return combine.combineCharacter(restJamos[1], `{ lastJamo }{ nextCharacter }`)
    end

    if canBe.canBeJungseong(`{ secondaryLastJamo }{ lastJamo }`) and canBe.canBeJongseong(nextCharacter) then
        return combine.combineCharacter(restJamos[1], `{ secondaryLastJamo }{ lastJamo }`, nextCharacter)
    end

    if canBe.canBeJungseong(lastJamo) and canBe.canBeJongseong(nextCharacter) then
        return combine.combineCharacter(restJamos[1], lastJamo, nextCharacter)
    end

    local lastConsonant = lastJamo

    if hasBatchim.hasSingleBatchim(source) and canBe.canBeJongseong(`{ lastConsonant }{ nextCharacter }`) then
        return combine.combineCharacter(
            restJamos[1],
            canBe.canBeJungseong(`{ restJamos[2] }{ restJamos[3] }`)
                and `{ restJamos[2] }{ restJamos[3] }`
                or restJamos[2],
            `{ lastConsonant }{ nextCharacter }`
        )
    end

    return joinString(source, nextCharacter)
end

function module.binaryAssemble(
    source: string,
    nextCharacter: string
): string
    local rest, lastCharacter = excludeLastHangulCharacter(source)
    -- local rest, lastCharacter = excludeLastElement(splitHangulCharacters(source))
    -- lastCharacter = lastCharacter or ""

    -- local needJoinString = isWhitespace(lastCharacter) or isWhitespace(nextCharacter)
    local needJoinString = not module.isHangul(lastCharacter) or not module.isHangul(nextCharacter)

    return joinString(
        -- joinString(table.unpack(rest)),
        rest,
        needJoinString
            and joinString(lastCharacter, nextCharacter)
            or module.binaryAssembleCharacters(lastCharacter, nextCharacter)
    )
end

return module