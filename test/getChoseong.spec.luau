local frktest = require("../lune_packages/frktest")
local getChoseong = require("../src/core/getChoseong")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("getChoseong.getChoseong", function()
        test.case("\"사과\" 단어에서 초성 \"ㅅㄱ\"을 추출한다.", function()
            check.equal(getChoseong.getChoseong("사과"), "ㅅㄱ")
        end)

        test.case("\"프론트엔드\" 단어에서 초성 \"ㅍㄹㅌㅇㄷ\"을 추출한다.", function()
            check.equal(getChoseong.getChoseong("프론트엔드"), "ㅍㄹㅌㅇㄷ")
        end)

        test.case("\"ㄴㅈ\" 단어에서 초성 \"ㄴㅈ\"을 추출한다.", function()
            check.equal(getChoseong.getChoseong("ㄴㅈ"), "ㄴㅈ")
        end)

        test.case("\"리액트\" 단어에서 초성 \"ㄹㅇㅌ\"을 추출한다.", function()
            check.equal(getChoseong.getChoseong("리액트"), "ㄹㅇㅌ")
        end)

        test.case("\"띄어 쓰기\" 단어에서 초성 \"띄어 쓰기\"을 추출한다.", function()
            check.equal(getChoseong.getChoseong("띄어 쓰기"), "ㄸㅇ ㅆㄱ")
        end)
    end)
end