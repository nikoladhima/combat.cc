-- Data Logging Nikoleto Service --

--- KEY INFO ---
-- This data is not used maliciously its only used to take feedback and to know how popular the script is (probably going to make it send less data in the future)
-- It will not be used as proof to get you banned on roblox or anything like that
-- Dont like it still? you can opt out with the tutorial(s) below
-- Trying to abuse the data being sent will get you banned from the system fully (its automatic)
-- If you have used it while being opted in and want out then dm @nikoletobonnie (Discord) and provide your information so it can be fully deleted
----------------

--[[ How to opt out from Nikoleto Service:
    1. Use this loadstring instead:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nikoladhima/combat.cc/main/combat.cc.lua"))("RemoveLogging")
    Thats it you've done it lol, stay secret mr agent 🕵️‍♂️
]]

local Module = (...)
if not Module or type(Module) ~= "table" then
    return nil
end

local Success, Encoded = pcall(function()
    local UserInputService = Module[1]
    local Platform = tostring(UserInputService:GetPlatform())
    local LocalPlayer = Module[2]
    return Module[3]:JSONEncode({
        Username = LocalPlayer.Name,
        DisplayName = LocalPlayer.DisplayName,
        AccountAge = LocalPlayer.AccountAge,
        Platform = (
            (UserInputService.TouchEnabled and (Platform == "Enum.Platform.IOS" or Platform  == "Enum.Platform.Android")
        ) and "Mobile" or "Computer") .. " | " .. Platform,
        Executor = Module[4],
        GameName = Module[5],
        ServerLink = "roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId
    })
end)

if not Success then
    warn("[nikoletoscripts/Service]: Failed to encode JSON.")
    return {}
end

local httprequest = Module[6]
if httprequest then
    local Response = httprequest({
        Url = "https://service.nikoleto.workers.dev/combatcc",
        Body = Encoded,
        Method = "POST",
        Headers = {
            ["content-type"] = "application/json"
        },
    })

    if not Response then
        return {warn("[nikoletoscripts/Service]: No response / httprequest blocked.")}
    end

    return {warn("[nikoletoscripts/Service]: Sent data with response code: " .. tostring(Response.StatusCode))}
end

return {warn("[nikoletoscripts/Service]: httprequest not supported.")}
