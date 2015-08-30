require"zUI/BaseUI"
Button = {}
Button.__index = Button
setmetatable(Button,{__index=BaseUI,__call=function(_,...) return Button.new(...) end})

function Button.new(x,y,width,height,text,centered,font,bgColor,textColor,borderColor,hasBg,hasText,hasBorder,displayed,clickTime)
	if width==nil then
		width = font:getWidth(text)
	end if height==nil then
		height = font:getHeight()
	end 
	local base = BaseUI.new(x,y,width,height,bgColor,textColor,borderColor,displayed)
	base.type = "Button"
	base.text = text
	base.hasBackground = hasBg
	base.hasText = hasText
	base.hasBorder = hasBorder
	base.fontData = {}
	base.fontData.font = font
	base.fontData.wSize = font:getWidth(text)
	base.fontData.hSize = font:getHeight()
	base.fontData.centered = centered
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
	return setmetatable(base,Button)
end

function Button:draw()
	if self.displayed then
		local tempfont = love.graphics.getFont()
		if self.parent~=nil then
			if self.parent.type=="Container" and self.parent.displayed then self.ofx,self.ofy = self.parent.x, self.parent.y  else
				self.ofx,self.ofy = 0,0
			end
		end
		self.x=self.ox+self.ofx self.y=self.oy+self.ofy
		if self.hasBackground then
		love.graphics.setColor(self.bgColor)
			love.graphics.polygon("fill",self.x,self.y,self.x+self.width,self.y,self.x+self.width,self.y+self.height,self.x,self.y+self.height)
		end if self.hasBorder then
		love.graphics.setColor(self.borderColor)
			love.graphics.polygon("line", self.x,self.y,self.x+self.width,self.y,self.x+self.width,self.y+self.height,self.x,self.y+self.height)
		end if self.hasText then
			love.graphics.setColor(self.textColor)
			love.graphics.setFont(self.fontData.font)
				if self.fontData.centered then
					love.graphics.printf(self.text,self.x,((self.height/2)-(self.fontData.hSize/2))+self.y,self.width,"center")
				else
					love.graphics.print(self.text, self.x,self.y)
				end
			love.graphics.setFont(tempfont)
		end
	end
end

function Button:addTo(parent)
	self.parent = parent
	if parent.type=="Container" then
		table.insert(parent.uiComps, self)
	end
end

function Button:update()
	local flag = false 
	if self.displayed then
		flag = true
		if self.parent~=nil then
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

--Button Metamethods
function Button.__tostring(t)
	return tostring(t.clicked)
end
