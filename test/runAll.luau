local fs = require("@lune/fs")
local process = require("@lune/process")

local success, testDirectories = pcall(fs.readDir, "test")

if not success then
    error("Tests are missing. Make sure you run this from the project root directory.")
end

for _, testDirectory in next, testDirectories do
    if fs.isDir(`test/{ testDirectory }`) then
        local filePaths = fs.readDir(`test/{ testDirectory }`)

        if not table.find(filePaths, "run.luau") then
            warn(`Test directory 'test/{ testDirectory }' is missing run.luau file.`)
        end

        print(`\u{001b}[35m[Running tests in "test/{ testDirectory }"]\u{001b}[0m`)
        print(
            process.exec(
                "lune",
                {
                    "run",
                    `test/{ testDirectory }/run.luau`
                }
            ).stdout
        )
    end
end