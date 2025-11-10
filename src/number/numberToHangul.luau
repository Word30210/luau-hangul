--#[ Head Variables ]#--
local module = {}

--#[ Modules ]#--
local super_table = require("../../luau_packages/super_table")
local constants = require("../internal/constants")

--#[ Variables ]#--
--

--#[ Functions ]#--
local function formatNumber(
    number: number
): string
    local sign, integer, decimal = string.match(tostring(number), "^([%-%+]?)(%d+)([.]?%d*)$")

    if not integer then
        return tostring(number)
    end

    local reversed = string.reverse(integer)
    reversed = string.gsub(reversed, "(%d%d%d)", "%1,")
    integer = string.gsub(string.reverse(reversed), "^,", "")

    sign = sign or ""
    sign = sign == "+" and "" or sign

    return (sign :: string) .. integer .. (decimal or "")
end

local function numberToKoreanUpToThousand(
    number: number
): string
    local resultParts: { string } = {}

    for index, digit in next, string.split(string.reverse(tostring(number)), "") do
        local resultPart: string

        if digit == "0" then
            continue
        end

        if index - 1 > 0 and digit == "1" then
            resultPart = constants.HANGUL_CARDINAL[index - 1]
        else
            resultPart = constants.HANGUL_NUMBERS[tonumber(digit) :: number]
                .. (constants.HANGUL_CARDINAL[index - 1] or "")
        end

        table.insert(
            resultParts,
            resultPart
        )
    end

    local result = ""

    for i = #resultParts, 1, -1 do
        result ..= resultParts[i]
    end

    return result
end

local function numberToHangul(
    number: number,
    withSpace: boolean?
): string
    if type(number) ~= "number" or number ~= number then
        error("Input must be a valid number.")
    end

    if number == 0 then
        return "영"
    end

    if number == math.huge then
        return "무한대"
    end

    if number == -math.huge then
        return withSpace
            and "마이너스 무한대"
            or "마이너스무한대"
    end

    local isNegative = number < 0
    local absoluteNumber = math.abs(number)

    local integerPart, decimalPart = table.unpack(string.split(tostring(absoluteNumber), "."))

    local koreanParts: { string } = {}
    local remainingDigits = integerPart
    local placeIndex = 0;

    while #remainingDigits > 0 do
        local currentPart = string.sub(remainingDigits, -4)

        local koreanNumber = numberToKoreanUpToThousand(tonumber(currentPart) :: number)

        if koreanNumber ~= "" then
            table.insert(
                koreanParts,
                1,
                `{ koreanNumber }{ constants.HANGUL_DIGITS[placeIndex] or "" }`
            )
        end

        remainingDigits = string.sub(remainingDigits, 1, -5)
        placeIndex += 1
    end

    local result: string
    if integerPart == "0" then
        result = "영"
    else
        result = table.concat(
            koreanParts,
            withSpace
                and " "
                or ""
        )
    end

    if decimalPart then
        local decimalKorean = super_table.reduce(
            string.split(decimalPart, ""),
            function(
                accumulator: string,
                _,
                digit: string
            ): string
                return accumulator
                    .. constants.HANGUL_NUMBERS_FOR_DECIMAL[(tonumber(digit) :: number) + 1]
            end,
            ""
        )

        result ..= `점{
            withSpace
                and " "
                or ""
        }{ decimalKorean }`
    end

    if isNegative then
        result = `마이너스{
            withSpace
                and " "
                or ""
        }{ result }`
    end

    return result
end

local function numberToHangulMixed(
    number: number,
    withSpace: boolean?
): string
    if type(number) ~= "number" or number ~= number then
        error("Input must be a valid number.")
    end

    if number == 0 then
        return "0"
    end

    if number == math.huge then
        return "무한대"
    end

    if number == -math.huge then
        return "-무한대"
    end

    local isNegative = number < 0
    local absoluteNumber = math.abs(number)

    local integerPart, decimalPart = table.unpack(string.split(tostring(absoluteNumber), "."))

    local koreanParts: { string } = {}
    local remainingDigits = integerPart
    local placeIndex = 0;

    while #remainingDigits > 0 do
        local currentPart = string.sub(remainingDigits, -4)
        local numericValue = tonumber(currentPart) :: number

        if numericValue > 0 then
            local formattedPart = `{ formatNumber(numericValue) }{ constants.HANGUL_DIGITS[placeIndex] or "" }`

            table.insert(
                koreanParts,
                1,
                formattedPart
            )
        end

        remainingDigits = string.sub(remainingDigits, 1, -5)
        placeIndex += 1
    end

    local result: string
    if integerPart == "0" then
        result = "0"
    else
        result = table.concat(
            koreanParts,
            withSpace
                and " "
                or ""
        )
    end

    if decimalPart then
        result ..= `.{ decimalPart }`
    end

    if isNegative then
        result = `-{
            withSpace
                and " "
                or ""
        }{ result }`
    end

    return result
end

--#[ Main ]#--
function module.numberToHangul(
    number: number
): string
    return numberToHangul(number)
end

function module.numberToHangulWithSpace(
    number: number
): string
    return numberToHangul(number, true)
end

function module.numberToHangulMixed(
    number: number
): string
    return numberToHangulMixed(number)
end

function module.numberToHangulMixedWithSpace(
    number: number
): string
    return numberToHangulMixed(number, true)
end

return module