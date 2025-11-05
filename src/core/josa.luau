--#[ Types ]#--
type JosaOption = "이/가"
    | "을/를"
    | "은/는"
    | "으로/로"
    | "와/과"
    | "이나/나"
    | "이란/란"
    | "아/야"
    | "이랑/랑"
    | "이에요/예요"
    | "으로서/로서"
    | "으로써/로써"
    | "으로부터/로부터"
    | "이라/라"

--#[ Head Variables ]#--
local module = {}

--#[ Modules ]#--
local disassemble = require("../core/disassemble")
local hasBatchim = require("../core/hasBatchim")
local constants = require("../internal/constants")

--#[ Variables ]#--
local roJosa: { JosaOption } = {
    "으로/로";
    "으로서/로서";
    "으로써/로써";
    "으로부터/로부터";
}

--#[ Functions ]#--
--

--#[ Main ]#--
function module.pick(
    word: string,
    josa: JosaOption
): string
    if utf8.len(word) == 0 then
        return string.split(josa, "/")[1]
    end

    local hasWordBatchim = hasBatchim.hasBatchim(word)
    local index = hasWordBatchim and 1 or 2

    local lastOffset = utf8.offset(word, -1) :: number
    local lastCharacter = string.sub(word, lastOffset, #word)
    local disassembledCompleteCharacter = disassemble.disassembleCompleteCharacter(lastCharacter)
    local isJongseong = hasWordBatchim
        and disassembledCompleteCharacter
        and disassembledCompleteCharacter.jongseong == "ㄹ"
    
    local isCaseOfRo = hasWordBatchim
        and isJongseong
        and table.find(roJosa, josa)
    
    if josa == "와/과" or isCaseOfRo then
        index = index == 1
            and 2
            or 1
    end

    return string.split(josa, "/")[index]
end

function module.josa(
    word: string,
    josa: JosaOption
): string
    if utf8.len(word) == 0 then
        return word
    end

    if string.match(word, "^[A-Z]+$") then
        local lastOffset = utf8.offset(word, -1) :: number
        local lastCharacter = string.sub(word, lastOffset, #word)
        local koreanPronunciationOfLastCharacter = constants.ALPHABET_TO_KOREAN[lastCharacter]

        return `{ word }{ module.pick(koreanPronunciationOfLastCharacter, josa) }`
    end

    return `{ word }{ module.pick(word, josa) }`
end

return module