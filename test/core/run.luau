local frktest = require("../lune_packages/frktest")
local console_reporter = frktest._reporters.lune_console_reporter

require("./assemble.spec")()
require("./canBe.spec")()
require("./combine.spec")()
require("./disassemble.spec")()
require("./getChoseong.spec")()
require("./hasBatchim.spec")()
require("./josa.spec")()
require("./removeLastCharacter.spec")()

console_reporter.init()
frktest.run()