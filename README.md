# WinFormAPI
An LUA API based on C#.NET Winforms. Created by CarterPoe(GameChamp) Please credit if used

Example
![image](https://user-images.githubusercontent.com/39221871/180582509-2b3d0726-c156-424e-81e7-b7f8ac1240d9.png)
```lua
function using(pkgn) file.Write( "\\using/json.lua", http.Get( "https://raw.githubusercontent.com/G-A-Development-Team/libs/main/json.lua" ) ) LoadScript("\\using/json.lua") local pkg = json.decode(http.Get("https://raw.githubusercontent.com/G-A-Development-Team/Using/main/using.json"))["pkgs"][ pkgn ] if pkg ~= nil then file.Write( "\\using/" .. pkgn .. ".lua", http.Get( pkg ) ) LoadScript("\\using/" .. pkgn .. ".lua") else print("[using] package doesn't exist. {" .. pkgn .. "}") end end


using "Move-Resize"
using "WinFormLib"
using "WinFormColors"
using "WinFormToolbox"
using "WinForm"

local Form1 = {
	Name = "Form1",
	Interface = "Form",
	Size = size(900, 529),
	Location = point(0, 0),
	MinimumSize = size(400, 350),
	MaximumSize = size(1500, 800),
	DragBounds = 30,
	BorderStyle = "Sizable", --None
	WinStyle = 11, -- 10
	Visible = true,
	
	BackColor = SystemColors.Control,
	TitleBarColor = SystemColors.White,
	ForeColor = SystemColors.Black,
	
	Icon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/Icon.png",
	LoadedIcon = nil,
	
	Font = {
		Name = "Microsoft Sans Serif",
		Size = 15,
		LoadedFont = nil,
	},

	Controls = {},
	Update = function(props)
		--Load Font
		props.Font.LoadedFont = draw.CreateFont(props.Font.Name, props.Font.Size)
		--Load Icon
		local iconRGBA, iconWidth, iconHeight = common.DecodePNG(http.Get(props.Icon))
		local iconTexture = draw.CreateTexture(iconRGBA, iconWidth, iconHeight)
		props.LoadedIcon = iconTexture
		return props
	end,
	
}

Form1.Initialize = function()
	local label = Toolbox.Label()
	label.Properties.Name = "A Label"
	label.Properties.Font.Size = 50
	print(label.Properties.Name)
	
	local button1 = Toolbox.Button()
	button1.Properties.Text = "Click Me"
	button1.Properties.Name = "Activate"
	button1.Properties.Location = point(50,50)
	return {
		label,
		button1,
	}
end

Form1.Load = function()

end

Form1 = Application.Run(Form1)

local ebtn_misc = gui.Reference("MISC");
local ebtn_gui = gui.Tab(ebtn_misc, "ebtn_gui", "Example Button");

Form1.Controls[Form1.Controls.Find("A Label")].Events.Register("MouseHover", function(mouseX, mouseY)
	
end)

-- Creating the object with a function embeded
local ebtn_button = gui.Button(ebtn_gui, "Clicky Clicky! #1", function()
	Form1.Controls[Form1.Controls.Find("Activate")].Properties.Location = point(100, 150)
	Form1.Size = size(400,650)
	Form1.Controls[Form1.Controls.Find("Activate")].Events.Register("MouseClick", function (mouseX, mouseY)
		print("added yo")
	end)
end)
```
