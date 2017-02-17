local Hex = {}

function Hex.toHexadecimal(num)
	local div = num
	local hex = ""
	local mod = 0
	while div >= 16 do
		mod = div % 16
		div = math.floor(div / 16)
		if mod == 10 then
			hex = hex .. 'a'
		elseif mod == 11 then
			hex = hex .. 'b'
		elseif mod == 12 then
			hex = hex .. 'c'
		elseif mod == 13 then
			hex = hex .. 'd'
		elseif mod == 14 then
			hex = hex .. 'e'
		elseif mod == 15 then
			hex = hex .. 'f'
		else
			hex = hex .. tostring(mod)
		end
	end
	if div == 10 then
		hex = hex .. 'a'
	elseif div == 11 then
		hex = hex .. 'b'
	elseif div == 12 then
		hex = hex .. 'c'
	elseif div == 13 then
		hex = hex .. 'd'
	elseif div == 14 then
		hex = hex .. 'e'
	elseif div == 15 then
		hex = hex .. 'f'
	else
		hex = hex .. tostring(div)
	end
	return string.reverse(hex)
end

function Hex.toDecimal(hex)
	local dec = 0
	local cHex = ""
	hex = string.lower(hex)
	for power = 0, #hex do
		cHex = string.sub(string.reverse(hex), power + 1, power + 1)
		if cHex == 'a' then
			cHex = 10
		elseif cHex == 'b' then
			cHex = 11
		elseif cHex == 'c' then
			cHex = 12
		elseif cHex == 'd' then
			cHex = 13
		elseif cHex == 'e' then
			cHex = 14
		elseif cHex == 'f' then
			cHex = 15
		else
			cHex = tonumber(cHex)
		end
		dec = dec + cHex * (16 ^ power)
		power = power + 1
	end
	return dec
end

return Hex
