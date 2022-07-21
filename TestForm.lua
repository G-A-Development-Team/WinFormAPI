RunScript("Luas/Test/WinFormLib.lua")
RunScript("Luas/Test/WinFormColors.lua")
RunScript("Luas/Test/WinFormToolbox.lua")
RunScript("Luas/Test/WinForm.lua")

local Form1 = {
	Name = "Form1",
	Interface = "Form",
	Size = size(900, 529),
	Location = point(0, 0),
	MinimumSize = size(400, 350),
	MaximumSize = size(1500, 800),
	DragBounds = 30,
	
	BorderStyle = "Sizable", --None
	WinStyle = 11,
	ClickThru = false,
	Visible = true,
	
	BackColor = SystemColors.Control,
	TitleBarColor = SystemColors.White,
	ForeColor = SystemColors.Black,
	
	Icon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/Icon.png",
	LoadedIcon = nil,
	
	CursorIcon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/apnkp-iufgd-001.png",
	LoadedCursorIcon = nil,
	CursorEnabled = false,
	
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
		
		--Load Cursor Icon
		local cursorIconRGBA, cursorIconWidth, cursorIconHeight = common.DecodePNG(http.Get(props.CursorIcon))
		local cursorIconTexture = draw.CreateTexture(cursorIconRGBA, cursorIconWidth, cursorIconHeight)
		props.LoadedCursorIcon = cursorIconTexture
		
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
	--local label2 = Toolbox.Label()
	--label2.Properties.Name = "A Labelssssssssssss"
	--label2.Properties.Font.Size = 50
	
	--Form1.Controls.Add(label2)
	--print(dump(Form1.Controls))
	--Form1.BackColor = SystemColors.Black
	--Form1.Name = "FUCK"
	--Form1.ForeColor = SystemColors.White
	--table.insert(Form1.Controls, label2)
	--button1.Properties.Location = point(100, 150)
	Form1.Controls[Form1.Controls.Find("Activate")].Properties.Location = point(100, 150)
	Form1.Size = size(400,650)
	Form1.Controls[Form1.Controls.Find("Activate")].Events.Register("MouseClick", function (mouseX, mouseY)
		print("added yo")
	end)
end)