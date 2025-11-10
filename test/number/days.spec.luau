local frktest = require("../../lune_packages/frktest")
local days = require("../../src/number/days")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("days.days", function()
        local validNumbers = {
            { number = 1, word = "하루" };
            { number = 2, word = "이틀" };
            { number = 3, word = "사흘" };
            { number = 4, word = "나흘" };
            { number = 5, word = "닷새" };
            { number = 6, word = "엿새" };
            { number = 7, word = "이레" };
            { number = 8, word = "여드레" };
            { number = 9, word = "아흐레" };
            { number = 10, word = "열흘" };
            { number = 11, word = "열하루" };
            { number = 20, word = "스무날" };
            { number = 21, word = "스무하루" };
            { number = 30, word = "서른날" };
        }

        local invalidNumbers = {
            { number =  0 };
            { number =  -1 };
            { number =  31 };
            { number =  1.1 };
            { number =  -1.1 };
            { number =  math.huge };
            { number =  -math.huge };
            { number =  0 / 0 };
        }

        for _, case in next, validNumbers do
            test.case(`{ case.number } - 순 우리말 날짜({ case.word })로 바꿔 반환해야 한다.`, function()
                local result = days.days(case.number)

                check.equal(case.word, result)
            end)
        end

        for _, case in next, invalidNumbers do
            test.case(`{ case.number } - 유효하지 않은 숫자에 대해 오류를 발생시켜야 한다.`, function()
                check.should_error(function()
                    return days.days(case.number)
                end)
            end)
        end
    end)
end