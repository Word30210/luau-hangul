local frktest = require("../../lune_packages/frktest")
local removeLastCharacter = require("../../src/core/removeLastCharacter")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("removeLastCharacter.removeLastCharacter", function()
        test.case("마지막 문자가 겹받침인 경우 홑받침으로 바꾼다.", function()
            check.equal(removeLastCharacter.removeLastCharacter("안녕하세요 값"), "안녕하세요 갑")
            check.equal(removeLastCharacter.removeLastCharacter("시를 읊"), "시를 을")
        end)

        test.case("마지막 문자가 초성과 중성의 조합으로 끝날 경우 초성만 남긴다", function()
            check.equal(removeLastCharacter.removeLastCharacter("프론트엔드"), "프론트엔ㄷ")
            check.equal(removeLastCharacter.removeLastCharacter("끓다"), "끓ㄷ")
            check.equal(removeLastCharacter.removeLastCharacter("관사"), "관ㅅ")
            check.equal(removeLastCharacter.removeLastCharacter("괴사"), "괴ㅅ")
        end)

        test.case("마지막 문자가 초성과 중성과 종성의 조합으로 끝날 경우 초성과 중성이 조합된 문자만 남긴다", function()
            check.equal(removeLastCharacter.removeLastCharacter("일요일"), "일요이")
            check.equal(removeLastCharacter.removeLastCharacter("완전"), "완저")
            check.equal(removeLastCharacter.removeLastCharacter("왅전"), "왅저")
            check.equal(removeLastCharacter.removeLastCharacter("깎"), "까")
        end)

        test.case("마지막 문자가 초성과 중성의 조합으로 끝나며, 중성 입력 시 국제 표준 한글 레이아웃 기준 단일키로 처리되지 않는 이중모음 (ㅗ/ㅜ/ㅡ 계 이중모음) 인 경우 초성과 중성의 시작 모음만 남긴다.", function()
            check.equal(removeLastCharacter.removeLastCharacter("전화"), "전호")
            check.equal(removeLastCharacter.removeLastCharacter("예의"), "예으")
            check.equal(removeLastCharacter.removeLastCharacter("신세계"), "신세ㄱ") --// "ㅖ"의 경우 단일키 처리가 가능한 이중모음이므로 모음이 남지 않는다.
        end)

        test.case("마지막 문자가 초성과 중성과 종성의 조합으로 끝나며, 중성 입력 시 국제 표준 한글 레이아웃 기준 단일키로 처리되지 않는 이중모음 (ㅗ/ㅜ/ㅡ 계 이중모음) 인 경우 초성과 중성만 남긴다.", function()
            check.equal(removeLastCharacter.removeLastCharacter("수확"), "수화")
        end)

        test.case("마지막 문자가 초성과 중성과 종성의 조합으로 끝나며, 종성이 겹자음인 경우 초성과 중성과 종성의 시작 자음만 남긴다.", function()
            check.equal(removeLastCharacter.removeLastCharacter("끓"), "끌")
        end)

        test.case("마지막 문자가 초성과 중성과 종성의 조합으로 끝나며, 중성 입력 시 국제 표준 한글 레이아웃 기준 단일키로 처리되지 않는 이중모음 (ㅗ/ㅜ/ㅡ 계 이중모음)이고 종성이 겹자음인 경우 초성과 중성과 종성의 시작 자음만 남긴다.", function()
            check.equal(removeLastCharacter.removeLastCharacter("왅"), "완")
        end)

        test.case("빈 문자열일 경우 빈 문자열을 반환한다.", function()
            check.equal(removeLastCharacter.removeLastCharacter(""), "")
        end)
    end)
end