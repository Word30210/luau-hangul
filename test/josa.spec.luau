local frktest = require("../lune_packages/frktest")
local josa = require("../src/core/josa")

local test = frktest.test
local check = frktest.assert.check

return function()
    test.suite("josa.josa", function()
        test.case("주격조사", function()
            check.equal(josa.josa("샴푸", "이/가"), "샴푸가")
            check.equal(josa.josa("칫솔", "이/가"), "칫솔이")
        end)

        test.case("목적격조사", function()
            check.equal(josa.josa("샴푸", "을/를"), "샴푸를")
            check.equal(josa.josa("칫솔", "을/를"), "칫솔을")
        end)

        test.case("대조의 보조사", function()
            check.equal(josa.josa("샴푸", "은/는"), "샴푸는")
            check.equal(josa.josa("칫솔", "은/는"), "칫솔은")
        end)

        test.case("방향의 격조사", function()
            check.equal(josa.josa("바깥", "으로/로"), "바깥으로")
            check.equal(josa.josa("내부", "으로/로"), "내부로")
        end)

        test.case("방향의 격조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.josa("지름길", "으로/로"), "지름길로")
        end)

        test.case("비교의 격조사", function()
            check.equal(josa.josa("샴푸", "와/과"), "샴푸와")
            check.equal(josa.josa("칫솔", "와/과"), "칫솔과")
        end)

        test.case("선택의 보조사", function()
            check.equal(josa.josa("샴푸", "이나/나"), "샴푸나")
            check.equal(josa.josa("칫솔", "이나/나"), "칫솔이나")
        end)

        test.case("화제의 보조사", function()
            check.equal(josa.josa("샴푸", "이란/란"), "샴푸란")
            check.equal(josa.josa("칫솔", "이란/란"), "칫솔이란")
        end)

        test.case("호격조사", function()
            check.equal(josa.josa("철수", "아/야"), "철수야")
            check.equal(josa.josa("길동", "아/야"), "길동아")
        end)

        test.case("접속조사", function()
            check.equal(josa.josa("고기", "이랑/랑"), "고기랑")
            check.equal(josa.josa("과일", "이랑/랑"), "과일이랑")
        end)

        test.case("주제의 보조사", function()
            check.equal(josa.josa("의사", "이라/라"), "의사라")
            check.equal(josa.josa("선생님", "이라/라"), "선생님이라")
        end)

        test.case("서술격조사와 종결어미", function()
            check.equal(josa.josa("사과", "이에요/예요"), "사과예요")
            check.equal(josa.josa("책", "이에요/예요"), "책이에요")
        end)

        test.case("서술격조솨와 종결어미 \"이\" 로 끝나는 단어 예외 처리", function()
            check.equal(josa.josa("때밀이", "이에요/예요"), "때밀이예요")
        end)

        test.case("지위나 신분 또는 자격을 나타내는 위격조사", function()
            check.equal(josa.josa("학생", "으로서/로서"), "학생으로서")
            check.equal(josa.josa("부모", "으로서/로서"), "부모로서")
        end)

        test.case("지위나 신분 또는 자격을 나타내는 위격조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.josa("라이벌", "으로서/로서"), "라이벌로서")
        end)

        test.case("수단의 의미를 나타내는 도구격조사", function()
            check.equal(josa.josa("토큰", "으로써/로써"), "토큰으로써")
            check.equal(josa.josa("함수", "으로써/로써"), "함수로써")
        end)

        test.case("수단의 의미를 나타내는 도구격조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.josa("건물", "으로써/로써"), "건물로써")
        end)

        test.case("어떤 행동의 출발점이나 비롯되는 대상임을 나타내는 격 조사", function()
            check.equal(josa.josa("역삼동", "으로부터/로부터"), "역삼동으로부터")
            check.equal(josa.josa("저기", "으로부터/로부터"), "저기로부터")
        end)

        test.case("어떤 행동의 출발점이나 비롯되는 대상임을 나타내는 격 조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.josa("동굴", "으로부터/로부터"), "동굴로부터")
        end)

        test.case("단어가 빈 문자열일 경우 빈 문자열을 반환한다.", function()
            check.equal(josa.josa("", "이/가"), "")
        end)

        test.case("영어로된 약어일 경우, 마지막 알파벳을 한국어로 바꾼뒤 조사를 붙인다.", function()
            check.equal(josa.josa("URL", "을/를"), "URL을")
            check.equal(josa.josa("CSS", "을/를"), "CSS를")

            check.equal(josa.josa("URL", "은/는"), "URL은")
            check.equal(josa.josa("CSS", "은/는"), "CSS는")

            check.equal(josa.josa("URL", "이/가"), "URL이")
            check.equal(josa.josa("CSS", "이/가"), "CSS가")

            check.equal(josa.josa("URL", "와/과"), "URL과")
            check.equal(josa.josa("CSS", "와/과"), "CSS와")

            check.equal(josa.josa("URL", "으로/로"), "URL로")

            check.equal(josa.josa("URL", "이나/나"), "URL이나")
            check.equal(josa.josa("CSS", "이나/나"), "CSS나")

            check.equal(josa.josa("URL", "이란/란"), "URL이란")
            check.equal(josa.josa("CSS", "이란/란"), "CSS란")

            check.equal(josa.josa("URL", "아/야"), "URL아")
            check.equal(josa.josa("CSS", "아/야"), "CSS야")

            check.equal(josa.josa("URL", "이랑/랑"), "URL이랑")
            check.equal(josa.josa("CSS", "이랑/랑"), "CSS랑")

            check.equal(josa.josa("URL", "이에요/예요"), "URL이에요")
            check.equal(josa.josa("CSS", "이에요/예요"), "CSS예요")
        end)
    end)

    test.suite("josa.pick", function()
        test.case("주격조사", function()
            check.equal(josa.pick("샴푸", "이/가"), "가")
            check.equal(josa.pick("칫솔", "이/가"), "이")
        end)

        test.case("목적격조사", function()
            check.equal(josa.pick("샴푸", "을/를"), "를")
            check.equal(josa.pick("칫솔", "을/를"), "을")
        end)

        test.case("대조의 보조사", function()
            check.equal(josa.pick("샴푸", "은/는"), "는")
            check.equal(josa.pick("칫솔", "은/는"), "은")
        end)

        test.case("방향의 격조사", function()
            check.equal(josa.pick("바깥", "으로/로"), "으로")
            check.equal(josa.pick("칫솔", "으로/로"), "로")
        end)

        test.case("방향의 격조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.pick("지름길", "으로/로"), "로")
        end)

        test.case("비교의 격조사", function()
            check.equal(josa.pick("샴푸", "와/과"), "와")
            check.equal(josa.pick("칫솔", "와/과"), "과")
        end)

        test.case("선택의 보조사", function()
            check.equal(josa.pick("샴푸", "이나/나"), "나")
            check.equal(josa.pick("칫솔", "이나/나"), "이나")
        end)

        test.case("화제의 보조사", function()
            check.equal(josa.pick("샴푸", "이란/란"), "란")
            check.equal(josa.pick("칫솔", "이란/란"), "이란")
        end)

        test.case("호격조사", function()
            check.equal(josa.pick("철수", "아/야"), "야")
            check.equal(josa.pick("길동", "아/야"), "아")
        end)

        test.case("접속조사", function()
            check.equal(josa.pick("고기", "이랑/랑"), "랑")
            check.equal(josa.pick("과일", "이랑/랑"), "이랑")
        end)

        test.case("주제의 보조사", function()
            check.equal(josa.pick("의사", "이라/라"), "라")
            check.equal(josa.pick("선생님", "이라/라"), "이라")
        end)

        test.case("서술격조사와 종결어미", function()
            check.equal(josa.pick("사과", "이에요/예요"), "예요")
            check.equal(josa.pick("책", "이에요/예요"), "이에요")
        end)

        test.case("서술격조솨와 종결어미 \"이\" 로 끝나는 단어 예외 처리", function()
            check.equal(josa.pick("때밀이", "이에요/예요"), "예요")
        end)

        test.case("지위나 신분 또는 자격을 나타내는 위격조사", function()
            check.equal(josa.pick("학생", "으로서/로서"), "으로서")
            check.equal(josa.pick("부모", "으로서/로서"), "로서")
        end)

        test.case("지위나 신분 또는 자격을 나타내는 위격조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.pick("라이벌", "으로서/로서"), "로서")
        end)

        test.case("수단의 의미를 나타내는 도구격조사", function()
            check.equal(josa.pick("토큰", "으로써/로써"), "으로써")
            check.equal(josa.pick("함수", "으로써/로써"), "로써")
        end)

        test.case("수단의 의미를 나타내는 도구격조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.pick("건물", "으로써/로써"), "로써")
        end)

        test.case("어떤 행동의 출발점이나 비롯되는 대상임을 나타내는 격 조사", function()
            check.equal(josa.pick("역삼동", "으로부터/로부터"), "으로부터")
            check.equal(josa.pick("저기", "으로부터/로부터"), "로부터")
        end)

        test.case("어떤 행동의 출발점이나 비롯되는 대상임을 나타내는 격 조사 ㄹ 받침 예외 처리", function()
            check.equal(josa.pick("동굴", "으로부터/로부터"), "로부터")
        end)
    end)
end