local frktest = require("../../lune_packages/frktest")
local susa = require("../../src/number/susa")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("susa.susa / susa.susaClassifier", function()
        local validNumbers = {
            { number = 1, word = "하나", classifier = "한" };
            { number = 2, word = "둘", classifier = "두" };
            { number = 3, word = "셋", classifier = "세" };
            { number = 4, word = "넷", classifier = "네" };
            { number = 5, word = "다섯", classifier = "다섯" };
            { number = 6, word = "여섯", classifier = "여섯" };
            { number = 7, word = "일곱", classifier = "일곱" };
            { number = 8, word = "여덟", classifier = "여덟" };
            { number = 9, word = "아홉", classifier = "아홉" };
            { number = 10, word = "열", classifier = "열" };
            { number = 11, word = "열하나", classifier = "열한" };
            { number = 12, word = "열둘", classifier = "열두" };
            { number = 20, word = "스물", classifier = "스무" };
            { number = 21, word = "스물하나", classifier = "스물한" };
            { number = 30, word = "서른", classifier = "서른" };
            { number = 99, word = "아흔아홉", classifier = "아흔아홉" };
            { number = 100, word = "백", classifier = "백" };
        }

        local invalidNumbers = {
            { number =  0 };
            { number =  -1 };
            { number =  101 };
            { number =  1.1 };
            { number =  -1.1 };
            { number =  math.huge };
            { number =  -math.huge };
            { number =  0 / 0 };
        }

        for _, case in next, validNumbers do
            test.case(`{ case.number } - 순 우리말 수사({ case.word })로 바꿔 반환해야 한다.`, function()
                local result = susa.susa(case.number)

                check.equal(result, case.word)
            end)

            test.case(`{ case.number } - 순 우리말 수 관형사가 있다면 수 관형사({ case.classifier })로 없다면 수사({ case.word })로 반환해야 한다..`, function()
                local result = susa.susaClassifier(case.number)

                check.equal(result, case.classifier)
            end)
        end
        
        for _, case in next, invalidNumbers do
            test.case(`{ case.number } - 유효하지 않은 숫자에 대해 오류를 발생시켜야 한다.`, function()
                check.should_error(function()
                    return susa.susa(case.number)
                end)

                check.should_error(function()
                    return susa.susaClassifier(case.number)
                end)
            end)
        end
    end)

    test.suite("susa.seosusa", function()
        local validNumbers = {
            { number = 1, word = "첫째" };
            { number = 2, word = "둘째" };
            { number = 3, word = "셋째" }; --// '셋째'가 표준어이고 '세째'는 비표준어이다.(표준어 사정 원칙 제6항)
            { number = 4, word = "넷째" }; --// '넷째'가 표준어이고 '네째'는 비표준어이다.(표준어 사정 원칙 제6항)
            { number = 5, word = "다섯째" };
            { number = 6, word = "여섯째" };
            { number = 7, word = "일곱째" };
            { number = 8, word = "여덟째" };
            { number = 9, word = "아홉째" };
            { number = 10, word = "열째" };
            { number = 11, word = "열한째" };
            { number = 12, word = "열두째" }; --// '둘째'는 십 단위 이상의 서수사에 쓰일 때에 '두째'로 한다.(표준어 사정 원칙 제6항)
            { number = 13, word = "열셋째" };
            { number = 14, word = "열넷째" };
            { number = 15, word = "열다섯째" };
            { number = 20, word = "스무째" };
            { number = 21, word = "스물한째" };
            { number = 22, word = "스물두째" };
            { number = 30, word = "서른째" };
            { number = 40, word = "마흔째" };
            { number = 90, word = "아흔째" };
            { number = 99, word = "아흔아홉째" };
            { number = 100, word = "백째" };
            { number = 101, word = "백일째" };
        }

        local invalidNumbers = {
            { number =  0 };
            { number =  -1 };
            { number =  1.1 };
            { number =  -1.1 };
            { number =  math.huge };
            { number =  -math.huge };
            { number =  0 / 0 };
        }

        for _, case in next, validNumbers do
            test.case(`{ case.number } - 순 우리말 서수사({ case.word })로 변환한다.`, function()
                local result = susa.seosusa(case.number)

                check.equal(result, case.word)
            end)
        end

        for _, case in next, invalidNumbers do
            test.case(`{ case.number } - 유효하지 않은 숫자에 대해 오류를 발생시켜야 한다.`, function()
                check.should_error(function()
                    return susa.seosusa(case.number)
                end)
            end)
        end
    end)
end