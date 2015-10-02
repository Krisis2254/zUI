require("zUI/BaseUI")
require("zUI/Color")
--Container Class Setup
Container = {}
Container.__index = Container
setmetatable(Container, {__index=BaseUI,__call = function(_,...) return Container.new(...) end})

--Container Methods
function Container.new(x,y,width,height,bgColor,borderColor,hasBg,hasBorder,displayed,clickTime)
	local base = BaseUI.new(x,y,width,height,bgColor,nil,borderColor,displayed)
	base.type = "Container"
	base.uiComps = {}
	base.hasBackground = hasBg
	base.hasBorder = hasBorder
	base.clicked = false
	base.clickTime = clickTime or 1
	base.curTime = 0
		--Event Vars
	base.onenter = function(x,y) end
		base.onenteractive = false
		base.entered = false
	base.onexit = function(x,y) end
		base.onexitactive = false
		base.exited = false
	base.onclick = function(x,y,b) end
		base.onclickactive = false
	base.onhover = function(x,y) end
		base.onhoveractive = false
	base.ondeclick = function(x,y) end
		base.ondeclickactive = false
	return setmetatable(base, Container)
end

function Container:draw()
	if self.displayed then
		if self.parent~=nil then
			if self.parent.type=="Container" and self.parent.displayed then self.ofx,self.ofy = self.parent.x, self.parent.y  else
				self.ofx,self.ofy = 0,0
			end
		end
		self.x=self.ox+self.ofx self.y=self.oy+self.ofy
		if self.hasBackground then
		love.graphics.setColor(self.bgColor:toRGBA():unpack())
			love.graphics.polygon("fill",self.x,self.y,self.x+self.width,self.y,self.x+self.width,self.y+self.height,self.x,self.y+self.height)
		end if self.hasBorder then
		love.graphics.setColor(self.borderColor:toRGBA():unpack())
			love.graphics.polygon("line", self.x,self.y,self.x+self.width,self.y,self.x+self.width,self.y+self.height,self.x,self.y+self.height)
		end
		for _,v in ipairs(self.uiComps) do
			v:draw()
		end
	end
end

function Container:addTo(parent)
	self.hasParent=true
	self.parent = parent
	if parent.type=="Container" then
		table.insert(parent.uiComps, self)
	end
end

function Container:update()
	local flag = false
	if self.displayed then
		flag = true
		if self.hasParent then
			if self.parent.displayed then
				flag = true
			else
				flag = false
			end
		end
	end

	if flag then
		self:preupdate()
		self.m:update()
		--Enter
		if not self.entered and self.m.x>=self.x and self.m.x<=self.x+self.width and self.m.y>=self.y and self.m.y<=self.y+self.height then
			self.entered = true
			if self.onenteractive then
				self.onenter(self.m.x,self.m.y)
			end
		elseif self.entered then
			if self.m.x<self.x or self.m.x>self.x+self.width or self.m.y<self.y or self.m.y>self.y+self.height then
				self.entered = false
			end
		end
		--Exit
		if not self.exited then
			if self.m.x<self.x or self.m.x>self.x+self.width or self.m.y<self.y or self.m.y>self.y+self.height then
				self.exited = true
				if self.onexitactive then
					self.onexit(self.m.x,self.m.y)
				end
			end
		elseif self.exited and self.m.x>=self.x and self.m.x<=self.x+self.width and self.m.y>=self.y and self.m.y<=self.y+self.height then
			self.exited = false
		end
		--Hover
		if self.m.x>=self.x and self.m.x<=self.x+self.width and self.m.y>=self.y and self.m.y<=self.y+self.height then
			if self.onhoveractive then
				self.onhover(self.m.x,self.m.y)
			end
		end
		--Click
		if self.clicked then
			if self.onclickactive then
				self.onclick(self.m.x,self.m.y,self.m.b)
			end
			self.curTime = self.curTime+love.timer.getDelta()
			if self.curTime>=self.clickTime then
				self.curTime = 0
				self.clicked = false
				if self.ondeclickactive then
					self.ondeclick(self.m.x,self.m.y)
				end
			end
		end
		if self.m.b~="n" and self.m.clicked and self.m.x>=self.x and self.m.x<=self.x+self.width and self.m.y>=self.y and self.m.y<=self.y+self.height then
			self.clicked = true
			self.curTime = 0
			if self.onclickactive then
				self.onclick(self.m.x,self.m.y,self.m.b)
			end
		end
	end
	self:postupdate()
end

--Container Metamethods
function Container.__tostring(c)
	local str = "(x="..c.x..", y="..c.y..", width="..c.width..", height="..c.height..", type="..c.type..", uiComps={"
	for i=1, #c.uiComps-1 do
		if type(c.uiComps[i])=="number" then
			str = str..tostring(c.uiComps[i])..", "
		elseif type(c.uiComps[i])=="string" then
			str = str..'"'..tostring(c.uiComps[i])..'", '
		else
			str = str..tostring(c.uiComps[i])..", "
		end
	end
	return str..tostring(c.uiComps[#c.uiComps]).."})"
end
