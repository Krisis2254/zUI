local BaseUI = require("zUI/BaseUI")
local Vec2 = require("zUI/Vec2")

local TextLabel = {}
TextLabel.__index = TextLabel
setmetatable(TextLabel, { __index = BaseUI, __call = function(_, ...) return TextLabel.new(...) end })

function TextLabel.new(x, y, z, width, height, text, centered, font, bgColor, textColor, borderColor, displayed, cornerRadius)
	font = font or love.graphics.getFont()
	if width then
		afitw = false
	else
		width = font:getWidth(text)
		afitw = true
	end

	if height then
		afith = false
	else
		height = font:getHeight()
		afith = true
	end

	local base = BaseUI.new(x, y, z, width, height, bgColor, textColor, borderColor, displayed, cornerRadius)
	base.type = "TextLabel"
	base.text = text or ""
	base.fontdata = {}
	base.fontdata.font = font
	base.fontdata.size = Vec2(font:getWidth(base.text), font:getHeight())
	base.fontdata.centered = centered or false
	base.autofitW = afitw
	base.autofitH = afith
	return setmetatable(base, TextLabel)
end

function TextLabel:draw()
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
		love.graphics.pop()
	end
end

function TextLabel.__tostring(t)
	return t.text
end

return TextLabel
