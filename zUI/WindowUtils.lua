local Container = require("zUI/Container")
local MaterialDesignPalettes = require("zUI/MaterialDesignPalettes")
local TextField = require("zUI/TextField")
local TextLabel = require("zUI/TextLabel")
local beholder = require("zUI/beholder")
local octicon_font = love.filesystem.exists("zUI/octicons-local.ttf") and love.graphics.newFont("zUI/octicons-local.ttf", 16) or love.graphics.getFont()
	local octicon_loaded = love.filesystem.exists("zUI/octicons-local.ttf")

local WindowUtils = {}
	WindowUtils.open_windows = {}

function WindowUtils.createMsgBox(id, x, y, z, width, height, cCornerRadius, bCornerRadius, msg, font, bgColor, textColor, borderColor, opt_container, opt_label, opt_close )
	local container = opt_container or Container(x, y, z, width, height, bgColor, borderColor, true, cCornerRadius)
	container.windowID = id or "BLANK"
	container.creationtime = 0
	container.closing = false
	if not opt_container then
		function container:postupdate()
			if self.creationtime <= 90 and not self.closing then
				if self.borderColor then self.borderColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				if self.bgColor then self.bgColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = math.sin(math.rad(self.creationtime)) * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = math.sin(math.rad(self.creationtime)) * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = math.sin(math.rad(self.creationtime)) * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.min(90, self.creationtime + love.timer.getDelta() * 720)
			elseif self.closing then
				if self.creationtime == 0 then WindowUtils.open_windows[self.windowID] = nil end
				if self.borderColor then self.borderColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				if self.bgColor then self.bgColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = math.sin(math.rad(self.creationtime)) * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = math.sin(math.rad(self.creationtime)) * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = math.sin(math.rad(self.creationtime)) * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.max(0, self.creationtime - love.timer.getDelta() * 720)
			end
		end
	end
	local text = opt_label or TextLabel((width - font:getWidth(msg)) / 2, (height - font:getHeight()) / 2, 0, nil, nil, msg, false, font, nil, textColor, nil, true)
		text:addTo(container)
	local close = opt_button or TextLabel(width - octicon_font:getWidth(octicon_loaded and "" or "X") * 5/2, 0, 0, octicon_font:getWidth(octicon_loaded and "" or "X") * 5/2, octicon_font:getHeight() * 5/4, octicon_loaded and "" or "X", true, octicon_font, MaterialDesignPalettes.palette_red.pri.s700, MaterialDesignPalettes.palette_red.pri.s50, MaterialDesignPalettes.palette_red.pri.s700, true, bCornerRadius)
		if not opt_button then
			close:addTo(container)
			close.bgColor.a = 0
			close.hovertime = 0
			function close:postupdate()
				if self.entered then
					self.hovertime = math.min(90, self.hovertime + love.timer.getDelta() * 360)
				else
					self.hovertime = math.max(0, self.hovertime - love.timer.getDelta() * 360)
				end
				self.normBgA = math.sin(math.rad(self.hovertime)) * 255
				self.normBorderA = math.sin(math.rad(self.hovertime)) * 255
			end
			function close:onclick() WindowUtils.open_windows[self.parent.windowID].closing = true end
		end
	if not WindowUtils.open_windows[id] then
		WindowUtils.open_windows[id] = container
	end
end

function WindowUtils.createPrompt(id, x, y, z, width, height, cCornerRadius, bCornerRadius, tCornerRadius, title, font, bgColor, textColor, borderColor, inputBG, inputBorder, enterCond, func, opt_container, opt_label, opt_close, opt_input)
	local container = opt_container or Container(x, y, z, width, height, bgColor, borderColor, true, cCornerRadius)
		container.windowID = id or "BLANK"
		if not opt_container then
			container.creationtime = 0
			container.closing = false
			container.keyid = ""
			function container:postupdate()
				if self.creationtime <= 90 and not self.closing then
					if self.borderColor then self.borderColor.a = math.sin(math.rad(self.creationtime)) * 255 end
					if self.bgColor then self.bgColor.a = math.sin(math.rad(self.creationtime)) * 255 end
					for i, v in ipairs(self.children) do
						if v.bgColor then v.bgColor.a = math.sin(math.rad(self.creationtime)) * (v.normBgA and v.normBgA or 255) end
						if v.textColor then v.textColor.a = math.sin(math.rad(self.creationtime)) * (v.normTextA and v.normTextA or 255) end
						if v.borderColor then v.borderColor.a = math.sin(math.rad(self.creationtime)) * (v.normBorderA and v.normBorderA or 255) end
					end
					self.creationtime = math.min(90, self.creationtime + love.timer.getDelta() * 720)
				elseif self.closing then
					if self.creationtime == 0 then WindowUtils.open_windows[self.windowID] = nil end
					if self.borderColor then self.borderColor.a = math.sin(math.rad(self.creationtime)) * 255 end
					if self.bgColor then self.bgColor.a = math.sin(math.rad(self.creationtime)) * 255 end
					for i, v in ipairs(self.children) do
						if v.bgColor then v.bgColor.a = math.sin(math.rad(self.creationtime)) * (v.normBgA and v.normBgA or 255) end
						if v.textColor then v.textColor.a = math.sin(math.rad(self.creationtime)) * (v.normTextA and v.normTextA or 255) end
						if v.borderColor then v.borderColor.a = math.sin(math.rad(self.creationtime)) * (v.normBorderA and v.normBorderA or 255) end
					end
					self.creationtime = math.max(0, self.creationtime - love.timer.getDelta() * 720)
				end
			end
		end
	local title = opt_label or TextLabel(0, octicon_font:getHeight() * 5/8 - font:getHeight() / 2, 0, nil, nil, title, false, font, nil, textColor, nil, true, tCornerRadius)
		title:addTo(container)
	local close = opt_button or TextLabel(width - octicon_font:getWidth(octicon_loaded and "" or "X") * 5/2, 0, 0, octicon_font:getWidth(octicon_loaded and "" or "X") * 5/2, octicon_font:getHeight() * 5/4, octicon_loaded and "" or "X", true, octicon_font, MaterialDesignPalettes.palette_red.pri.s700, MaterialDesignPalettes.palette_red.pri.s50, MaterialDesignPalettes.palette_red.pri.s700, true, bCornerRadius)
		close:addTo(container)
		if not opt_button then
			close.bgColor.a = 0
			close.hovertime = 0
			function close:postupdate()
				if self.entered then
					self.hovertime = math.min(90, self.hovertime + love.timer.getDelta() * 360)
				else
					self.hovertime = math.max(0, self.hovertime - love.timer.getDelta() * 360)
				end
				self.normBgA = math.sin(math.rad(self.hovertime)) * 255
				self.normBorderA = math.sin(math.rad(self.hovertime)) * 255
			end
			function close:onclick() beholder.stopObserving(self.parent.keyid) WindowUtils.open_windows[self.parent.windowID].closing = true end
		end

	local name_input = opt_input or TextField(5, (height - 10) / 2, 0, width - 10, 20, false, 0.75, false, 15, font, inputBG, textColor, inputBorder, true, tCornerRadius)
		name_input:addTo(container)
		if not opt_input then
			name_input.selected = true
			for _, v in pairs(WindowUtils.open_windows) do
				for i, v2 in ipairs(v.children) do
					if v2.selected then name_input.selected = false end
				end
			end
			if name_input.selected then
				name_input.displayCursor = true
				name_input.parent.keyid = beholder.observe("KEYPRESS", function(text, raw)
					if raw == "backspace" then
						name_input:changeText(string.sub(name_input.text, 1, #name_input.text - 1))
					elseif raw == "return" and #name_input.text > 0 then
						if enterCond(name_input.text) then
							beholder.stopObserving(name_input.parent.keyid)
							WindowUtils.open_windows[name_input.parent.windowID].closing = true
							func(name_input.text)
						end
					else
						if name_input.fontdata.size.x + name_input.fontdata.font:getWidth(text) < name_input.dim.x then
							name_input:changeText(name_input.text..text)
						end
					end
				end)
				if name_input.bgColor then name_input.bgColor = name_input.bgColor:shade(0.05) end
				if name_input.borderColor then name_input.borderColor = name_input.borderColor:shade(0.05) end
			end
			function name_input:onclick()
				if self.selected then
					self.selected = false
					self.displayCursor = false
					beholder.stopObserving(self.parent.keyid)
					if self.bgColor then self.bgColor = self.bgColor:shade(-0.05) end
					if self.borderColor then self.borderColor = self.borderColor:shade(-0.05) end
				else
					for _, v in pairs(WindowUtils.open_windows) do
						for i, v2 in ipairs(v.children) do
							v2.selected = false
						end
					end
					self.selected = true
					self.displayCursor = true
					self.parent.keyid = beholder.observe("KEYPRESS", function(text, raw)
						if raw == "backspace" then
							self:changeText(string.sub(self.text, 1, #self.text - 1))
						elseif raw == "return" and #self.text > 0 then
							if enterCond(self.text) then
								beholder.stopObserving(self.parent.keyid)
								WindowUtils.open_windows[self.parent.windowID].closing = true
								func(self.text)
							end
						else
							if self.fontdata.size.x + name_input.fontdata.font:getWidth(text) < name_input.dim.x then
								self:changeText(self.text..text)
							end
						end
					end)
					if self.bgColor then self.bgColor = self.bgColor:shade(0.05) end
					if self.borderColor then self.borderColor = self.borderColor:shade(0.05) end
				end
			end
		end
	if WindowUtils.open_windows[id]==nil then
		WindowUtils.open_windows[id] = container
	end
end

function WindowUtils.createPopup(id, x, y, z, width, height, cCornerRadius, msg, font, bgColor, textColor, borderColor, timeOpen, opt_container, opt_label)
	local container = opt_container or Container(x, y, z, width, height, bgColor, borderColor, true, cCornerRadius)
	container.windowID = id or "BLANK"
	if not opt_container then
		container.creationtime = 0
		container.closing = false
		container.clock = 0
		container.maxTime = timeOpen
		function container:postupdate()
			if self.creationtime <= 90 and not self.closing then
				if self.borderColor then self.borderColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				if self.bgColor then self.bgColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = math.sin(math.rad(self.creationtime)) * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = math.sin(math.rad(self.creationtime)) * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = math.sin(math.rad(self.creationtime)) * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.min(90, self.creationtime + love.timer.getDelta() * 720)
			elseif self.closing then
				if self.creationtime == 0 then WindowUtils.open_windows[self.windowID] = nil end
				if self.borderColor then self.borderColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				if self.bgColor then self.bgColor.a = math.sin(math.rad(self.creationtime)) * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = math.sin(math.rad(self.creationtime)) * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = math.sin(math.rad(self.creationtime)) * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = math.sin(math.rad(self.creationtime)) * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.max(0, self.creationtime - love.timer.getDelta() * 720)
			end
			self.clock = math.min(self.maxTime, self.clock + love.timer.getDelta())
			if self.clock == self.maxTime then
				self.closing = true
			end
		end
	end
	local text = opt_label or TextLabel((width - font:getWidth(msg)) / 2, (height - font:getHeight()) / 2, 0, nil, nil, msg, false, font, nil, textColor, nil, true)
	text:addTo(container)
	if WindowUtils.open_windows[id]==nil then
		WindowUtils.open_windows[id] = container
	end
end

return WindowUtils
