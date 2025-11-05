--#[ Head Variables ]#--
local module = {}

--#[ Modules ]#--
local constants = require("../internal/constants")

--#[ Variables ]#--
local canBeChoseongCache: { [string]: boolean } = {}
local canBeJungseongCache: { [string]: boolean } = {}
local canBeJongseongCache: { [string]: boolean } = {}

--#[ Functions ]#--
--

--#[ Main ]#--
function module.canBeChoseong(
    character: string
): boolean
    if canBeChoseongCache[character] then
        return true
    end

    if table.find(constants.CHOSEONGS, character) then
        canBeChoseongCache[character] = true

        return true
    else
        return false
    end
end

function module.canBeJungseong(
    character: string
): boolean
    if canBeJungseongCache[character] then
        return true
    end

    if constants.DISASSEMBLE_VOWELS_BY_VOWEL[character] then
        canBeJungseongCache[character] = true

        return true
    end

    if table.find(constants.JUNGSEONGS, character) then
        canBeJungseongCache[character] = true

        return true
    else
        return false
    end
end

function module.canBeJongseong(
    character: string
): boolean
    if canBeJongseongCache[character] then
        return true
    end

    if table.find(constants.JONGSEONGS, character) then
        canBeJongseongCache[character] = true

        return true
    else
        return false
    end
end

return module