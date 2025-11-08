local frktest = require("../../lune_packages/frktest")
local disassemble = require("../../src/core/disassemble")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("disassemble", function()
        test.case("값", function()
            check.equal(disassemble.disassemble("값"), "ㄱㅏㅂㅅ")
        end)

        test.case("값이 비싸다", function()
            check.equal(disassemble.disassemble("값이 비싸다"), "ㄱㅏㅂㅅㅇㅣ ㅂㅣㅆㅏㄷㅏ")
        end)

        test.case("사과 짱", function()
            check.equal(disassemble.disassemble("사과 짱"), "ㅅㅏㄱㅗㅏ ㅉㅏㅇ")
        end)

        test.case("ㄵ", function()
            check.equal(disassemble.disassemble("ㄵ"), "ㄴㅈ")
        end)

        test.case("ㅘ", function()
            check.equal(disassemble.disassemble("ㅘ"), "ㅗㅏ")
        end)
    end)

    test.suite("disassemble.disassembleCompleteCharacter", function()
        test.case("값", function()
            check.table.equal(
                disassemble.disassembleCompleteCharacter("값"),
                {
                    choseong = "ㄱ";
                    jungseong = "ㅏ";
                    jongseong = "ㅂㅅ";
                }
            )
        end)

        test.case("리", function()
            check.table.equal(
                disassemble.disassembleCompleteCharacter("리"),
                {
                    choseong = "ㄹ";
                    jungseong = "ㅣ";
                    jongseong = "";
                }
            )
        end)

        test.case("빚", function()
            check.table.equal(
                disassemble.disassembleCompleteCharacter("빚"),
                {
                    choseong = "ㅂ";
                    jungseong = "ㅣ";
                    jongseong = "ㅈ";
                }
            )
        end)

        test.case("박", function()
            check.table.equal(
                disassemble.disassembleCompleteCharacter("박"),
                {
                    choseong = "ㅂ";
                    jungseong = "ㅏ";
                    jongseong = "ㄱ";
                }
            )
        end)

        test.case("와", function()
            check.table.equal(
                disassemble.disassembleCompleteCharacter("와"),
                {
                    choseong = "ㅇ";
                    jungseong = "ㅗㅏ";
                    jongseong = "";
                }
            )
        end)

        test.case("완전한 한글 문자열이 아니면 nil을 반환해야 합니다.", function()
            check.equal(disassemble.disassembleCompleteCharacter("ㄱ"), nil)
            check.equal(disassemble.disassembleCompleteCharacter("ㅏ"), nil)
        end)
    end)

    test.suite("disassemble.disassembleToGroups", function()
        test.case("값", function()
            check.table.equal(
                disassemble.disassembleToGroups("값"),
                {
                    { "ㄱ", "ㅏ", "ㅂ", "ㅅ" };
                }
            )
        end)

        test.case("값이 비싸다", function()
            check.table.equal(
                disassemble.disassembleToGroups("값이 비싸다"),
                {
                    { "ㄱ", "ㅏ", "ㅂ", "ㅅ" };
                    { "ㅇ", "ㅣ" };
                    { " " };
                    { "ㅂ", "ㅣ" };
                    { "ㅆ", "ㅏ" };
                    { "ㄷ", "ㅏ" };
                }
            )
        end)

        test.case("사과 짱", function()
            check.table.equal(
                disassemble.disassembleToGroups("사과 짱"),
                {
                    { "ㅅ", "ㅏ" };
                    { "ㄱ", "ㅗ", "ㅏ"};
                    { " " };
                    { "ㅉ", "ㅏ", "ㅇ" };
                }
            )
        end)

        test.case("ㄵ", function()
            check.table.equal(
                disassemble.disassembleToGroups("ㄵ"),
                {
                    { "ㄴ", "ㅈ" };
                }
            )
        end)

        test.case("ㅘ", function()
            check.table.equal(
                disassemble.disassembleToGroups("ㅘ"),
                {
                    { "ㅗ", "ㅏ" };
                }
            )
        end)
    end)
end