--#[ Head Variables ]#--
local module = {}

--#[ Modules ]#--
local numberToHangul = require("./numberToHangul")

--#[ Variables ]#--
local SUSA_MAP = {
    [1] = "하나";
    [2] = "둘";
    [3] = "셋";
    [4] = "넷";
    [5] = "다섯";
    [6] = "여섯";
    [7] = "일곱";
    [8] = "여덟";
    [9] = "아홉";
    [10] = "열";
    [20] = "스물";
    [30] = "서른";
    [40] = "마흔";
    [50] = "쉰";
    [60] = "예순";
    [70] = "일흔";
    [80] = "여든";
    [90] = "아흔";
    [100] = "백";
}

local SUSA_CLASSIFIER_MAP = {
    [1] = "한";
    [2] = "두";
    [3] = "세";
    [4] = "네";
    [20] = "스무";
}

local SEOSUSA_MAP = {
    [1] = "한";
    [2] = "두";
    [3] = "셋";
    [4] = "넷";
    [5] = "다섯";
    [6] = "여섯";
    [7] = "일곱";
    [8] = "여덟";
    [9] = "아홉";
    [10] = "열";
    [20] = "스물";
    [30] = "서른";
    [40] = "마흔";
    [50] = "쉰";
    [60] = "예순";
    [70] = "일흔";
    [80] = "여든";
    [90] = "아흔";
    [100] = "백";
}

local SEOSUSA_SPECIAL_CASE_MAP = {
  [1] = "첫";
  [2] = "둘";
  [20] = "스무";
}

--#[ Functions ]#--
local function validateSusa(
    number: number
)
    if
        number ~= number
        or number <= 0
        or number > 100
        or number % 1 ~= 0
        or number >= math.huge
    then
        error("Number must be an integer between 1 and 30.")
    end
end

local function validateSeosusa(
    number: number
)
    if
        number ~= number
        or number < 1
        or number % 1 ~= 0
        or number >= math.huge
    then
        error("Number must be an integer greater than or equal to 1.")
    end
end

function getOrdinalWord(
    number: number
): string
    if SEOSUSA_SPECIAL_CASE_MAP[number] then
        return SEOSUSA_SPECIAL_CASE_MAP[number]
    end

    local tens = math.floor(number / 10) * 10
    local ones = number % 10

    local tensWord = SEOSUSA_MAP[tens] or ""
    local onesWord = SEOSUSA_MAP[ones] or ""

    return `{ tensWord }{ onesWord }`
end

--#[ Main ]#--
function module.susa(
    number: number
): string
    validateSusa(number)

    if number == 100 then
        return SUSA_MAP[100]
    end

    local tens = math.floor(number / 10) * 10
    local ones = number % 10

    local tensWord = SUSA_MAP[tens] or ""
    local onesWord = SUSA_MAP[ones] or ""

    return `{ tensWord }{ onesWord }`
end

function module.susaClassifier(
    number: number
): string
    validateSusa(number)

    if number == 20 then
        return SUSA_CLASSIFIER_MAP[20]
    end

    local tens = math.floor(number / 10) * 10
    local ones = number % 10

    local tensWord = SUSA_MAP[tens] or ""

    if ones == 0 then
        return tensWord
    end

    if SUSA_CLASSIFIER_MAP[ones] then
        return `{ tensWord }{ SUSA_CLASSIFIER_MAP[ones] }`
    else
        local onesWord = SUSA_MAP[ones] or ""
        return `{ tensWord }{ onesWord }`
    end
end

function module.seosusa(
    number: number
): string
    validateSeosusa(number)

    if number >= 1 and number <= 99 then
        return `{ getOrdinalWord(number) }째`
    else
        return `{ numberToHangul.numberToHangul(number) }째`
    end
end

return module