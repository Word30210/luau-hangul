local frktest = require("../lune_packages/frktest")
local combine = require("../src/core/combine")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("combine.combineCharacter", function()
        test.case("종성으로 겹받침으로 구성될 수 있는 문자 두 개를 받으면 겹받침을 생성한다. (ㄱ, ㅏ, ㅂㅅ)", function()
            check.equal(combine.combineCharacter("ㄱ", "ㅏ", "ㅂㅅ"), "값")
        end)

        test.case("종성이 입력되지 않았다면 받침이 없는 문자로 합성한다. (ㅌ, ㅗ)", function()
            check.equal(combine.combineCharacter("ㅌ", "ㅗ"), "토")
        end)

        test.case("종성이 입력되었다면 받침을 추가한다. (ㅌ, ㅗ, ㅅ)", function()
            check.equal(combine.combineCharacter("ㅌ", "ㅗ", "ㅅ"), "톳")
        end)

        test.case("초성이 될 수 없는 문자가 초성으로 입력되면 에러를 반환한다. (ㅏ, ㅏ, ㄱ)", function()
            check.should_error(function()
                return combine.combineCharacter("ㅏ", "ㅏ", "ㄱ")
            end)
        end)

        test.case("중성이 될 수 없는 문자가 중성으로 입력되면 에러를 반환한다. (ㄱ, ㄴ, ㅃ)", function()
            check.should_error(function()
                return combine.combineCharacter("ㄱ", "ㄴ", "ㅃ")
            end)
        end)

        test.case("종성이 될 수 없는 문자가 종성으로 입력되면 에러를 반환한다. (ㄱ, ㅏ, ㅃ)", function()
            check.should_error(function()
                return combine.combineCharacter("ㄱ", "ㅏ", "ㅃ")
            end)
        end)

        test.case("온전한 한글 문자가 하나라도 입력되면 에러를 반환한다. (ㅏ, ㅏ, ㄱ)", function()
            check.should_error(function()
                return combine.combineCharacter("ㅏ", "ㅏ", "ㄱ")
            end)
        end)
    end)

    test.suite("combine.combineVowels", function()
        test.case("겹모음이 될 수 있는 모음이 순서대로 입력되면 겹모음으로 합성한다.", function()
            check.equal(combine.combineVowels("ㅗ", "ㅏ"), "ㅘ")
            check.equal(combine.combineVowels("ㅜ", "ㅔ"), "ㅞ")
            check.equal(combine.combineVowels("ㅡ", "ㅣ"), "ㅢ")
        end)

        test.case("겹모음이 될 수 있는 모음이라고 해도 틀린 순서대로 입력되면 Join한다.", function()
            check.equal(combine.combineVowels("ㅏ", "ㅗ"), "ㅏㅗ")
            check.equal(combine.combineVowels("ㅣ", "ㅡ"), "ㅣㅡ")
        end)

        test.case("이미 겹모음인 문자와 모음을 합성하려고 시도하면 Join한다.", function()
            check.equal(combine.combineVowels("ㅘ", "ㅏ"), "ㅘㅏ")
            check.equal(combine.combineVowels("ㅝ", "ㅣ"), "ㅝㅣ")
        end)
    end)
end