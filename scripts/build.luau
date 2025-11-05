-- scripts/build.luau

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
else
    print("Error:", result:unwrapErr().message)
end