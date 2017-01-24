local TextLabel = require("zUI/TextLabel")
local Vec2 = require("zUI/Vec2")

local TextField = {}
TextField.__index = TextField
setmetatable(TextField, { __index = TextLabel, __call = function(_, ...) return TextField.new(...) end })

function TextField.new(x, y, z, width, height, centered, cursorTime, displayCursor, maxLength, font, bgColor, textColor, borderColor, displayed, cornerRadius, shadowDisplayed)
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

	local base = TextLabel.new(x, y, z, width, height, "", centered, font, bgColor, textColor, borderColor, displayed, cornerRadius, shadowDisplayed)
	base.type = "TextField"
	base.cursorTime = cursorTime or 1
	base.currentTime = 0
	base.cursorOn = false
	base.displayCursor = displayCursor or false
	return setmetatable(base, TextField)
end

function TextField:update()
	if self:isDisplayed() then
		self.preupdate()
		self.m:update()
		self:postmouseupdate()
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
		self:postupdate()
	end
end

function TextField:draw()
	if self:isDisplayed() then
		love.graphics.push()
			local tempfont = love.graphics.getFont()

			if self.shadowDisplayed then
				self.shadow_shader:send("border", 8 * self.pos.z)
				self.shadow_shader:send("pos", {self.pos.x - (8 * self.pos.z) / 2, self.pos.y - (8 * self.pos.z) / 2 + 4 * self.pos.z})
				self.shadow_shader:send("size", {self.dim.x + (8 * self.pos.z), self.dim.y + (8 * self.pos.z)})
				love.graphics.setShader(self.shadow_shader)
					love.graphics.setColor(0, 0, 0, 51 * (self.bgColor and self.bgColor:toRGBA().a or 255) / 255)
					love.graphics.rectangle("fill", self.pos.x - (8 * self.pos.z) / 2, self.pos.y - (8 * self.pos.z) / 2 + 4 * self.pos.z, self.dim.x + (8 * self.pos.z), self.dim.y + (8 * self.pos.z), self.cornerRadius, self.cornerRadius)
				love.graphics.setShader()
				self.shadow_shader:send("border", 20 * self.pos.z)
				self.shadow_shader:send("pos", {self.pos.x - (20 * self.pos.z) / 2, self.pos.y - (20 * self.pos.z) / 2 + 6 * self.pos.z})
				self.shadow_shader:send("size", {self.dim.x + (20 * self.pos.z), self.dim.y + (20 * self.pos.z)})
				love.graphics.setShader(self.shadow_shader)
					love.graphics.setColor(0, 0, 0, 48 * (self.bgColor and self.bgColor:toRGBA().a or 255) / 255)
					love.graphics.rectangle("fill", self.pos.x - (20 * self.pos.z) / 2, self.pos.y - (20 * self.pos.z) / 2 + 6 * self.pos.z, self.dim.x + (20 * self.pos.z), self.dim.y + (20 * self.pos.z), self.cornerRadius, self.cornerRadius)
				love.graphics.setShader()
			end

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
				love.graphics.setLineStyle("rough") --FIX THIS
					love.graphics.line((self.fontdata.size.x % self.dim.x) + self.pos.x + 1, self.pos.y + (self.dim.y * (math.floor(self.fontdata.size.x / self.dim.x))) + 1, (self.fontdata.size.x % self.dim.x) + self.pos.x + 1, self.pos.y + self.dim.y + (self.dim.y * (math.floor(self.fontdata.size.x / self.dim.x))) - 1)
				love.graphics.setLineStyle("smooth")
			end
		love.graphics.pop()
	end
end

return TextField
