require("zUI/BaseUI")
require("zUI/Color")
Image = {}
Image.__index = Image
setmetatable(Image, {__index = BaseUI,__call = function(_,...) return Image.new(...) end})

function Image.new(path,x,y,sx,sy,rot,ox,oy,bgColor,borderColor,hasBg,hasBorder,displayed,clickTime)
	local img = love.graphics.newImage(path)
		img:setFilter("nearest","nearest")
	local base = BaseUI.new(x,y,img:getWidth(),img:getHeight(),bgColor,nil,borderColor,displayed)
	base.img = img
	base.path = base.path
	base.hasBackground = hasBg or false
	base.hasBorder = hasBorder or false
	base.iox = ox or 0
	base.ioy = oy or 0
	base.sx = sx or 1
	base.sy = sy or 1
	base.rot = rot or 0
	base.type = "Image"
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
	base.onclick = function(x,y,b) end
		base.onclickactive = false
	base.onhover = function(x,y) end
		base.onhoveractive = false
	base.ondeclick = function(x,y) end
		base.ondeclickactive = false
	return setmetatable(base, Image)
end

function Image:draw()
	if self.displayed then
		if self.parent~=nil then
			if self.parent.type=="Container" and self.parent.displayed then self.ofx,self.ofy = self.parent.x, self.parent.y  else
				self.ofx,self.ofy = 0,0
			end
		end
		self.x=self.ox+self.ofx self.y=self.oy+self.ofy
		if self.hasBackground then
		love.graphics.setColor(self.bgColor:toRGBA():unpack())
			love.graphics.polygon("fill",self.x,self.y,self.x+(self.width*self.sx),self.y,self.x+(self.width*self.sx),self.y+(self.height*self.sy),self.x,self.y+(self.height*self.sy))
		end if self.hasBorder then
		love.graphics.setColor(self.borderColor:toRGBA():unpack())
			love.graphics.polygon("line",self.x,self.y,self.x+(self.width*self.sx),self.y,self.x+(self.width*self.sx),self.y+(self.height*self.sy),self.x,self.y+(self.height*self.sy))
		end
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(self.img,self.x,self.y,self.rot,self.sx,self.sy,self.iox,self.ioy,0,0)
	end
end

function Image:addTo(parent)
	self.hasParent=true
	self.parent = parent
	if parent.type=="Container" then
		table.insert(parent.uiComps, self)
	end
end

function Image:update()
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
		if not self.entered and self.m.x>=self.x and self.m.x<=self.x+(self.width*self.sx) and self.m.y>=self.y and self.m.y<=self.y+(self.height*self.sy) then
			self.entered = true
			if self.onenteractive then
				self.onenter(self.m.x,self.m.y)
			end
		elseif self.entered then
			if self.m.x<self.x or self.m.x>self.x+(self.width*self.sx) or self.m.y<self.y or self.m.y>self.y+(self.height*self.sy) then
				self.entered = false
			end
		end
		--Exit
		if not self.exited then
			if self.m.x<self.x or self.m.x>self.x+(self.width*self.sx) or self.m.y<self.y or self.m.y>self.y+(self.height*self.sy) then
				self.exited = true
				if self.onexitactive then
					self.onexit(self.m.x,self.m.y)
				end
			end
		elseif self.exited and self.m.x>=self.x and self.m.x<=self.x+(self.width*self.sx) and self.m.y>=self.y and self.m.y<=self.y+(self.height*self.sy) then
			self.exited = false
		end
		--Hover
		if self.m.x>=self.x and self.m.x<=self.x+(self.width*self.sx) and self.m.y>=self.y and self.m.y<=self.y+(self.height*self.sy) then
			if self.onhoveractive then
				self.onhover(self.m.x,self.m.y)
			end
		end
		--Click
		if self.clicked then
			self.curTime = self.curTime+love.timer.getDelta()
			if self.curTime>=self.clickTime then
				self.curTime = 0
				self.clicked = false
				if self.ondeclickactive then
					self.ondeclick(self.m.x,self.m.y)
				end
			end
		end
		if self.m.b~="n" and self.m.clicked and self.m.x>=self.x and self.m.x<=self.x+(self.width*self.sx) and self.m.y>=self.y and self.m.y<=self.y+(self.height*self.sy) then
			self.clicked = true
			self.curTime = 0
			if self.onclickactive then
				self.onclick(self.m.x,self.m.y,self.m.b)
			end
		end
	end
	self:postupdate()
end

--Metamethods

function Image.__tostring(i)
	return i.path
end
