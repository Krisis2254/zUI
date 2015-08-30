Mouse = {}
Mouse.__index = Mouse
setmetatable(Mouse, {__call = function(_,...) return Mouse.new(...) end})

function Mouse.new(continuous)
	return setmetatable({x = -1, y = -1, b = "n", c = continuous or false, clicked = false}, Mouse)
end

--Functions

function Mouse:update()
	self.x, self.y = love.mouse.getPosition()

	if self.c then
		if love.mouse.isDown("l") then 
			self.b = "l"
			self.clicked = true
		elseif love.mouse.isDown("r") then
			self.b = "r"
			self.clicked = true
		else
			self.b = "n"
			self.clicked = false
		end
	else
		if self.clicked then
			self.b = "n"
			if love.mouse.isDown("l") or love.mouse.isDown("r") then else
				self.clicked = false
			end
		else
			if love.mouse.isDown("l") or love.mouse.isDown("r") then
				if love.mouse.isDown("l") then self.b = "l" else self.b = "r" end
				self.clicked = true
			else
				self.b = "n"
			end
		end
	end
end

--Metafunctions

function Mouse.__tostring(a)
	return "("..a.x..", "..a.y..", "..a.b..")"
end
