local Load = function()
	local Player = game.Players.LocalPlayer
	local PlayerGui  = Player.PlayerGui
	local UserInputService = game:GetService("UserInputService")
	local Loadstring = require(119453727772130)
	--
	print("Hello " .. Player.UserId)
	print("Booting MikuOS")

	local MikuGUI = Instance.new("ScreenGui")
	MikuGUI.DisplayOrder = 99999
	MikuGUI.Parent = PlayerGui
	MikuGUI.Name = "MikuGUI"
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1,0,1,0)
	Frame.BackgroundColor3 = Color3.new(0,0,0)
	Frame.Parent = PlayerGui
	-- Miku
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
		local args = string.split(command," ")
		if args[1] == "ls" then
			if typeof(cd) == "Instance" then
				Echo("File Lists of " .. command)
				for i,v in pairs(cd:GetChildren()) do
					Echo(v.Name)
				end
			end
		elseif args[1] == "cd" then
			if not args[2] then
				Echo("Missing Arguments. Usage: cd `name: string` ")
			end
			if cd:FindFirstChild(args[2]) then
				cd = cd:FindFirstChild(args[2])
			else
				Echo("Instance Not Found")
			end
		elseif args[1] == "exec" then
			Echo("Executing your custom code.")
			table.remove(args,1)
			local code = table.concat(args,"")
			Echo("Code: " .. code )
			local sucess,message = Loadstring(code)()
			if sucess == nil then
				Echo("Runtime Error: " .. tostring(message))
			else
				Echo(message)
			end				 

		elseif args[1] == "wget" then
			Echo("Wow!GET")
		elseif args[1] == "pwd" then
			Echo(getPath(cd))
		else
			Echo("Unknown Command")
		end
	end
	local TextBox = Instance.new("TextBox")
	TextBox.Font = Enum.Font.Code
	TextBox.Size = UDim2.new(1,0,0,35)
	TextBox.PlaceholderText = "Welcome to MikuTerm. Enter help for commands"
	TextBox.Parent = Frame
	TextBox.Position = UDim2.new(0,0,1,-35)

	UserInputService.InputBegan:Connect(function(iobject)
		if iobject.KeyCode == Enum.KeyCode.Return then
			Exec(TextBox.Text)
			TextBox.Text = "Executed at " .. os.time()
			TextBox.Text = "" 
		end
	end)
end
return Load
