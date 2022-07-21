Toolbox = {
	Label = function()
		local Props = {
			Name = "Label",
			Text = "A Label",
			Location = point(25, 50),
			Size = size(75, 23),
			
			Font = {
				Name = "Microsoft Sans Serif",
				Size = 15,
				LoadedFont = nil,
			},
			ForeColor = SystemColors.Black,
		}
		local RegEvens = {
			MouseHover = nil,
		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				--Label
				draw.SetFont(props.Font.LoadedFont)
				draw.Color(unpack(props.ForeColor))
				local Tw, Th = draw.GetTextSize(props.Text)
				props.Size = size(Tw + props.Font.Size, Th + props.Font.Size)
				draw.TextShadow(X + 8, Y + 15, props.Text)
			end,
			Register = function(event, callback)
				if event == "MouseHover" then
					RegEvens.MouseHover = callback
				end
			end,
			MouseHover = function(mouseX, mouseY, X, Y, W, H, props)
				props.BackColor = SystemColors.Black
			end,
			Click = function(mouseX, mouseY, X, Y, W, H, props)
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			RegisteredEvents = RegEvens,
			Events = Evens,
			OverridedEvents = {},
			
			Update = function(props)
				props.Font.LoadedFont = draw.CreateFont(props.Font.Name, props.Font.Size, props.Font.Size)
				
				return props
			end,
		}
	end,
	PictureBox = function()
		local Props = {
			Name = "Picturebox",
			Location = point(0, 0),
			Size = size(75, 23),
			Icon = "",
			LoadedIcon = nil,
			Visible = true,
		}
		local RegEvens = {
			MouseHover = nil,
		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X =  X + props.Location.X
				Y =  Y + props.Location.Y
				
				--Icon
				if props.Visible then
					draw.Color(255, 255, 255, 255)
					draw.SetTexture(props.LoadedIcon)
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					draw.SetTexture(nil)
				end
			end,
			Register = function(event, callback)
				if event == "MouseHover" then
					RegEvens.MouseHover = callback
				end
			end,
			MouseHover = function(mouseX, mouseY, X, Y, W, H, props)
				if props.Visible then
					props.BackColor = SystemColors.Black
				end
			end,
			Click = function(mouseX, mouseY, X, Y, W, H, props)
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			RegisteredEvents = RegEvens,
			Events = Evens,
			OverridedEvents = {},
			
			Update = function(props)
				
				local iconRGBA, iconWidth, iconHeight = common.DecodePNG(http.Get(props.Icon))
				local iconTexture = draw.CreateTexture(iconRGBA, iconWidth, iconHeight)
				props.LoadedIcon = iconTexture
				
				return props
			end,
		}
	end,
	Button = function()
		local Props = {
			Name = "Button",
			Text = "A Button",
			Size = size(75, 23),
			Location = point(0, 0),
			Visible = false,
			
			Font = {
				Name = "Microsoft Sans Serif",
				Size = 15,
				LoadedFont = nil,
			},
			ForeColor = SystemColors.Black,
			BackColor = SystemColors.Button,
			BorderColor = SystemColors.DarkGrey,
		}
		local RegEvens = {
			MouseHover = nil,
			MouseClick = nil,
		}
		local OverEvens = {
			Draw = nil,
			MouseHover = nil,
		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				--Background
				draw.Color(unpack(props.BackColor))
				draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				
				--Border
				draw.Color(unpack(props.BorderColor))
				draw.OutlinedRect(X, Y, X + props.Size.Width, Y + props.Size.Height)

				--Label
				draw.SetFont(props.Font.LoadedFont)
				local Tw, Th = draw.GetTextSize(props.Text)
				local centerX, centerY = center(Tw, Th, props.Size.Width, props.Size.Height)
				
				draw.Color(unpack(props.ForeColor))
				draw.Text(X + centerX, Y + centerY, props.Text)
				
			end,
			MouseHover = function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				--Background
				draw.Color(unpack(SystemColors.ButtonHighlight))
				draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				
				--Border
				draw.Color(unpack(SystemColors.ButtonHighlightBorder))
				draw.OutlinedRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
			end,
			Register = function(event, callback)
				if event == "MouseHover" then
					RegEvens.MouseHover = callback
				end
				if event == "MouseClick" then
					RegEvens.MouseClick = callback
				end
			end,
			Override = function(event, callback)
				if event == "Draw" then
					OverEvens.Draw = callback
				end
				if event == "MouseHover" then
					OverEvens.MouseHover = callback
				end
			end,
			Click = function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				--Background
				if props.Visible then
					draw.Color(unpack(SystemColors.ButtonClick))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				end
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			Events = Evens,
			RegisteredEvents = RegEvens,
			OverridedEvents = OverEvens,
			
			Update = function(props)
				props.Font.LoadedFont = draw.CreateFont(props.Font.Name, props.Font.Size, props.Font.Size)
				
				return props
			end,
		}
	end,
}