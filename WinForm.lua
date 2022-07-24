local Forms = {}

callbacks.Register("Draw", function()

end)

callbacks.Register("Unload", function()
	for i = 1, #windows do
		local window = windows[i]
		for i = 1, #Forms do
			local form = Forms[i]
			if window.Name == form.Name then
				windows[i] = nil
			end
		end
	end
end)

WinWindow = {
	Draw = {
		Background = function(Form, X, Y, W, H)
			if Form.BorderShadow then
				draw.Color(unpack(Form.BorderShadowColor));
				draw.ShadowRect(X, Y, X + W, Y + H, Form.BorderShadowRadius)
			end
			if Form.WinStyle == 11 then
				draw.Color(unpack(Form.BackColor))
				draw.RoundedRectFill(X, Y, X + W, Y + H, 6, 6, 6, 6, 6)
			end
			if Form.WinStyle == 10 then
				draw.Color(unpack(Form.BackColor))
				draw.FilledRect(X, Y, X + W, Y + H)
			end

		end,
		TitleBar = function(Form, X, Y, W, H)
			if Form.BorderStyle == "Sizable" then
				if Form.WinStyle == 11 then
					--Titlebar
					draw.Color(unpack(Form.TitleBarColor))
					draw.RoundedRectFill(X, Y, X + W, Y + 30, 6, 5, 5, 0, 0)
				end
				if Form.WinStyle == 10 then
					--Titlebar
					draw.Color(unpack(Form.TitleBarColor))
					draw.FilledRect(X, Y, X + W, Y + 30)
				end
				--Title
				draw.SetFont(Form.Font.LoadedFont)
				draw.Color(unpack(Form.ForeColor))
				draw.Text(X + 34, Y + 10, Form.Name)
				
				--Title Icon
				draw.Color(255, 255, 255, 255)
				draw.SetTexture(Form.LoadedIcon)
				draw.FilledRect(X + 10, Y + 8, X + 25, Y + 23)
				draw.SetTexture(nil)
			
				
			end
		end,
	},
}

Application = {
	Run = function(Form)
		if Form.Interface == "Form" then
			if Form.Update ~= nil then
				Form = Form.Update(Form)
			end
			local Controls = Form.Initialize()
			
			Controls["Add"] = function(control)
				control.Properties = control.Update(control.Properties)
				table.insert(Controls, control)
			end
			
			Controls["Find"] = function(name)
				for i = 1, #Controls do
					local control = Controls[i]
					if control.Properties.Name == name then
						return i
					end
				end
			end
			
			local button_close = Toolbox.Button()
			button_close.Properties.Size = size(45, 30)
			button_close.Properties.Name = "CloseBtn"
			
			local button_maximize = Toolbox.Button()
			button_maximize.Properties.Size = size(45, 30)
			button_maximize.Properties.Name = "MaxBtn"
			
			local picturebox_close = Toolbox.PictureBox()
			
			picturebox_close.Properties.Name = "pb_close"
			picturebox_close.Properties.Size = size(11,11)
			picturebox_close.Properties.Icon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/close.png"
			
			local picturebox_max = Toolbox.PictureBox()
			
			picturebox_max.Properties.Name = "pb_max"
			picturebox_max.Properties.Size = size(11,11)
			picturebox_max.Properties.Icon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/maximize.png"
			
			--picturebox_close.Properties = picturebox_close.Events.Update(picturebox_close.Properties)
			
			button_close.Events.Override("Draw", function(X, Y, W, H, props, Form)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				if Form.BorderStyle == "Sizable" then
					--draw.Color(unpack(SystemColors.Black))
					--draw.FilledRect(X + props.Location.X, Y + props.Location.Y, X + props.Size.Width, Y + props.Size.Height)
					
					if Form.WinStyle == 11 then
						draw.Color(unpack(Form.TitleBarColor))
						draw.RoundedRectFill(X, Y, X + props.Size.Width, Y + props.Size.Height, 7, 0, 7, 0, 0)
					end
					if Form.WinStyle == 10 then
						draw.Color(unpack(Form.TitleBarColor))
						draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					end
					Form.Controls[Form.Controls.Find("pb_close")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("pb_close")].Properties.Location = point(props.Location.X + 17,props.Location.Y + 9)
				else
					Form.Controls[Form.Controls.Find("pb_close")].Properties.Visible = false
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = false
				end
			end)
			
			button_close.Events.Override("MouseHover", function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				if Form.BorderStyle == "Sizable" then
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = true
					if Form.WinStyle == 11 then
						draw.Color(unpack(SystemColors.TitleBarControlCloseHighlight))
						draw.RoundedRectFill(X, Y, X + props.Size.Width, Y + props.Size.Height, 6, 0, 6, 0, 0)
					end
					if Form.WinStyle == 10 then
						draw.Color(unpack(SystemColors.TitleBarControlCloseHighlight))
						draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					end
				else
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = false
				end
			end)
			button_close.Events.Register("MouseClick", function(mouseX, mouseY)
				if Form.BorderStyle == "Sizable" then
					Form.Visible = not Form.Visible
				end
			end)
			
			button_maximize.Events.Override("Draw", function(X, Y, W, H, props, Form)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				if Form.BorderStyle == "Sizable" then
					--draw.Color(unpack(SystemColors.Black))
					--draw.FilledRect(X + props.Location.X, Y + props.Location.Y, X + props.Size.Width, Y + props.Size.Height)
					
					draw.Color(unpack(Form.TitleBarColor))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					
					Form.Controls[Form.Controls.Find("MaxBtn")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("pb_max")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("pb_max")].Properties.Location = point( props.Location.X + 17,props.Location.Y+9)
				else
					Form.Controls[Form.Controls.Find("pb_max")].Properties.Visible = false
					Form.Controls[Form.Controls.Find("MaxBtn")].Properties.Visible = false
				end
			end)
			
			button_maximize.Events.Register("MouseClick", function(mouseX, mouseY)
				if Form.BorderStyle == "Sizable" then
					Form.Size = Form.MaximumSize -100
				end
			end)
			
			button_maximize.Events.Override("MouseHover", function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				if Form.BorderStyle == "Sizable" then
					draw.Color(unpack(SystemColors.TitleBarControlHighlight))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				end
			end)
			
			Controls.Add(button_close)
			Controls.Add(button_maximize)
			Controls.Add(picturebox_close)
			Controls.Add(picturebox_max)
			
			for i = 1, #Controls do
				local control = Controls[i]
				if Controls[i].Interface == "Control" then
					Controls[i].Properties = control.Update(control.Properties)
				end
			end
			
			if Form.Load ~= nil then
				Form.Load()
			end
			
			local Resizable = false
			
			if Form.BorderStyle == "Sizable" then
				Resizable = true
			end
			
			if Form.BorderStyle == "None" then
				Resizable = false
			end
			Form.Dragging = false
			local tbl = {
				Name = Form.Name,
				Form = Form,
				X = Form.Location.X,
				Y = Form.Location.Y,
				W = Form.Size.Width,
				H = Form.Size.Height,
				MinW = Form.MinimumSize.Width,
				MinH = Form.MinimumSize.Height,
				MaxW = Form.MaximumSize.Width,
				MaxH = Form.MaximumSize.Height,
				Resize = Resizable,
				Move = Resizable,
				
				BoundsHeight = Form.DragBounds,
				
				Draw = function(X, Y, W, H)

					if Form.Visible ~= true then
						return
					end
					WinWindow.Draw.Background(Form, X, Y, W, H)
					WinWindow.Draw.TitleBar(Form, X, Y, W, H)
					
					if MouseInLocation(X, Y, W, H) then
						if Form.CursorEnabled == false then
						
							Form.CursorEnabled = true
						end
						--draw.Color(255, 255, 255, 255)
						--draw.SetTexture(Form.LoadedCursorIcon)
						--draw.FilledRect(mouseX, mouseY, mouseX + 33, mouseY + 33)
						--draw.SetTexture(nil)
					else
						if Form.CursorEnabled == true then
							Form.CursorEnabled = false
						end
					end
					
					Controls[Controls.Find("CloseBtn")].Properties.Location = point(W - Controls[Controls.Find("CloseBtn")].Properties.Size.Width, 0)
					Controls[Controls.Find("MaxBtn")].Properties.Location = point(W - (Controls[Controls.Find("MaxBtn")].Properties.Size.Width * 2), 0)
					
					for i = 1, #Controls do
						local control = Controls[i]
						if Controls[i].Interface == "Control" then
							if control.OverridedEvents.Draw ~= nil then
								control.OverridedEvents.Draw(X, Y, W, H, control.Properties, Form)
							else
								control.Events.Draw(X, Y, W, H, control.Properties)
							end
							
							if MouseInLocation(control.Properties.Location.X + X, control.Properties.Location.Y + Y, control.Properties.Size.Width, control.Properties.Size.Height) then
								local mouseX, mouseY = input.GetMousePos()
								
								--Registered Events
								if control.OverridedEvents.MouseHover ~= nil then
									control.OverridedEvents.MouseHover(mouseX, mouseY, X, Y, W, H, control.Properties)
								else
									if control.Events.MouseHover ~= nil then
										control.Events.MouseHover(mouseX, mouseY, X, Y, W, H, control.Properties)
									end
								end
								
								if control.RegisteredEvents.MouseHover ~= nil then
									control.RegisteredEvents.MouseHover(mouseX, mouseY)
								end
								
								if input.IsButtonDown(1) then
									if control.Events.Click ~= nil then
										control.Events.Click(mouseX, mouseY, X, Y, W, H, control.Properties)
									end
								end
								
								if input.IsButtonReleased(1) then
									if control.RegisteredEvents.MouseClick ~= nil then
										control.RegisteredEvents.MouseClick(mouseX, mouseY)
									end
								end
							end

						end
					end
				end,
			}
			
			table.insert(windows, tbl)
			table.insert(Forms, tbl)
			
			Form.Controls = Controls
			return Form
		end
	end,
}