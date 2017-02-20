<<<<<<< HEAD
local Mouse = require("zUI/Mouse")
local Vec2 = require("zUI/Vec2")
local Vec3 = require("zUI/Vec3")

local BaseUI = {}
BaseUI.__index = BaseUI
setmetatable(BaseUI, { __call = function(_, ...) return BaseUI.new(...) end })

BaseUI.display_events = {}

BaseUI.shadow_shader = love.graphics.newShader([[
    extern number border;
    extern vec2 pos;
    extern vec2 size;

    vec4 effect(vec4 color, Image tex, vec2 texc, vec2 screenc) {
        vec4 pixel = Texel(tex, texc);
        pixel.a = smoothstep(0.0, border, screenc.x - pos.x) * (1.0 - smoothstep(size.x - border, size.x, screenc.x - pos.x)) * smoothstep(0.0, border, screenc.y - pos.y) * (1.0 - smoothstep(size.y - border, size.y, screenc.y - pos.y));
        return pixel * color;
    }
]])

function BaseUI.new(x, y, z, width, height, bgColor, textColor, borderColor, displayed, cornerRadius, shadowDisplayed)
	return setmetatable( {
		pos = Vec3(x or 0, y or 0, z or 0),
		dim = Vec2(width or 0, height or 0),
		origin = Vec3(x or 0, y or 0, z or 0),
		offset = Vec3(0, 0, 0),
		bgColor = bgColor and bgColor:copy() or nil,
		textColor = textColor and textColor:copy() or nil,
		borderColor = borderColor and borderColor:copy() or nil,
		displayed = displayed or false,
		shadowDisplayed = shadowDisplayed or false,
		parent = nil,
		type = "BaseUI",
		clicked = false,
		cornerRadius = cornerRadius or 0,
		preupdate = function(self) end,
		postmouseupdate = function(self) end,
		postupdate = function(self) end,
		onenter = function(self, x, y) end,
			entered = false,
		onexit = function(self, x, y) end,
			exited = false,
		onhover = function(self, x, y) end,
		onclick = function(self, x, y, b) end,
		ondeclick = function(self, x, y) end,
		m = Mouse(false)
	}, BaseUI)
end

function BaseUI:isDisplayed()
	local flag = false
	if self.displayed then
		flag = true
		if self.parent then
			if self.parent.displayed then
				flag = true
			else
				flag = false
			end
		end
	end
	return flag
end

function BaseUI:calculatePosition()
	if self.parent then
		if self.parent.type=="Container" and self.parent.displayed then
			self.offset.x, self.offset.y = self.parent.pos.x, self.parent.pos.y
		else
			self.offset = Vec3(0, 0, 0)
		end
	end
	self.pos = self.origin + self.offset
end


function BaseUI:updateEntering()
	if not self.entered and (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self.entered = true
		self:onenter(self.m.pos.x, self.m.pos.y)
	elseif self.entered and (self.m.pos.x < self.pos.x) or (self.m.pos.x > self.pos.x + self.dim.x) or (self.m.pos.y < self.pos.y) or (self.m.pos.y > self.pos.y + self.dim.y) then
		self.entered = false
	end
end

function BaseUI:updateExiting()
	if not self.exited then
		if (self.m.pos.x < self.pos.x) or (self.m.pos.x > self.pos.x + self.dim.x) or (self.m.pos.y < self.pos.y) or (self.m.pos.y > self.pos.y + self.dim.y) then
			self.exited = true
			self:onexit(self.m.pos.x, self.m.pos.y)
		end
	elseif self.exited and (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self.exited = false
	end
end

function BaseUI:updateHovering()
	if (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self:onhover(self.m.pos.x, self.m.pos.y)
	end
end

function BaseUI:updateClicking()
	if self.clicked then
		self.clicked = false
		self:ondeclick(self.m.pos.x, self.m.pos.y)
	end
	if self.m.b~=-1 and not self.clicked and (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self.clicked = true
		self:onclick(self.m.pos.x, self.m.pos.y, self.m.b)
	end
end

function BaseUI:update()
	if self:isDisplayed() then
		self:preupdate()
		self.m:update()
		self:postmouseupdate()
		self:calculatePosition()
		self:updateEntering()
		self:updateExiting()
		self:updateHovering()
		self:updateClicking()
		self:postupdate()
	end
end

function BaseUI:draw()
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
		love.graphics.pop()
	end
end

function BaseUI:addTo(parent)
	if parent.type=="Container" then
		self.parent = parent
		table.insert(parent.children, self)
	end
end

function BaseUI.newDisplayEvent(displayfunction)
	table.insert(BaseUI.display_events, displayfunction)
end

function BaseUI.drawEvents()
	for i, v in ipairs(BaseUI.display_events) do
		v()
	end
	BaseUI.display_events = {}
end

function BaseUI:move(nx, ny, nz, relative)
	if not relative then
		self.origin = Vec3(nx, ny, nz)
	else
		self.origin = self.origin + Vec3(nx, ny, nz)
	end
end

function BaseUI:changeText(newtext)
	if self.text then
		self.text = newtext
		self.fontdata.size.x = self.fontdata.font:getWidth(self.text)
		self.fontdata.size.y = self.fontdata.font:getHeight()
		if self.autofitW then
			self.dim.x = self.fontdata.font:getWidth(self.text)
		end

		if self.autofitH then
			self.dim.y = self.fontdata.font:getHeight()
		end
	end
end

function BaseUI:changeFont(newfont)
	if self.fontdata then
		self.fontdata.font = newfont
		self.fontdata.size.x = newfont:getWidth(self.text)
		self.fontdata.size.y = newfont:getHeight()
	end
end

return BaseUI
=======
local Mouse = require("zUI/Mouse")
local Vec2 = require("zUI/Vec2")
local Vec3 = require("zUI/Vec3")

local BaseUI = {}
BaseUI.__index = BaseUI
setmetatable(BaseUI, { __call = function(_, ...) return BaseUI.new(...) end })

BaseUI.display_events = {}

BaseUI.shadow_shader = love.graphics.newShader([[
    extern number border;
    extern vec2 pos;
    extern vec2 size;

    vec4 effect(vec4 color, Image tex, vec2 texc, vec2 screenc) {
        vec4 pixel = Texel(tex, texc);
        pixel.a = smoothstep(0.0, border, screenc.x - pos.x) * (1.0 - smoothstep(size.x - border, size.x, screenc.x - pos.x)) * smoothstep(0.0, border, screenc.y - pos.y) * (1.0 - smoothstep(size.y - border, size.y, screenc.y - pos.y));
        return pixel * color;
    }
]])

function BaseUI.new(x, y, z, width, height, bgColor, textColor, borderColor, displayed, cornerRadius, shadowDisplayed)
	return setmetatable( {
		pos = Vec3(x or 0, y or 0, z or 0),
		dim = Vec2(width or 0, height or 0),
		origin = Vec3(x or 0, y or 0, z or 0),
		offset = Vec3(0, 0, 0),
		bgColor = bgColor and bgColor:copy() or nil,
		textColor = textColor and textColor:copy() or nil,
		borderColor = borderColor and borderColor:copy() or nil,
		displayed = displayed or false,
		shadowDisplayed = shadowDisplayed or false,
		parent = nil,
		type = "BaseUI",
		clicked = false,
		cornerRadius = cornerRadius or 0,
		preupdate = function(self) end,
		postmouseupdate = function(self) end,
		postupdate = function(self) end,
		onenter = function(self, x, y) end,
			entered = false,
		onexit = function(self, x, y) end,
			exited = false,
		onhover = function(self, x, y) end,
		onclick = function(self, x, y, b) end,
		ondeclick = function(self, x, y) end,
		m = Mouse(false)
	}, BaseUI)
end

function BaseUI:isDisplayed()
	local flag = false
	if self.displayed then
		flag = true
		if self.parent then
			if self.parent.displayed then
				flag = true
			else
				flag = false
			end
		end
	end
	return flag
end

function BaseUI:calculatePosition()
	if self.parent then
		if self.parent.type=="Container" and self.parent.displayed then
			self.offset.x, self.offset.y = self.parent.pos.x, self.parent.pos.y
		else
			self.offset = Vec3(0, 0, 0)
		end
	end
	self.pos = self.origin + self.offset
end


function BaseUI:updateEntering()
	if not self.entered and (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self.entered = true
		self:onenter(self.m.pos.x, self.m.pos.y)
	elseif self.entered and (self.m.pos.x < self.pos.x) or (self.m.pos.x > self.pos.x + self.dim.x) or (self.m.pos.y < self.pos.y) or (self.m.pos.y > self.pos.y + self.dim.y) then
		self.entered = false
	end
end

function BaseUI:updateExiting()
	if not self.exited then
		if (self.m.pos.x < self.pos.x) or (self.m.pos.x > self.pos.x + self.dim.x) or (self.m.pos.y < self.pos.y) or (self.m.pos.y > self.pos.y + self.dim.y) then
			self.exited = true
			self:onexit(self.m.pos.x, self.m.pos.y)
		end
	elseif self.exited and (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self.exited = false
	end
end

function BaseUI:updateHovering()
	if (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self:onhover(self.m.pos.x, self.m.pos.y)
	end
end

function BaseUI:updateClicking()
	if self.clicked then
		self.clicked = false
		self:ondeclick(self.m.pos.x, self.m.pos.y)
	end
	if self.m.b~=-1 and not self.clicked and (self.m.pos.x >= self.pos.x) and (self.m.pos.x <= self.pos.x + self.dim.x) and (self.m.pos.y >= self.pos.y) and (self.m.pos.y <= self.pos.y + self.dim.y) then
		self.clicked = true
		self:onclick(self.m.pos.x, self.m.pos.y, self.m.b)
	end
end

function BaseUI:update()
	if self:isDisplayed() then
		self:preupdate()
		self.m:update()
		self:postmouseupdate()
		self:calculatePosition()
		self:updateEntering()
		self:updateExiting()
		self:updateHovering()
		self:updateClicking()
		self:postupdate()
	end
end

function BaseUI:draw()
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
		love.graphics.pop()
	end
end

function BaseUI:addTo(parent)
	if parent.type=="Container" then
		self.parent = parent
		table.insert(parent.children, self)
	end
end

function BaseUI.newDisplayEvent(displayfunction)
	table.insert(BaseUI.display_events, displayfunction)
end

function BaseUI.drawEvents()
	for i, v in ipairs(BaseUI.display_events) do
		v()
	end
	BaseUI.display_events = {}
end

function BaseUI:move(nx, ny, nz, relative)
	if not relative then
		self.origin = Vec3(nx, ny, nz)
	else
		self.origin = self.origin + Vec3(nx, ny, nz)
	end
end

function BaseUI:changeText(newtext)
	if self.text then
		self.text = newtext
		self.fontdata.size.x = self.fontdata.font:getWidth(self.text)
		self.fontdata.size.y = self.fontdata.font:getHeight()
		if self.autofitW then
			self.dim.x = self.fontdata.font:getWidth(self.text)
		end

		if self.autofitH then
			self.dim.y = self.fontdata.font:getHeight()
		end
	end
end

function BaseUI:changeFont(newfont)
	if self.fontdata then
		self.fontdata.font = newfont
		self.fontdata.size.x = newfont:getWidth(self.text)
		self.fontdata.size.y = newfont:getHeight()
	end
end

return BaseUI
>>>>>>> origin/master
