local frktest = require("../../lune_packages/frktest")
local assemble = require("../../src/core/assemble")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("assemble.assemble", function()
        test.case("온전한 한글과 한글 문자 조합", function()
            check.equal(
                assemble.assemble({
                    "아버지가";
                    " ";
                    "방ㅇ";
                    "ㅔ ";
                    "들ㅇ";
                    "ㅓ갑니다";
                }),
                "아버지가 방에 들어갑니다"
            )
        end)

        test.case("온전한 한글만 조합", function()
            check.equal(
                assemble.assemble({
                    "아버지가";
                    " ";
                    "방에 ";
                    "들어갑니다";
                }),
                "아버지가 방에 들어갑니다"
            )
        end)

        test.case("온전하지 않은 한글만 조합", function()
            check.equal(
                assemble.assemble({
                    "ㄷ";
                    "ㅗ";
                    "ㄴ";
                    "ㅇ";
                    "ㅣ";
                    "ㅇ";
                    "ㅓ";
                    "ㅂㅅ";
                    "ㄷ";
                    "ㅏ";
                }),
                "돈이없다"
            )

            check.equal(
                assemble.assemble({
                    "ㅇ";
                    "ㅓ";
                    "ㅄ";
                    "ㄷ";
                    "ㅏ";
                }),
                "없다"
            )
        end)
    end)
end