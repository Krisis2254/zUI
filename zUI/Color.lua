local Hex = require("zUI/Hex")
local Vec2 = require("zUI/Vec2")

local colorbase = {}
    colorbase.__index = colorbase
    setmetatable(colorbase, { __call = function(_, ...) return colorbase.new(...) end })
local rgb = {}
    rgb.__index = rgb
    setmetatable(rgb, { __index = colorbase, __call = function(_, ...) return rgb.new(...) end })
local rgba = {}
    rgba.__index = rgba
    setmetatable(rgba, { __index = colorbase, __call = function(_, ...) return rgba.new(...) end })
local hex = {}
    hex.__index = hex
    setmetatable(hex, { __index = colorbase, __call = function(_, ...) return hex.new(...) end })
local hsl = {}
    hsl.__index = hsl
    setmetatable(hsl, { __index = colorbase, __call = function(_, ...) return hsl.new(...) end })
local hsv = {}
    hsv.__index = hsv
    setmetatable(hsv, { __index = colorbase, __call = function(_, ...) return hsv.new(...) end })

function colorbase.new(color, type)
    if type == "rgb" then
        return rgb.new(color.r, color.g, color.b)
    elseif type == "rgba" then
        return rgba.new(color.r, color.g, color.b, color.a)
    elseif type == "hex" then
        return hex.new(color.hex, color.a)
    elseif type == "hsl" then
        return hsl.new(color.h, color.s, color.l, color.a)
    elseif type == "hsv" then
        return hsv.new(color.h, color.s, color.v, color.a)
    end
    return rgba.new(0, 0, 0, 0)
end

function colorbase:copy()
    if self.type == "rgb" then
        return rgb.new(self.r, self.g, self.b)
    elseif self.type == "rgba" then
        return rgba.new(self.r, self.g, self.b, self.a)
    elseif self.type == "hex" then
        return hex.new(self.hex, self.a)
    elseif self.type == "hsl" then
        return hsl.new(self.h, self.s, self.l, self.a)
    elseif self.type == "hsv" then
        return hsv.new(self.h, self.s, self.v, self.a)
    end
end

function colorbase:toRGB()
    if self.type == "rgb" then
        return self
    elseif self.type == "rgba" then
        return rgb.new(self.r, self.g, self.b)
    elseif self.type == "hex" then
        return rgb.new(toDecimal(self.r), toDecimal(self.g), toDecimal(self.b))
    elseif self.type == "hsl" then
        return rgb.new(colorbase.hslToRgb(self.h, self.s, self.l, 1))
    elseif self.type == "hsv" then
        return rgb.new(colorbase.hsvToRgb(self.h, self.s, self.v, 1))
    end
end

function colorbase:toRGBA()
    if self.type == "rgb" then
        return rgba.new(self.r, self.g, self.b, 255)
    elseif self.type == "rgba" then
        return self
    elseif self.type == "hex" then
        return rgba.new(toDecimal(self.r), toDecimal(self.g), toDecimal(self.b), self.a)
    elseif self.type == "hsl" then
        return rgba.new(colorbase.hslToRgb(self.h, self.s, self.l, self.a))
    elseif self.type == "hsv" then
        return rgba.new(colorbase.hsvToRgb(self.h, self.s, self.v, self.a))
    end
end

function colorbase:toHex()
    if self.type == "rgb" then
        local r = toHexadecimal(self.r)
            if #r < 2 then r = "0"..r end
        local g = toHexadecimal(self.g)
            if #g < 2 then g = "0"..g end
        local b = toHexadecimal(self.b)
            if #b < 2 then b = "0"..b end
        return hex.new(r..g..b, 255)
    elseif self.type == "rgba" then
        local r = toHexadecimal(self.r)
            if #r < 2 then r = "0"..r end
        local g = toHexadecimal(self.g)
            if #g < 2 then g = "0"..g end
        local b = toHexadecimal(self.b)
            if #b < 2 then b = "0"..b end
        return hex.new(r..g..b, self.a)
    elseif self.type == "hex" then
        return self
    elseif self.type == "hsl" then
        return rgba.new(colorbase.hslToRgb(self.h, self.s, self.l, self.a)):toHex()
    elseif self.type == "hsv" then
        return rgba.new(colorbase.hsvToRgb(self.h, self.s, self.v, self.a)):toHex()
    end
end

function colorbase:toHSL()
    if self.type == "rgb" then
        return hsl.new(colorbase.rgbToHsl(self.r, self.g, self.b, 255))
    elseif self.type == "rgba" then
        return hsl.new(colorbase.rgbToHsl(self.r, self.g, self.b, self.a))
    elseif self.type == "hex" then
        local c = self:toRGBA()
        return hsl.new(colorbase.rgbToHsl(c.r, c.g, c.b, c.a))
    elseif self.type == "hsl" then
        return self
    elseif self.type == "hsv" then
        local c = self:toRGBA()
        return hsl.new(colorbase.rgbToHsl(c.r, c.g, c.b, c.a))
    end
end

function colorbase:toHSV()
    if self.type == "rgb" then
        return hsv.new(colorbase.rgbToHsv(self.r, self.g, self.b, 255))
    elseif self.type == "rgba" then
        return hsv.new(colorbase.rgbToHsv(self.r, self.g, self.b, self.a))
    elseif self.type == "hex" then
        local c = self:toRGBA()
        return hsv.new(colorbase.rgbToHsv(c.r, c.g, c.b, c.a))
    elseif self.type == "hsl" then
        local c = self:toRGBA()
        return hsv.new(colorbase.rgbToHsv(c.r, c.g, c.b, c.a))
    elseif self.type == "hsv" then
        return self
    end
end

function colorbase:unpack()
    if self.type == "rgb" then
        return {self.r, self.g, self.b, 255}
    elseif self.type == "rgba" then
        return {self.r, self.g, self.b, self.a}
    elseif self.type == "hex" then
        return {self.r..self.g..self.b, self.a}
    elseif self.type == "hsl" then
        return {self.h, self.s, self.l, self.a}
    elseif self.type == "hsv" then
        return {self.h, self.s, self.v, self.a}
    end
end

function colorbase:shade(percent)
    local t = self.type
    c = self:toHSV()
    c.v = Vec2.clampnum(c.v + percent, 0, 1)
    if t == "rgb" then return c:toRGB() elseif t == "rgba" then return c:toRGBA() elseif t == "hex" then return c:toHex() elseif t == "hsl" then return c:toHSL() elseif t == "hsv" then return c end
end

function colorbase:hueshift(degrees)
    local t = self.type
    c = self:toHSV()
    c.h = ((c.h * 360 + degrees + 360) % 360) / 360
    if t == "rgb" then return c:toRGB() elseif t == "rgba" then return c:toRGBA() elseif t == "hex" then return c:toHex() elseif t == "hsl" then return c:toHSL() elseif t == "hsv" then return c end
end

function colorbase:mix(color,amount)
    local c1 = self:toRGBA()
    local c2 = color:toRGBA()
    local r, g, b, a = 0, 0, 0, 0
    local t = self.type
    r = math.sqrt( (1 - amount) * (c1.r ^ 2) + (amount * (c2.r ^ 2)) )
    g = math.sqrt( (1 - amount) * (c1.g ^ 2) + (amount * (c2.g ^ 2)) )
    b = math.sqrt( (1 - amount) * (c1.b ^ 2) + (amount * (c2.b ^ 2)) )
    a = (1 - amount) * c1.a + amount * c2.a
    if t == "rgb" then return rgb.new(r, g, b) elseif t == "rgba" then return rgba.new(r, g, b, a) elseif t == "hex" then return rgba.new(r, g, b, a):toHex() elseif t == "hsl" then rgba.new(r, g, b, a):toHSL() elseif t == "hsv" then return rgba.new(r, g, b, a):toHSV() end
end

function rgb.new(r, g, b)
    local base = {
        r = r or 0,
        g = g or 0,
        b = b or 0,
        type = "rgb"
    }
    return setmetatable(base, rgb)
end

function rgb.__tostring(c)
    return "("..tostring(c.r)..", "..tostring(c.g)..", "..tostring(c.b)..")"
end

function rgba.new(r, g, b, a)
    local base = {
        r = r or 0,
        g = g or 0,
        b = b or 0,
        a = a or 0,
        type = "rgba"
    }
    return setmetatable(base, rgba)
end

function rgba.__tostring(c)
    return "("..tostring(c.r)..", "..tostring(c.g)..", "..tostring(c.b)..", "..tostring(c.a)..")"
end

function hex.new(hex, a)
    hex = string.lower(hex)
    local base = {
        r = string.sub(hex, 1, 2) or "00",
        g = string.sub(hex, 3, 4) or "00",
        b = string.sub(hex, 5, 6) or "00",
        hex = hex,
        a = a or 0,
        type = "hex"
    }
    return setmetatable(base, hex)
end

function hex.__tostring(c)
    return "("..c.hex..", "..tostring(c.a)..")"
end

function hsl.new(h, s, l, a)
    local base = {
        h = h or 0,
        s = s or 0,
        l = l or 0,
        a = a or 0,
        type = "hsl"
    }
    return setmetatable(base, hsl)
end

function hsl.__tostring(t)
    return "("..tostring(c.h)..", "..tostring(c.s)..", "..tostring(c.l)..", "..tostring(c.a)..")"
end

function hsv.new(h, s, v, a)
    local base = {
        h = h or 0,
        s = s or 0,
        v = v or 0,
        a = a or 0,
        type = "hsv"
    }
    return setmetatable(base, hsv)
end

function hsv.__tostring(t)
    return "("..tostring(c.h)..", "..tostring(c.s)..", "..tostring(c.v)..", "..tostring(c.a)..")"
end

function colorbase.rgbToHsl(r, g, b, a)
    r = r / 255
    g = g / 255
    b = b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, l = (max + min) / 2,(max + min) / 2,(max + min) / 2

    if max == min then
        h = 0
        s = 0
    else
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end

    return h, s, l, a
end

function colorbase.hToRgb(p, q, t) if t < 0 then t = t + 1 end if t > 1 then t = t - 1 end if t < 1/6 then return p + (q - p) * 6 * t end if t < 1/2 then return q end if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end return p end

function colorbase.hslToRgb(h, s, l, a)
    local r, g, b = 0, 0 ,0
    if s == 0 then
        r, g, b = 1, 1, 1
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = colorbase.hToRgb(p, q, h + 1/3)
        g = colorbase.hToRgb(p, q, h)
        b = colorbase.hToRgb(p, q, h - 1/3)
    end
    return Vec2.roundnum(r * 255), Vec2.roundnum(g * 255), Vec2.roundnum(b * 255), a
end

function colorbase.rgbToHsv(r, g, b, a)
    r = r / 255
    g = g / 255
    b = b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v = max, max, max

    local d = max - min
    s = max == 0 and 0 or d / max

    if max == min then
        h = 0
    else
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end
    return h, s, v, a
end

function colorbase.hsvToRgb(h, s, v, a)
    local r, g, b = 0, 0, 0
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    if i % 6 == 0 then
        r = v
        g = t
        b = p
    elseif i % 6 == 1 then
        r = q
        g = v
        b = p
    elseif i % 6 == 2 then
        r = p
        g = v
        b = t
    elseif i % 6 == 3 then
        r = p
        g = q
        b = v
    elseif i % 6 == 4 then
        r = t
        g = p
        b = v
    elseif i % 6 == 5 then
        r = v
        g = p
        b = q
    end
    return Vec2.roundnum(r * 255), Vec2.roundnum(g * 255), Vec2.roundnum(b * 255), a
end

return {rgb, rgba, hex, hsl, hsv}
