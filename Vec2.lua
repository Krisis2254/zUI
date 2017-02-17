local Vec2 = {}
Vec2.__index = Vec2
setmetatable(Vec2, { __call = function (_, ...) return Vec2.new(...) end })

function Vec2.roundnum(number)
    if math.ceil(number) <= number + 0.5 then
        return math.ceil(number)
    else
        return math.floor(number)
    end
end

function Vec2.clampnum(number, min, max)
    return math.min(max, math.max(min, number))
end

function Vec2.new(x, y)
	return setmetatable( { x = x or 0, y = y or 0 }, Vec2)
end

function Vec2.__unm(a)
	return Vec2.new(-a.x, -a.y)
end

function Vec2.__add(a, b)
	if type(a) == "number" then
		return Vec2.new(a + b.x, a + b.y)
	elseif type(b) == "number" then
		return Vec2.new(a.x + b, a.y + b)
	else
		return Vec2.new(a.x + b.x, a.y + b.y)
	end
end

function Vec2.__sub(a, b)
	if type(a) == "number" then
		return Vec2.new(a - b.x, a - b.y)
	elseif type(b) == "number" then
		return Vec2.new(a.x - b, a.y - b)
	else
		return Vec2.new(a.x - b.x, a.y - b.y)
	end
end

function Vec2.__mul(a, b)
	if type(a) == "number" then
		return Vec2.new(a * b.x, a * b.y)
	elseif type(b) == "number" then
		return Vec2.new(a.x * b, a.y * b)
	else
		return Vec2.new(a.x * b.x, a.y * b.y)
	end
end

function Vec2.__div(a, b)
	if type(a) == "number" then
		return Vec2.new(a / b.x, a / b.y)
	elseif type(b) == "number" then
		return Vec2.new(a.x / b, a.y / b)
	else
		return Vec2.new(a.x / b.x, a.y / b.y)
	end
end

function Vec2.__mod(a, b)
	if type(a) == "number" then
		return Vec2.new(a % b.x, a % b.y)
	elseif type(b) == "number" then
		return Vec2.new(a.x % b, a.y % b)
	else
		return Vec2.new(a.x % b.x, a.y % b.y)
	end
end

function Vec2.__pow(a, b)
	if type(a) == "number" then
		return Vec2.new(a ^ b.x, a ^ b.y)
	elseif type(b) == "number" then
		return Vec2.new(a.x ^ b, a.y ^ b)
	else
		return Vec2.new(a.x ^ b.x, a.y ^ b.y)
	end
end

function Vec2.__eq(a, b)
	if type(a) == "number" then
		if a == b.x and a == b.y then
			return true
		end
	elseif type(b) == "number" then
		if a.x == b and a.y == b then
			return true
		end
	else
		if a.x == b.x and a.y == b.y then
			return true
		end
	end
	return false
end

function Vec2.__lt(a, b)
	if type(a) == "number" then
		if a < b.x and a < b.y then
			return true
		end
	elseif type(b) == "number" then
		if a.x < b and a.y < b then
			return true
		end
	else
		if a.x < b.x and a.y < b.y then
			return true
		end
	end
	return false
end

function Vec2.__le(a, b)
	if type(a) == "number" then
		if a <= b.x and a <= b.y then
			return true
		end
	elseif type(b) == "number" then
		if a.x <= b and a.y <= b then
			return true
		end
	else
		if a.x <= b.x and a.y <= b.y then
			return true
		end
	end
	return false
end

function Vec2.__tostring(a)
	return "("..a.x..", "..a.y..")"
end

function Vec2:ceil()
	return Vec2.new(math.ceil(self.x), math.ceil(self.y))
end

function Vec2:floor()
	return Vec2.new(math.floor(self.x), math.floor(self.y))
end

function Vec2:round()
	return Vec2.new(Vec2.roundnum(self.x), Vec2.roundnum(self.y))
end

function Vec2:clamp(min, max)
	local xmin, ymin = 0, 0
	local xmax, ymax = 0 ,0
    if type(min) == "number" then
        xmin, ymin = min, min
    else
        xmin, ymin = min.x, min.y
    end

    if type(max) == "number" then
        xmax, ymax = max, max
    else
        xmax, ymax = max.x, max.y
    end

    return Vec2.new(Vec2.clampnum(self.x, xmin, xmax), Vec2.clampnum(self.y, ymin, ymax))
end

function Vec2:unpack()
    return self.x, self.y
end

return Vec2
