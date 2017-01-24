local Vec3 = {}
Vec3.__index = Vec3
setmetatable(Vec3, { __call = function (_, ...) return Vec3.new(...) end })

function Vec3.roundnum(number)
    if math.ceil(number) <= (number + 0.5) then
        return math.ceil(number)
    else
        return math.floor(number)
    end
end

function Vec3.clampnum(number, min, max)
    return math.min(max, math.max(min, number))
end

function Vec3.new(x, y, z)
	return setmetatable( { x = x or 0, y = y or 0, z = z or 0 }, Vec3)
end

function Vec3.__unm(a)
	return Vec3.new(-a.x, -a.y, -a.z)
end

function Vec3.__add(a, b)
	if type(a) == "number" then
		return Vec3.new(a + b.x, a + b.y, a + b.z)
	elseif type(b) == "number" then
		return Vec3.new(a.x + b, a.y + b, a.z + b)
	else
		return Vec3.new(a.x + b.x, a.y + b.y, a.z + b.z)
	end
end

function Vec3.__sub(a, b)
	if type(a) == "number" then
		return Vec3.new(a - b.x, a - b.y, a - b.z)
	elseif type(b) == "number" then
		return Vec3.new(a.x - b, a.y - b, a.z + b)
	else
		return Vec3.new(a.x - b.x, a.y - b.y, a.z - b.z)
	end
end

function Vec3.__mul(a, b)
	if type(a) == "number" then
		return Vec3.new(a * b.x, a * b.y, a * b.z)
	elseif type(b) == "number" then
		return Vec3.new(a.x * b, a.y * b, a.z * b)
	else
		return Vec3.new(a.x * b.x, a.y * b.y, a.z * b.z)
	end
end

function Vec3.__div(a, b)
	if type(a) == "number" then
		return Vec3.new(a / b.x, a / b.y, a / b.z)
	elseif type(b) == "number" then
		return Vec3.new(a.x / b, a.y / b, a.z / b)
	else
		return Vec3.new(a.x / b.x, a.y / b.y, a.z / b.z)
	end
end

function Vec3.__mod(a, b)
	if type(a) == "number" then
		return Vec3.new(a % b.x, a % b.y, a % b.z)
	elseif type(b) == "number" then
		return Vec3.new(a.x % b, a.y % b, a.z % b)
	else
		return Vec3.new(a.x % b.x, a.y % b.y, a.z % b.z)
	end
end

function Vec3.__pow(a, b)
	if type(a) == "number" then
		return Vec3.new(a ^ b.x, a ^ b.y, a ^ b.z)
	elseif type(b) == "number" then
		return Vec3.new(a.x ^ b, a.y ^ b, a.z ^ b)
	else
		return Vec3.new(a.x ^ b.x, a.y ^ b.y, a.z ^ b.y)
	end
end

function Vec3.__eq(a, b)
	if type(a) == "number" then
		if a == b.x and a == b.y and a == b.z then
			return true
		end
	elseif type(b) == "number" then
		if a.x == b and a.y == b and a.z == b then
			return true
		end
	else
		if a.x == b.x and a.y == b.y and a.z == b.z then
			return true
		end
	end
	return false
end

function Vec3.__lt(a, b)
	if type(a) == "number" then
		if a < b.x and a < b.y and a < b.z then
			return true
		end
	elseif type(b) == "number" then
		if a.x < b and a.y < b and a.z < b then
			return true
		end
	else
		if a.x < b.x and a.y < b.y and a.z < b.z then
			return true
		end
	end
	return false
end

function Vec3.__le(a, b)
	if type(a) == "number" then
		if a <= b.x and a <= b.y and a <= b.z then
			return true
		end
	elseif type(b) == "number" then
		if a.x <= b and a.y <= b and a.z <= b then
			return true
		end
	else
		if a.x <= b.x and a.y <= b.y and a.z <= b.z then
			return true
		end
	end
	return false
end

function Vec3.__tostring(a)
	return "("..a.x..", "..a.y..", "..a.z..")"
end

function Vec3:ceil()
	return Vec3.new(math.ceil(self.x), math.ceil(self.y), math.ceil(self.z))
end

function Vec3:floor()
	return Vec3.new(math.floor(self.x), math.floor(self.y), math.floor(self.z))
end

function Vec3:round()
	return Vec3.new(Vec3.roundnum(self.x), Vec3.roundnum(self.y), Vec3.roundnum(self.z))
end

function Vec3:clamp(min, max)
	local xmin, ymin, zmin = 0, 0, 0
	local xmax, ymax, zmax = 0, 0, 0
    if type(min) == "number" then
        xmin, ymin, zmin = min, min, min
    else
        xmin, ymin, zmin = min.x, min.y, min.z
    end

    if type(max) == "number" then
        xmax, ymax, zmax = max, max, max
    else
        xmax, ymax, zmax = max.x, max.y, max.z
    end

    return Vec3.new(Vec3.clampnum(self.x, xmin, xmax), Vec3.clampnum(self.y, ymin, ymax), Vec3.clampnum(self.z, zmin, zmax))
end

function Vec3:unpack()
    return self.x, self.y, self.z
end

return Vec3
