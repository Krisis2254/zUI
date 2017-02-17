local Vec2 = require("zUI/Vec2")

local Mouse = {}
Mouse.__index = Mouse
setmetatable(Mouse, { __call = function(_,...) return Mouse.new(...) end })

function Mouse.new(continuous)
	return setmetatable( { pos = Vec2(0, 0), b = -1, c = continuous or false, clicked = false }, Mouse)
end

--Functions

function Mouse:update()
	self.pos = Vec2(love.mouse.getX(), love.mouse.getY())

	if self.c then
		if love.mouse.isDown(1) then
			self.b = 1
			self.clicked = true
		elseif love.mouse.isDown(2) then
			self.b = 2
			self.clicked = true
		else
			self.b = -1
			self.clicked = false
		end
	else
		if self.clicked then
			self.b = -1
			if love.mouse.isDown(1) or love.mouse.isDown(2) then else
				self.clicked = false
			end
		else
			if love.mouse.isDown(1) or love.mouse.isDown(2) then
				if love.mouse.isDown(1) then self.b = 1 else self.b = 1 end
				self.clicked = true
			else
				self.b = -1
			end
		end
	end
end

--Metafunctions

function Mouse.__tostring(a)
	return "("..a.pos.x..", "..a.pos.y..", "..a.b..")"
end

return Mouse
