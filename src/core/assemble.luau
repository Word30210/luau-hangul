--#[ Head Variables ]#--
local module = {}

--#[ Mdules ]#--
local super_table = require("@luau_pkg/super_table")
local hangul = require("../internal/hangul")
local disassemble = require("../core/disassemble")

--#[ Variables ]#--
--

--#[ Functions ]#--
--

--#[ Main ]#--
function module.assemble(
    fragments: { string }
): string
    local disassembled = disassemble.disassemble(table.concat(fragments))
    local graphemes: { string } = {}

    for _, charCode in utf8.codes(disassembled) do
        local character = utf8.char(charCode)

        table.insert(graphemes, character)
    end

    return super_table.reduce(
        graphemes,
        function(
            accumulator: string,
            index: number,
            fragment: string
        )
            return hangul.binaryAssemble(accumulator, fragment)
        end,
        ""
    )
end

return module