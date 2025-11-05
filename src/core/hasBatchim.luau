--#[ Head Variables ]#--
local module = {}

--#[ Modules ]#--
local constants = require("../internal/constants")

--#[ Variables ]#--
--

--#[ Functions ]#--
--

--#[ Main ]#--
function module.hasBatchim(
    string: string
): boolean
    if utf8.len(string) == 0 then
        return false
    end

    local charCode = utf8.codepoint(
        string,
        utf8.offset(string, -1)
    )

    if charCode < constants.COMPLETE_HANGUL_START_CHARCODE or charCode > constants.COMPLETE_HANGUL_END_CHARCODE then
        return false
    end

    local batchimIndex = (charCode - constants.COMPLETE_HANGUL_START_CHARCODE) % constants.NUMBER_OF_JONGSEONG + 1

    return batchimIndex > 1
end

function module.hasSingleBatchim(
    string: string
): boolean
    if utf8.len(string) == 0 then
        return false
    end

    local charCode = utf8.codepoint(
        string,
        utf8.offset(string, -1)
    )

    if charCode < constants.COMPLETE_HANGUL_START_CHARCODE or charCode > constants.COMPLETE_HANGUL_END_CHARCODE then
        return false
    end

    local batchimIndex = (charCode - constants.COMPLETE_HANGUL_START_CHARCODE) % constants.NUMBER_OF_JONGSEONG + 1

    if batchimIndex <= 0 then
        return false
    end

    local batchimLength = utf8.len(constants.JONGSEONGS[batchimIndex])

    return batchimLength == 1
end

function module.hasDoubleBatchim(
    string: string
): boolean
    if utf8.len(string) == 0 then
        return false
    end

    local charCode = utf8.codepoint(
        string,
        utf8.offset(string, -1)
    )

    if charCode < constants.COMPLETE_HANGUL_START_CHARCODE or charCode > constants.COMPLETE_HANGUL_END_CHARCODE then
        return false
    end

    local batchimIndex = (charCode - constants.COMPLETE_HANGUL_START_CHARCODE) % constants.NUMBER_OF_JONGSEONG + 1

    if batchimIndex <= 0 then
        return false
    end

    local batchimLength = utf8.len(constants.JONGSEONGS[batchimIndex])

    return batchimLength == 2
end

return module