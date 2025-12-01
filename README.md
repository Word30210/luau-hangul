# luau-hangul
한국어 | [English](https://github.com/Word30210/luau-hangul/blob/main/README-en_us.md)

luau-hangul은 [toss](https://github.com/toss)의 [es-hangul](https://github.com/toss/es-hangul)을 Luau로 포팅하여, Luau로 한글을 쉽게 처리할 수 있게 하는 라이브러리입니다.

## 사용 예시
문자열 초성화, 조사 붙이기와 같은 한글 작업을 간단히 할 수 있습니다.

```lua
local hangul = require(path.to.luau_hangul)
local getChoseong = hangul.core.getChoseong

local searchWord = "라면"
local userInput = "ㄹㅁ"

local result = getChoseong.GetChoseong(searchWord) -- ㄹㅁ

-- 검색어의 초성과 사용자 입력 초성이 일치하는지 확인
if result == userInput then
    something()
end
```

```lua
local hangul = require(path.to.luau_hangul)
local josa = hangul.core.josa

local word1 = "사과"
local sentence1 = josa.josa(word1, "을/를") .. " 먹었습니다."
print(sentence1) -- "사과를 먹었습니다."

local word2 = "바나나"
local sentence2 = josa.josa(word2, "이/가") .. " 맛있습니다."
print(sentence2) -- "바나나가 맛있습니다."
```

## 설치하기
**만약 pesde를 사용하고 있다면,**
```bash
pesde init # pesde 초기화를 하지 않았다면
pesde add word30210/luau-hangul
pesde install
```

**만약 wally를 사용하고 있다면,**
안타깝지만 아직 luau-hangul은 wally에 올라와 있지 않습니다.

**만약 그냥 로블록스 스튜디오를 사용하고 있다면,**
[Github Releases](https://github.com/Word30210/luau-hangul/releases)에서 최신 버전을 다운로드 해 주세요.

## 기여하기
모든 분들의 기여를 환영합니다. 하지만,
luau-hangul은 es-hangul의 모든 api를 포팅하는것을 목표로 하고 있습니다.
따라서, es-hangul의 api를 포팅하는것 이외의 기능추가 PR은 받지 않습니다.

## Todo
- new solver에서도 동작하도록 수정
- API 문서화

# Special Thanks
- [@toss](https://github.com/toss) for inspiration.