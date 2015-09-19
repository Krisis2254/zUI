require("zUI/Image")

Animation = {}
Animation.__index = Animation
setmetatable(Animation, {__index=Image,__call=function(_,...) return Animation.new(...) end})

function Animation.new(path,timings,x,y,sx,sy,rot,ox,oy,bgColor,borderColor,hasBg,hasBorder,displayed,form,clickTime)
	local folder = love.filesystem.getDirectoryItems(path)
	local base = {}
	local imgs = {}
	local paths = {}
	for i,v in ipairs(folder) do
		local file = path.."/"..v
		table.insert(imgs, Image(file,x,y,sx,sy,rot,ox,oy,bgColor,borderColor,hasBg,hasBorder,displayed))
		table.insert(paths, file)
	end
	base = BaseUI.new(x,y,imgs[1].img:getWidth(),imgs[1].img:getHeight(),bgColor,nil,borderColor,displayed)
	base.imgs = imgs
	base.drawform = form
	if form=="norm" or form=="fab" then
		base.frame = 1
		base.animationdirection = 1
	elseif form=="rev" then
		base.frame = #imgs
		base.animationdirection = -1
	end
	base.time = 0
	base.timings = timings
	base.hasBackground = hasBg or false
	base.hasBorder = hasBorder or false
	base.paths = paths
	base.clicked = false
	base.clickTime = clickTime
	base.curTime = 0
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
	return setmetatable(base, Animation)
end

function Animation:addTo(parent)
	self.parent = parent
	for i,v in ipairs(self.imgs) do
		self.imgs[i].parent = parent
	end
	if parent.type=="Container" then
		table.insert(parent.uiComps, self)
	end
end

function Animation:draw()
	if self.frame<=#self.imgs then
		self.imgs[self.frame]:draw()
	end
end

function Animation:update()
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
		self.time = self.time+love.timer.getDelta()
		if self.time>=self.timings[self.frame] then
			self.time = 0
			if self.drawform=="norm" then
				self.animationdirection = 1
				if self.frame>=#self.imgs then
					self.frame = 0
				end
			elseif self.drawform=="fab" then
				if self.frame>=#self.imgs then
					self.animationdirection = -1
				elseif self.frame<=1 then
					self.animationdirection = 1
				end
			elseif self.drawform=="rev" then
				self.animationdirection = -1
				if self.frame<=1 then
					self.frame = #self.imgs+1
				end
			end
			self.frame = self.frame+self.animationdirection
		end
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

function Animation.__tostring(a)
	local str = "("
	for i,v in ipairs(a.paths) do
		str = str..v..","
	end
	str = str..")"
	return str
end
