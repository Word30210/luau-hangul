--#[ Types ]#--
export type DisassembledCompleteCharacter = {
    choseong: string;
    jungseong: string;
    jongseong: string;
}

--#[ Head Variables ]#--
local module = {}

--#[ Modules ]#--
local super_table = require("../../luau_packages/super_table")
local constants = require("../internal/constants")

--#[ Variables ]#--
--

--#[ Functions ]#--
local function splitHangulCharacters(
    string: string
): { string }
    local splited = {}

    for _, charCode in utf8.codes(string) do
        table.insert(splited, utf8.char(charCode))
    end

    return splited
end

--#[ Main ]#--
function module.disassembleCompleteCharacter(
    character: string
): DisassembledCompleteCharacter?
    local charCode = utf8.codepoint(character)
    local isCompleteHangul = constants.COMPLETE_HANGUL_START_CHARCODE <= charCode and charCode <= constants.COMPLETE_HANGUL_END_CHARCODE

    if not isCompleteHangul then
        return nil
    end

    local hangulCode = charCode - constants.COMPLETE_HANGUL_START_CHARCODE

    local jongseongIndex = hangulCode % constants.NUMBER_OF_JONGSEONG
    local jungseongIndex = ((hangulCode - jongseongIndex) // constants.NUMBER_OF_JONGSEONG) % constants.NUMBER_OF_JUNGSEONG
    local choseongIndex = math.floor((hangulCode - jongseongIndex) // constants.NUMBER_OF_JONGSEONG // constants.NUMBER_OF_JUNGSEONG)

    --// Luau는 index가 1부터 시작하기 때문에 1씩 더해준다.
    return {
        choseong = constants.CHOSEONGS[choseongIndex + 1];
        jungseong = constants.JUNGSEONGS[jungseongIndex + 1];
        jongseong = constants.JONGSEONGS[jongseongIndex + 1];
    }
end

function module.disassembleToGroups(
    string: string
): { { string } }
    local result: { { string } } = {}

    for _, charCode in utf8.codes(string) do
        local character = utf8.char(charCode)
        local group: { string } = {}
        local disassembledCompleteCharacter = module.disassembleCompleteCharacter(character)

        if disassembledCompleteCharacter ~= nil then
            table.insert(group, disassembledCompleteCharacter.choseong)
            
            for _, character in next, splitHangulCharacters(disassembledCompleteCharacter.jungseong), nil do
                table.insert(group, character)
            end

            for _, character in next, splitHangulCharacters(disassembledCompleteCharacter.jongseong), nil do
                table.insert(group, character)
            end

            table.insert(result, group)

            continue
        end

        if constants.DISASSEMBLE_CONSONANTS_BY_CONSONANT[character] then
            for _, character in next, splitHangulCharacters(constants.DISASSEMBLE_CONSONANTS_BY_CONSONANT[character]), nil do
                table.insert(group, character)
            end

            table.insert(result, group)

            continue
        end

        if constants.DISASSEMBLE_VOWELS_BY_VOWEL[character] then
            for _, character in next, splitHangulCharacters(constants.DISASSEMBLE_VOWELS_BY_VOWEL[character]), nil do
                table.insert(group, character)
            end

            table.insert(result, group)

            continue
        end

        table.insert(result, { character })
    end

    return result
end

function module.disassemble(
    string: string
): string
    return super_table.reduce(
        module.disassembleToGroups(string),
        function(
            accumulator: string,
            index: number,
            disassembleds: { string }
        )
            return `{ accumulator }{ table.concat(disassembleds) }`
        end,
        ""
    )
end

return module