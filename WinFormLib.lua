function size(w, h)
	return {
		Width = w,
		Height = h,
	}
end

function point(x, y)
	return {
		X = x,
		Y = y,
	}
end

function color(r, g, b, a)
	return {r, g, b, a}
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. '\n'
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

--ffi.cdef([[
--    int ShowCursor(bool bShow);
--]])
--
--function ShowCursor(bool)
--	ffi.C.ShowCursor(bool)
--	print(bool)
--end

function MouseInLocation(X, Y, W, H)
	local mouseX, mouseY = input.GetMousePos()
	if mouseX >= X and mouseX <= X + W and mouseY >= Y and mouseY <= Y + H then
		return true
	else
		return false
	end
end

function center(itemW, itemH, W, H)
	return (W/2)-(itemW/2), (H/2)-(itemH/2)
end