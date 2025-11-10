local fs = require("@lune/fs")
local frktest = require("../../lune_packages/frktest")
local console_reporter = frktest._reporters.lune_console_reporter

local success, filePaths = pcall(fs.readDir, "test/number")

if not success then
    error("Number tests are missing. Make sure you run this from the project root directory.")
end

for _, filePath in next, filePaths do
    local luauFilePath = string.match(filePath, "(.-).luau$")

    if not luauFilePath then
        continue
    end

    if string.find(luauFilePath, "run$") then
        continue
    end

    (require :: any)(`./{ luauFilePath }`)()
end

console_reporter.init()
frktest.run()

return nil