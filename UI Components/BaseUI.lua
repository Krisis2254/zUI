require("zUI/Mouse")
require("zUI/Color")
--BaseUI Class Setup
BaseUI = {}
BaseUI.__index = BaseUI
setmetatable(BaseUI, {__call = function(_,...) return BaseUI.new(...) end})

BaseUI.displayEvents = {}

--BaseUI Methods
function BaseUI.new(x,y,width,height,bgColor,textColor,borderColor,displayed)
	return setmetatable({
		x = x or 0,
		y = y or 0,
		width = width or 0,
		height = height or 0,
		bgColor = bgColor or rgba(0,0,0,0),
		textColor = textColor or rgba(0,0,0,0),
		borderColor = borderColor or rgba(0,0,0,0),
		displayed = displayed or false,
		ox = x or 0,
		oy = y or 0,
		ofx = 0,
		ofy = 0,
		parent = nil,
		hasParent = false,
		preupdate = function() end,
		postupdate = function() end,
		m = Mouse(false)
	}, BaseUI)
end

function BaseUI:draw()
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
	end
end

function BaseUI.newDisplayEvent(displayfunction)
	table.insert(BaseUI.displayEvents, displayfunction)
end

function BaseUI.drawEvents()
	for i,v in ipairs(BaseUI.displayEvents) do
		v()
	end
	BaseUI.displayEvents = {}
end

function BaseUI:move(nx,ny,relative)
	if nx==nil then nx = self.ox end
	if ny==nil then ny = self.oy end
	if not relative then
		self.ox,self.oy = nx,ny
	else
		self.ox,self.oy = self.ox+nx, self.oy+ny
	end
end

function BaseUI:changeText(newtext)
	if self.text~=nil then
		self.text = newtext
		if self.afitw then
			self.width = self.fontData.font:getWidth(self.text)
		end if self.afith then
			self.height = self.fontData.font:getHeight()
		end
	end
end

function BaseUI:changeFont(newfont)
	if self.fontData~=nil then
		self.fontData.font = newfont
		self.fontData.wSize = newfont:getWidth(self.text)
		self.fontData.hSize = newfont:getHeight()
	end
end
