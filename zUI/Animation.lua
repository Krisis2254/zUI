local Image = require("zUI/Image")
local BaseUI = require("zUI/BaseUI")

local Animation = {}
Animation.__index = Animation
setmetatable(Animation, { __index = Image, __call = function(_, ...) return Animation.new(...) end })

function Animation.new(path, timings, x, y, z, sx, sy, rot, ox, oy, bgColor, borderColor, displayed, form, textureW, textureH, shadowDisplayed)
	local imgs = {}
	local paths = {}

	if love.filesystem.isFile(path) then
		local texture = love.graphics.newImage(path)
		for i = 0, (texture:getHeight() / textureH) - 1 do
			for i2 = 0, (texture:getWidth() / textureW) - 1 do
				table.insert(imgs, Image(texture, x, y, z, sx, sy, rot, ox, oy, bgColor, borderColor, displayed, love.graphics.newQuad(i2 * textureW, i * textureH, textureW, textureH, texture:getDimensions()), shadowDisplayed))
			end
		end
		table.insert(paths, path)
	elseif love.filesystem.isDirectory(path) then
		local folder = love.filesystem.getDirectoryItems(path)
		for i, v in ipairs(folder) do
			local file = path.."/"..v
			table.insert(imgs, Image(file, x, y, z, sx, sy, rot, ox, oy, bgColor, borderColor, displayed, shadowDisplayed))
			table.insert(paths, file)
		end
	end

	local base = BaseUI.new(x, y, z, imgs[1].img:getWidth(), imgs[1].img:getHeight(), bgColor, nil, borderColor, displayed)
	base.imgs = imgs
	base.paths = paths
	base.drawform = form or "norm"
	base.animated = true
	if form == "norm" or form == "fab" then
		base.frame = 1
		base.animationdirection = 1
	elseif form == "rev" then
		base.frame = #imgs
		base.animationdirection = -1
	end
	base.time = 0
	base.timings = timings
	return setmetatable(base, Animation)
end

function Animation:draw()
	if self.frame <= #self.imgs then
		self.imgs[self.frame]:draw()
	end
end

function Animation:updateFrames()
	if self.animated then
		self.time = self.time + love.timer.getDelta()
		if self.time >= self.timings[self.frame] then
			self.time = 0
			if self.drawform == "norm" then
				self.animationdirection = 1
				if self.frame >= #self.imgs then
					self.frame = 0
				end
			elseif self.drawform == "fab" then
				if self.frame >= #self.imgs then
					self.animationdirection = -1
				elseif self.frame <= 1 then
					self.animationdirection = 1
				end
			elseif self.drawform == "rev" then
				self.animationdirection = -1
				if self.frame <= 1 then
					self.frame = #self.imgs + 1
				end
			end
			self.frame = self.frame + self.animationdirection
		end
	end
end

function Animation:update()
	if self:isDisplayed() then
		self.preupdate()
		self.m:update()
		self:postmouseupdate()
		self:updateFrames()
		self:calculatePosition()
		self:updateEntering()
		self:updateExiting()
		self:updateHovering()
		self:updateClicking()
		self:postupdate()
	end
end

function Animation.__tostring(a)
	local str = "("
	for i, v in ipairs(a.paths) do
		str = str..v
		if i ~= #a.paths then str = str..", " end
	end
	str = str..")"
	return str
end

return Animation
