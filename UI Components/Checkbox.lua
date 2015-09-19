require("zUI/BaseUI")
require("zUI/Color")
Checkbox = {}
Checkbox.__index = Checkbox
setmetatable(Checkbox, { __index=BaseUI,__call = function(_,...) return Checkbox.new(...) end})

--Methods

function Checkbox.new(x,y,width,height,bgColor,borderColor,checkColor,hasBg,hasBorder,checkstyle,displayed)
	local base = BaseUI.new(x,y,width,height,bgColor,nil,borderColor,displayed)
	base.type = "Checkbox"
	base.hasBackground = hasBg
	base.hasBorder = hasBorder
	base.checkstyle = checkstyle
	base.checked = false
	base.checkColor = checkColor
	base.clicked = false
	base.clickTime = clickTime
	base.curTime = 0
		--Event Vars
	base.onenter = function(x,y) end
		base.onenteractive = false
		base.entered = false
	base.onexit = function(x,y) end
		base.onexitactive = false
		base.exited = false
	base.onclick = function(x,y,b) base:toggle() end --Defaults to toggling.
		base.onclickactive = false
	base.onhover = function(x,y) end
		base.onhoveractive = false
	base.ondeclick = function(x,y) end
		base.ondeclickactive = false
	return setmetatable(base,Checkbox)
end

function Checkbox:draw()
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
		end if self.checked then
			if self.checkstyle=="x" then
			love.graphics.setColor(self.checkColor:toRGBA():unpack())
				love.graphics.line(self.x+1,self.y+1,self.x+self.width-1,self.y+self.height-1)
				love.graphics.line(self.x+1,self.y+self.height-1,self.x+self.width-1,self.y+1)
			elseif self.checkstyle=="dot" then
				love.graphics.setColor(self.checkColor:toRGBA():unpack())
					love.graphics.circle("fill",self.x+(self.width/2),self.y+(self.height/2),(self.width/2)-(self.width/5),250)
			end
		end
	end
end

function Checkbox:addTo(parent)
	self.parent = parent
	if parent.type=="Container" then
		table.insert(parent.uiComps, self)
	end
end

function Checkbox:update()
	local flag = false
	if self.displayed then
		flag = true
		if type(self.parent)~=nil then
			if self.parent.displayed then
				flag = true
			else
				flag = false
			end
		end
	end

	if flag then
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
end

function Checkbox:toggle()
	if self.checked then
		self.checked = false
	else
		self.checked = true
	end
end

--Metamethods

function Checkbox.__tostring(c)
	return tostring(c.checked)
end
