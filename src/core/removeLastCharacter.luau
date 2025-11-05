--#[ Head Variables ]#--
local module = {}

--#[ Mdules ]#--
local canBe = require("../core/canBe")
local combine = require("../core/combine")
local disassemble = require("../core/disassemble")

--#[ Variables ]#--
--

--#[ Functions ]#--
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

--#[ Main ]#--
function module.removeLastCharacter(
    words: string
): string
    if utf8.len(words) == 0 then
        return ""
    end

    local lastCharacter = utf8.char(utf8.codepoint(words, utf8.offset(words, -1)))

    local result: string do
        local disassembledLastCharacter = disassemble.disassembleToGroups(lastCharacter)
        local lastCharacterWithoutLastAlphabet = excludeLastElement(disassembledLastCharacter[1])

        if #lastCharacterWithoutLastAlphabet <= 3 then
            local first, middle, last = table.unpack(lastCharacterWithoutLastAlphabet)

            if middle ~= nil then
                result = canBe.canBeJungseong(last)
                    and combine.combineCharacter(first, `{ middle }{ last }`)
                    or combine.combineCharacter(first, middle, last)
            else
                result = first or ""
            end
        else
            local first, firstJunseong, secondJungseong, firstJongseong = table.unpack(lastCharacterWithoutLastAlphabet)

            result = combine.combineCharacter(first, `{ firstJunseong }{ secondJungseong }`, firstJongseong)
        end
    end

    local lastCharacterOffset = utf8.offset(words, -1)
    local wordsWithoutLastCharacter = lastCharacterOffset ~= nil
        and string.sub(words, 0, lastCharacterOffset - 1)
        or ""

    return `{ wordsWithoutLastCharacter }{ result }`
end

return module