local Vec2 = require("Vec2")

local Touch = {}
Touch.__index = Touch
setmetatable(Touch, { __call = function(_, ...) return Touch.new(...) end })

function Touch.new()
	return setmetatable( { touches = {}, first_touch = Vec2(-1, -1), touch_ids = {}, touched = false}, Touch)
end

function Touch:update()
	self.touches = {}
	self.first_touch = {}
	self.touch_ids = {}
	for i, v in ipairs(love.touch.getTouches()) do
		local x, y = love.touch.getPosition(v)
		if i == 1 then self.first_touch = Vec2(x, y) end
		table.insert(self.touches, Vec2(x, y))
		table.insert(self.touch_ids, id)
	end
	if #self.touches > 0 then
		self.touched = true
	else
		self.touched = false
	end
end

function Touch.__tostring(a)
	local str = ""
	for i, v in ipairs(a.touches) do
		str = str .. "("..v.x..", "..v.y..", "..i..")"
	end
	return string
end
