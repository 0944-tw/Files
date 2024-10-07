--[[
MikuOS for LimeOS v3

==========================

Create Boot
loadlib("FileSystem").CreateFile(loadlib("FileSystem").GetOSDriveLetter()..":/boot.lua", "plaintext" "R-W-D", "System")
loadlib("FileSystem").WriteFile(loadlib("FileSystem").GetOSDriveLetter()..":/boot.lua", "", "System", true)


]]--

local Player = game.Players.LocalPlayer
local PlayerGui  = Player.PlayerGui

print("Hello " .. Player.UserId)
print("Booting MikuOS")

local MikuGUI = Instance.new("ScreenGui")
MikuGUI.DisplayOrder = 9
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1,0,1,0)
Frame.BackgroundColor3 = Color3.new(0,0,0)
Frame.Parent = PlayerGui
-- MikuCLI
local Console = Instance.new("TextLabel")
Console.Size = UDim2.new(1,0,1,-35)
Console.Parent = Frame
function getPath(instance)
	local path = ""

	local ins = instance

	repeat ins = ins["Parent"] path = path.."."..ins.Name until ins == game

	return path
end
local cd = game
local Echo = function(text)
	Console.Text = Console.Text + [[
	]] + text
end
local Exec = function(command)
	if command == "ls" then
		if typeof(cd) == "Instance" then
			Echo("File Lists of " .. command)
			for i,v in pairs(cd:GetChildren()) do
				Echo(v.Name)
			end
		end
	end
	if command == "pwd" then
		Echo(getPath(cd))
	end
end
local TextBox = Instance.new("TextBox")
TextBox.Font = Enum.Font.Code
TextBox.Size = UDim2.new(1,0,0,35)
TextBox.PlaceholderText = "Welcome to MikuTerm. Enter help for commands"
TextBox.Parent = Frame
TextBox.Position = UDim2.new(0,0,1,-35)

