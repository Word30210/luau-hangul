local assemble = require("@self/assemble")
local canBe = require("@self/canBe")
local combine = require("@self/combine")
local disassemble = require("@self/disassemble")
local getChoseong = require("@self/getChoseong")
local hasBatchim = require("@self/hasBatchim")
local josa = require("@self/josa")
local removeLastCharacter = require("@self/removeLastCharacter")

return {
    assemble = assemble;
    canBe = canBe;
    combine = combine;
    disassemble = disassemble;
    getChoseong = getChoseong;
    hasBatchim = hasBatchim;
    josa = josa;
    removeLastCharacter = removeLastCharacter;
}