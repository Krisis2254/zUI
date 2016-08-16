local BaseUI = require("zUI/BaseUI")
local Vec2 = require("zUI/Vec2")

local Image = {}
Image.__index = Image
setmetatable(Image, { __index = BaseUI, __call = function(_, ...) return Image.new(...) end })

function Image.new(texture, x, y, z, sx, sy, rot, ox, oy, bgColor, borderColor, displayed, quad)
	local img
	if type(texture) == "string" then
		img = love.graphics.newImage(texture)
		img:setFilter("nearest", "nearest")
	else
		img = texture
	end

	local base = BaseUI.new(x, y, z, img:getWidth(), img:getHeight(), bgColor, nil, borderColor, displayed)
	base.img = img
	base.path = type(texture) == "string" and texture or "UNKNOWN"
	base.image_origin = Vec2(ox or 0, oy or 0)
	base.scale = Vec2(sx or 1, sy or 1)
	base.rot = rot or 0
	base.type = "Image"
	base.quad = quad or love.graphics.newQuad(0, 0, base.img:getWidth(), base.img:getHeight(), base.img:getWidth(), base.img:getHeight())
	return setmetatable(base, Image)
end

function Image:draw()
	if self:isDisplayed() then
		love.graphics.push()

			if self.bgColor then
				love.graphics.setColor(self.bgColor:toRGBA():unpack())
				love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y, self.cornerRadius, self.cornerRadius)
			end

			if self.borderColor then
				love.graphics.setColor(self.borderColor:toRGBA():unpack())
				love.graphics.rectangle("line", self.pos.x, self.pos.y, self.dim.x, self.dim.y, self.cornerRadius, self.cornerRadius)
			end

			love.graphics.setColor(255,255,255,255)
			love.graphics.draw(self.img, self.quad, self.pos.x, self.pos.y, self.rot, self.scale.x, self.scale.y, self.image_origin.x, self.image_origin.y, 0, 0)

		love.graphics.pop()
	end
end

function Image.__tostring(i)
	return i.path
end

return Image
