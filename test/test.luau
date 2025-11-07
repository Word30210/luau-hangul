local hangul = require "../src"
local task = require "@lune/task"

local source = [[
아즈망가 대왕의 등장인물.

오사카에서 온 전학생이다. 때문에 타키노 토모가 오사카라는 별명을 지었고, 모두에게 오사카로 불리며 본명인 카스가 아유무는 모두의 기억 속에서 지워져 버렸다. 게다가 나중에 아유무 본인도 본명을 기억하지 못하게 된다. 심지어 담임 교사 타니자키 유카리도 아유무라는 본명이 기억 안 난다고 2학년으로 진급할 때 반 편성 종이에 오사카라고 적어놓는 만행을 저지른다.[4] 나이 차이가 나는 치요는 오사카 상(大阪さん)[5]이라고 부른다.
캐릭터의 배경을 이해하는 데 일본 문화에 대한 어느 정도의 문화적이고 다양한 이해가 있어야 하는 만큼 다른 나라에서 방영될 때 설정이 크게 변경되는 경향이 있다. 대한민국판 이름은 '맹순정'으로, 별명은 부산댁[6]으로 바뀌었으며 부산 사투리[7]를 구사하는 캐릭터가 되었다.
대만에서 방영될 때는 만다린 계열 방언을 쓰는 중국 대륙 출신[8]으로 설정하고 별명도 '베이핑'으로 설정했다가 양안관계를 고려하지 않은 부적절한 로컬라이징이라고 욕먹고 '오사카'로 되돌려야 했던 해프닝이 있었다.[9][10]
대한민국과 일본의 애니판 성우는 각각 부산, 오사카 출신으로 캐스팅되었다. 덕분에 두 버전 모두 어색하지 않은 사투리를 구사한다. 그리고 주인공인 치요와 가까운 사이라 본 작품의 서브 주인공이라 할 수 있다.
]]

local disassembled_source = hangul.disassemble.disassemble(source)
local splited_source: { string } = {}

for _, charCode in utf8.codes(disassembled_source) do
    table.insert(splited_source, utf8.char(charCode))
end

local buffer = ""

for _, character in next, splited_source do
    buffer = hangul.assemble.assemble({ buffer, character })

    print(buffer)
end