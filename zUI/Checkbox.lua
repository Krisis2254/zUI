<<<<<<< HEAD
local BaseUI = require("zUI/BaseUI")

local Checkbox = {}
Checkbox.__index = Checkbox
setmetatable(Checkbox, { __index = BaseUI, __call = function(_, ...) return Checkbox.new(...) end })

function Checkbox.new(x, y, z, width, height, bgColor, borderColor, checkColor, checkstyle, displayed, cornerRadius, shadowDisplayed)
	local base = BaseUI.new(x, y, z, width, height, bgColor, nil, borderColor, displayed, cornerRadius, shadowDisplayed)
	base.type = "Checkbox"
	base.checkstyle = checkstyle
	base.checked = false
	base.checkColor = checkColor
	return setmetatable(base, Checkbox)
end

function Checkbox:draw()
	if self:isDisplayed() then
		love.graphics.push()

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

			if self.checked then
				if self.checkstyle == "x" then
					love.graphics.setColor(self.checkColor:toRGBA():unpack())
					love.graphics.line(self.pos.x + 5, self.pos.y + 5, self.pos.x + self.dim.x - 5, self.pos.y + self.dim.y - 5)
					love.graphics.line(self.pos.x + 5, self.pos.y + self.dim.y - 5, self.pos.x + self.dim.x - 5, self.pos.y + 5)
				elseif self.checkstyle == "dot" then
					love.graphics.setColor(self.checkColor:toRGBA():unpack())
					love.graphics.circle("fill", self.pos.x + (self.dim.x / 2), self.pos.y + (self.dim.y / 2), (self.dim.x / 2) - (self.dim.x / 5), 250)
				end
			end
		love.graphics.pop()
	end
end

function Checkbox:toggle()
	self.checked = not self.checked
end

function Checkbox.__tostring(c)
	return tostring(c.checked)
end

return Checkbox
=======
local BaseUI = require("zUI/BaseUI")

local Checkbox = {}
Checkbox.__index = Checkbox
setmetatable(Checkbox, { __index = BaseUI, __call = function(_, ...) return Checkbox.new(...) end })

function Checkbox.new(x, y, z, width, height, bgColor, borderColor, checkColor, checkstyle, displayed, cornerRadius, shadowDisplayed)
	local base = BaseUI.new(x, y, z, width, height, bgColor, nil, borderColor, displayed, cornerRadius, shadowDisplayed)
	base.type = "Checkbox"
	base.checkstyle = checkstyle
	base.checked = false
	base.checkColor = checkColor
	return setmetatable(base, Checkbox)
end

function Checkbox:draw()
	if self:isDisplayed() then
		love.graphics.push()

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

			if self.checked then
				if self.checkstyle == "x" then
					love.graphics.setColor(self.checkColor:toRGBA():unpack())
					love.graphics.line(self.pos.x + 5, self.pos.y + 5, self.pos.x + self.dim.x - 5, self.pos.y + self.dim.y - 5)
					love.graphics.line(self.pos.x + 5, self.pos.y + self.dim.y - 5, self.pos.x + self.dim.x - 5, self.pos.y + 5)
				elseif self.checkstyle == "dot" then
					love.graphics.setColor(self.checkColor:toRGBA():unpack())
					love.graphics.circle("fill", self.pos.x + (self.dim.x / 2), self.pos.y + (self.dim.y / 2), (self.dim.x / 2) - (self.dim.x / 5), 250)
				end
			end
		love.graphics.pop()
	end
end

function Checkbox:toggle()
	self.checked = not self.checked
end

function Checkbox.__tostring(c)
	return tostring(c.checked)
end

return Checkbox
>>>>>>> origin/master
