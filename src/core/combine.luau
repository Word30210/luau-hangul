--#[ Head Variables ]#--
local module = {}

--#[ Mdules ]#--
local constants = require("../internal/constants")

--#[ Variables ]#--
--

--#[ Functions ]#--
--

--#[ Main ]#--
function module.combineCharacter(
    choseong: string,
    jungseong: string,
    jongseong: string?
): string
    local choseongIndex = table.find(constants.CHOSEONGS, choseong)

    if not choseongIndex then
        error("Invalid choseong: " .. choseong)
    end

    local jungseongIndex = table.find(constants.JUNGSEONGS, jungseong)

    if not jungseongIndex then
        error("Invalid jungseong: " .. jungseong)
    end

    local jongseongIndex = 1

    if jongseong then
        jongseongIndex = table.find(constants.JONGSEONGS, jongseong) or 0

        if jongseongIndex == 0 then
            error("Invalid jongseong: " .. jongseong)
        end
    end

    local numberOfJungseongs = #constants.JUNGSEONGS
    local numberOfJongseongs = #constants.JONGSEONGS

    local choseongOfTargetConsonant = (choseongIndex - 1)
        * numberOfJungseongs
        * numberOfJongseongs
    local choseongOfTargetVowel = (jungseongIndex - 1)
        * numberOfJongseongs

    local unicode = constants.COMPLETE_HANGUL_START_CHARCODE
        + choseongOfTargetConsonant
        + choseongOfTargetVowel
        + jongseongIndex - 1
    
    return utf8.char(unicode)
end

function module.combineVowels(
    vowel1: string,
    vowel2: string
): string
    for combinedVowel, value in next, constants.DISASSEMBLE_VOWELS_BY_VOWEL, nil do
        if value == `{ vowel1 }{ vowel2 }` then
            return combinedVowel
        end
    end

    return `{ vowel1 }{ vowel2 }`
end

return module