--#[ Head Variables ]#--
local module = {}

--#[ Variables ]#--
local DAYS_MAP = {
    [1] = "하루";
    [2] = "이틀";
    [3] = "사흘";
    [4] = "나흘";
    [5] = "닷새";
    [6] = "엿새";
    [7] = "이레";
    [8] = "여드레";
    [9] = "아흐레";
    [10] = "열";
    [20] = "스무";
}

local DAYS_ONLY_TENS_MAP = {
    [10] = "열흘";
    [20] = "스무날";
    [30] = "서른날";
}

--#[ Functions ]#--
local function validateNumber(
    number: number
)
    if
        number ~= number
        or number <= 0
        or number > 30
        or number % 1 ~= 0
        or number >= math.huge
    then
        error("Number must be an integer between 1 and 30.")
    end
end

local function getNumberWord(
    number: number
): string
    validateNumber(number)

    local tens = math.floor(number / 10) * 10
    local ones = number % 10

    if ones == 0 and DAYS_ONLY_TENS_MAP[tens] then
        return DAYS_ONLY_TENS_MAP[tens]
    end

    local tensWord = DAYS_MAP[tens] or ""
    local onesWord = DAYS_MAP[ones]

    return tensWord .. onesWord
end

--#[ Main ]#--
function module.days(
    number: number
): string
    return getNumberWord(number)
end

return module