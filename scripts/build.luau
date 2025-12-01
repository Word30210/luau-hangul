-- scripts/build.luau

local process = require("@lune/process")
local multitarget = require("../lune_packages/multitarget")

local result = multitarget.build(
    "pesde.toml",
    {
        luau = true;
        lune = true;
        roblox = true;
    },
    "dist",
    {
        "src";
    },
    "LUA_ENV"
)

if result:isOk() then
    print("Built successfully!")

    local result = process.exec("rojo", { "build", "rbxm.project.json", "--output", "release.rbxm" })

    if result.ok then
        print(result.stdout)
    else
        print("Rojo Error:", result.stderr)
    end
else
    print("Error:", result:unwrapErr().message)
end