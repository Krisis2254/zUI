local BaseUI = require("zUI/BaseUI")

local Container = {}
Container.__index = Container
setmetatable(Container, { __index=BaseUI, __call = function(_, ...) return Container.new(...) end })

function Container.new(x, y, z, width, height, bgColor, borderColor, displayed, cornerRadius)
	local base = BaseUI.new(x, y, z, width, height, bgColor, nil, borderColor, displayed, cornerRadius)
	base.type = "Container"
	base.children = {}

	return setmetatable(base, Container)
end

function Container:draw()
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
