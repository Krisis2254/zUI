local TextLabel = require("zUI/TextLabel")
local Vec2 = require("zUI/Vec2")

local TextField = {}
TextField.__index = TextField
setmetatable(TextField, { __index = TextLabel, __call = function(_, ...) return TextField.new(...) end })

function TextField.new(x, y, z, width, height, centered, cursorTime, displayCursor, maxLength, font, bgColor, textColor, borderColor, displayed, cornerRadius)
	local _ = ""
	maxLength = maxLength or 0
	for i = 1, maxLength + 1 do _ = _.."0" end

	font = font or love.graphics.getFont()
	if width then
		afitw = false
	else
		width = font:getWidth(_)
		afitw = true
	end

	if height then
		afith = false
	else
		height = font:getHeight()
		afith = true
	end

	local base = TextLabel.new(x, y, z, width, height, "", centered, font, bgColor, textColor, borderColor, displayed, cornerRadius)
	base.type = "TextField"
	base.cursorTime = cursorTime or 1
	base.currentTime = 0
	base.cursorOn = false
	base.displayCursor = displayCursor or false
	return setmetatable(base, TextField)
end

function TextField:update()
	self:preupdate()
	if self:isDisplayed() then
		self.m:update()
		self:calculatePosition()
		self:updateEntering()
		self:updateExiting()
		self:updateHovering()
		self:updateClicking()
		if self.displayCursor then
			self.currentTime = math.min(self.cursorTime, self.currentTime + love.timer.getDelta())
			if self.currentTime == self.cursorTime then self.currentTime = 0 self.cursorOn = not self.cursorOn end
		else
			self.currentTime = 0
			self.cursorOn = false
		end
	end
	self:postupdate()
end

function TextField:draw()
	if self:isDisplayed() then
		love.graphics.push()
			local tempfont = love.graphics.getFont()

			if self.bgColor then
				love.graphics.setColor(self.bgColor:toRGBA():unpack())
				love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y, self.cornerRadius, self.cornerRadius)
			end

			if self.borderColor then
				love.graphics.setColor(self.borderColor:toRGBA():unpack())
				love.graphics.rectangle("line", self.pos.x, self.pos.y, self.dim.x, self.dim.y, self.cornerRadius, self.cornerRadius)
			end

			love.graphics.setColor(self.textColor:toRGBA():unpack())
			love.graphics.setFont(self.fontdata.font)
				if self.fontdata.centered then
					love.graphics.printf(self.text, self.pos.x, ((self.dim.y / 2) - (self.fontdata.size.y / 2)) + self.pos.y, self.dim.x, "center")
				else
					love.graphics.printf(self.text, self.pos.x, self.pos.y, self.dim.x, "left")
				end
			love.graphics.setFont(tempfont)
			if self.cursorOn and self.displayCursor then
				love.graphics.setLineStyle("rough")
					love.graphics.line(self.pos.x + self.fontdata.size.x + 1, self.pos.y + 1, self.pos.x + self.fontdata.size.x + 1, self.pos.y + self.dim.y - 1)
				love.graphics.setLineStyle("smooth")
			end
		love.graphics.pop()
	end
end

return TextField
