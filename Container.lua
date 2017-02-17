local BaseUI = require("zUI/BaseUI")

local Container = {}
Container.__index = Container
setmetatable(Container, { __index = BaseUI, __call = function(_, ...) return Container.new(...) end })

function Container.new(x, y, z, width, height, bgColor, borderColor, displayed, cornerRadius, shadowDisplayed)
	local base = BaseUI.new(x, y, z, width, height, bgColor, nil, borderColor, displayed, cornerRadius, shadowDisplayed)
	base.type = "Container"
	base.children = {}

	return setmetatable(base, Container)
end

function Container:draw()
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

			for _, v in ipairs(self.children) do
				v:draw()
			end
		love.graphics.pop()
	end
end

function Container.__tostring(c)
	local str = "(x = "..c.pos.x..", y = "..c.pos.y..", z = "..c.pos.z..", width = "..c.dim.x..", height = "..c.dim.y..", type = "..c.type..", children = {"
	for i, v in ipairs(c.children) do
		str = str..tostring(v)
		if i~=#c.children then str = str..", " end
	end
	return str
end

return Container
