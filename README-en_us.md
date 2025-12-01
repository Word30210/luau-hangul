# luau-hangul
[한국어](https://github.com/Word30210/luau-hangul/blob/main/README.md) | English

This is a library that I ported from toss's es-hangul for handling Hangul characters in Luau

## Examples
You can easily implement tasks related to Hangul, such as initial consonant search and attaching particles(josas).

```lua
local hangul = require(path.to.luau_hangul)
local getChoseong = hangul.core.getChoseong

local searchWord = "라면"
local userInput = "ㄹㅁ"

local result = getChoseong.GetChoseong(searchWord) -- ㄹㅁ

-- // Check if the 'choseong' of the search word match the user input
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

## Installation
**If you are using pesde,**
```bash
pesde init # if you didn't initialize pesde,
pesde add word30210/luau-hangul
pesde install
```

**If you are using Wally,**
Unfortunately, luau-hangul isn't on Wally yet.

**If you are using just Roblox Studio,**
You can just download the latest version rbxm file from the [Github Releases](https://github.com/Word30210/luau-hangul/releases).

## Contributing
I welcome everyone's contributions, but,
luau-hangul aims to port all api of es-hangul.
Therefore, we do not accept feature add-on PR other than porting the api of es-hangul.

# Special Thanks
- [@toss](https://github.com/toss) for inspiration.