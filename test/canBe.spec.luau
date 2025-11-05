local frktest = require("../lune_packages/frktest")
local canBe = require("../src/core/canBe")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("canBe.canBeChoseong", function()
        test.suite("초성이 될 수 있다고 판단되는 경우", function()
            test.case("ㄱ", function()
                check.is_true(canBe.canBeChoseong("ㄱ"))
            end)
    
            test.case("ㅃ", function()
                check.is_true(canBe.canBeChoseong("ㅃ"))
            end)
        end)

        test.suite("초성이 될 수 없다고 판단되는 경우", function()
            test.case("ㅏ", function()
                check.is_false(canBe.canBeChoseong("ㅏ"))
            end)
    
            test.case("ㅘ", function()
                check.is_false(canBe.canBeChoseong("ㅘ"))
            end)
    
            test.case("ㄱㅅ", function()
                check.is_false(canBe.canBeChoseong("ㄱㅅ"))
            end)
    
            test.case("가", function()
                check.is_false(canBe.canBeChoseong("가"))
            end)
        end)
    end)

    test.suite("canBe.canBeJungseong", function()
        test.suite("중성이 될 수 있다고 판단되는 경우", function()
            test.case("ㅗㅏ", function()
                check.is_true(canBe.canBeJungseong("ㅗㅏ"))
            end)
    
            test.case("ㅘ", function()
                check.is_true(canBe.canBeJungseong("ㅘ"))
            end)
    
            test.case("ㅏ", function()
                check.is_true(canBe.canBeJungseong("ㅏ"))
            end)
        end)

        test.suite("중성이 될 수 없다고 판단하는 경우", function()
            test.case("ㄱ", function()
                check.is_false(canBe.canBeJungseong("ㄱ"))
            end)
    
            test.case("ㄱㅅ", function()
                check.is_false(canBe.canBeJungseong("ㄱㅅ"))
            end)
    
            test.case("가", function()
                check.is_false(canBe.canBeJungseong("가"))
            end)
        end)
    end)

    test.suite("canBe.canBeJongseong", function()
        test.suite("종성이 될 수 있다고 판단되는 경우", function()
            test.case("ㄱ", function()
                check.is_true(canBe.canBeJongseong("ㄱ"))
            end)
    
            test.case("ㄱㅅ", function()
                check.is_true(canBe.canBeJongseong("ㄱㅅ"))
            end)
    
            test.case("ㅂㅅ", function()
                check.is_true(canBe.canBeJongseong("ㅂㅅ"))
            end)
        end)

        test.suite("종성이 될 수 없다고 판단하는 경우", function()
            test.case("ㅎㄹ", function()
                check.is_false(canBe.canBeJongseong("ㅎㄹ"))
            end)
    
            test.case("ㅗㅏ", function()
                check.is_false(canBe.canBeJongseong("ㅗㅏ"))
            end)

            test.case("ㅏ", function()
                check.is_false(canBe.canBeJongseong("ㅏ"))
            end)
    
            test.case("가", function()
                check.is_false(canBe.canBeJongseong("가"))
            end)
        end)
    end)
end