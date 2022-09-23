repeat wait() until game:IsLoaded() and game:GetService("Players")
local Webhook = "https://discord.com/api/webhooks/1022931735564009574/3m493UBsocWZpACWzTHiwDCpTJvfeH0JiWf-KleHMDWEZuEwObLKI9Bq-XDbIK4DTClC" -- your webhook
_G.Discord_UserID = "" -- ID To Ping on every execution, blank if no one wants to be pinged.

local player = game:GetService"Players".LocalPlayer
local joinTime = os.time() - (player.AccountAge*86400)
local joinDate = os.date("!*t", joinTime)
local premium = false
local alt = true
if player.MembershipType == Enum.MembershipType.Premium then
   premium = true
end

if not premium and player.AccountAge >= 70 then
    alt = "maybe"
elseif premium and player.AccountAge >= 70 then
   alt = false
end

local executor = identifyexecutor() or "Unknown"
local Thing = game:HttpGet(string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", game.Players.LocalPlayer.UserId))
Thing = game:GetService("HttpService"):JSONDecode(Thing).data[1]
local AvatarImage = Thing.imageUrl
local msg = {
   ["content"] = ( _G.Discord_UserID ~= "" and  _G.Discord_UserID ~= nil) and tostring("<@".._G.Discord_UserID..">") or " ",
   ["embeds"] = {
       {
           ["color"] = tonumber(tostring("0x4dffa6")), --decimal
           ["title"] = "successfully server hopped!",
           ["thumbnail"] = {
           },
           ["fields"] = {
                {
                   ["name"] = "new job id",
                   ["value"] = ""..game.JobId.."",
                   ["inline"] = true
                },
                {
                   ["name"] = "game name",
                   ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                   ["inline"] = true
                },
           },
           ['timestamp'] = DateTime.now():ToIsoDate()
       }
   }
}

if isfile("Workspace/readthis.txt") then
    request = http_request or request or HttpPost or syn.request
    request({Url = Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game.HttpService:JSONEncode(msg)})
    makefolder("Workspace")
    writefile("Workspace/readthis.txt", "true")
end