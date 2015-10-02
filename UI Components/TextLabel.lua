require("zUI/BaseUI")
require("zUI/Color")
--Textlabel Class Setup
TextLabel = {}
TextLabel.__index = TextLabel
setmetatable(TextLabel, {__index=BaseUI,__call=function(_,...) return TextLabel.new(...) end})

--TextLabel Methods
function TextLabel.new(x,y,width,height,text,centered,font,bgColor,textColor,borderColor,hasBg,hasBorder,displayed,clickTime)
	--Autofiting
	if width==nil then
		width = font:getWidth(text)
		afitw = true
	else afitw = false end if height==nil then
		height = font:getHeight()
		afith = true
	else afith = false end

	local base = BaseUI.new(x,y,width,height,bgColor,textColor,borderColor,displayed)
	base.type = "TextLabel"
	base.text = text
	base.hasBackground = hasBg
	base.hasBorder = hasBorder
	base.fontData = {}
	base.fontData.font = font
	base.fontData.wSize = font:getWidth(text)
	base.fontData.hSize = font:getHeight()
	base.fontData.centered = centered
	base.clicked = false
	base.clickTime = clickTime
	base.curTime = 0
	base.afitw = afitw
	base.afith = afith
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
	return setmetatable(base, TextLabel)
end

function TextLabel:draw()
	if self.displayed then
		local tempfont = love.graphics.getFont()
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
		love.graphics.setColor(self.textColor:toRGBA():unpack())
		love.graphics.setFont(self.fontData.font)
			if self.fontData.centered then
				love.graphics.printf(self.text,self.x,((self.height/2)-(self.fontData.hSize/2))+self.y,self.width,"center")
			else
				love.graphics.print(self.text, self.x,self.y)
			end
		love.graphics.setFont(tempfont)
	end
end

function TextLabel:addTo(parent)
	self.hasParent=true
	self.parent = parent
	if parent.type=="Container" then
		table.insert(parent.uiComps, self)
	end
end

function TextLabel:update()
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

--TextLabel Metamethods
function TextLabel.__tostring(t)
	return t.text
end

function TextLabel.__add(a,b)
	if type(a)=="string" then
		return TextLabel.new(b.x,b.y,b.width,b.height,a..b.text,b.fontData.autofit,b.fontData.font,b.bgColor,b.textColor,b.borderColor)
	elseif type(b)=="string" then
		return TextLabel.new(b.x,b.y,b.width,b.height,a.text..b,b.fontData.autofit,b.fontData.font,b.bgColor,b.textColor,b.borderColor)
	elseif a.type=="TextLabel" and b.type=="TextLabel" then
		return TextLabel.new(a.x,a.y,a.width,a.height,a.text..b.text,a.fontData.autofit,a.fontData.font,a.bgColor,a.textColor,a.borderColor)
	end
end
