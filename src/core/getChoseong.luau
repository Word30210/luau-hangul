--[[
    Luau에는 normalize관련 기능이 없기 때문에 다른 방식으로 초성을 구한다.
]]

--#[ Head Variables ]#--
local module = {}

--#[ Mdules ]#--
local super_table = require("@luau_pkg/super_table")
local disassemble = require("../core/disassemble")

--#[ Variables ]#--
--

--#[ Functions ]#--
--

--#[ Main ]#--
function module.getChoseong(
    word: string
): string
    return super_table.reduce(
        disassemble.disassembleToGroups(word),
        function(
            accumulator: string,
            key: number,
            value: { string }
        )
            local choseong = value[1]

            return `{ accumulator }{ choseong }`
        end,
        ""
    )
end

return module