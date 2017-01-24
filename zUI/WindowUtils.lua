local Container = require("zUI/Container")
local MaterialDesignUtils = require("zUI/MaterialDesignUtils")
local TextField = require("zUI/TextField")
local TextLabel = require("zUI/TextLabel")
local beholder = require("zUI/beholder")
local iconpath = "zUI/FontAwesome.otf"
local fontawesome = love.filesystem.exists(iconpath) and love.graphics.newFont(iconpath, 18) or love.graphics.getFont()
	local fontawesome_loaded = love.filesystem.exists(iconpath)

local WindowUtils = {}
	WindowUtils.open_windows = {}

function WindowUtils.createMsgBox(id, x, y, z, width, height, cCornerRadius, bCornerRadius, msg, font, bgColor, textColor, borderColor, opt_container, opt_label, opt_close, shadowDisplayed)
	local container = opt_container or Container(x, y, z, width, height, bgColor, borderColor, true, cCornerRadius, shadowDisplayed)
	container.windowID = id or "BLANK"
	container.creationtime = 0
	container.creationprog = 0
	container.closing = false
	if not opt_container then
		function container:postupdate()
			if self.creationtime <= 1 and not self.closing then
				if self.borderColor then self.borderColor.a = self.creationprog * 255 end
				if self.bgColor then self.bgColor.a = self.creationprog * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = self.creationprog * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = self.creationprog * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = self.creationprog * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.min(1, self.creationtime + love.timer.getDelta() * 1000 / 125)
			elseif self.closing then
				if self.creationtime == 0 then WindowUtils.open_windows[self.windowID] = nil end
				if self.borderColor then self.borderColor.a = self.creationprog * 255 end
				if self.bgColor then self.bgColor.a = self.creationprog * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = self.creationprog * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = self.creationprog * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = self.creationprog * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.max(0, self.creationtime - love.timer.getDelta() * 1000 / 125)
			end
			self.creationprog = MaterialDesignUtils.easing_curves.std_curve:evaluate(self.creationtime)
		end
	end
	local text = opt_label or TextLabel((width - font:getWidth(msg)) / 2, (height - font:getHeight()) / 2, 0, nil, nil, msg, false, font, nil, textColor, nil, true)
		text:addTo(container)
	local close = opt_button or TextLabel(width - fontawesome:getWidth(fontawesome_loaded and "" or "X") * 3/2, 0, 0, fontawesome:getWidth(fontawesome_loaded and "" or "X") * 3/2, (fontawesome:getBaseline() - fontawesome:getHeight() + fontawesome:getAscent()) * 7/5, fontawesome_loaded and "" or "X", true, fontawesome, MaterialDesignUtils.palettes.palette_red.pri.s700, MaterialDesignUtils.palettes.palette_red.pri.s50, MaterialDesignUtils.palettes.palette_red.pri.s700, true, bCornerRadius)
		if not opt_button then
			close:addTo(container)
			close.bgColor.a = 0
			close.hovertime = 0
			close.hoverprog = 0
			function close:postupdate()
				if self.entered then
					self.hovertime = math.min(1, self.hovertime + love.timer.getDelta() * 1000 / 125)
				else
					self.hovertime = math.max(0, self.hovertime - love.timer.getDelta() * 1000 / 125)
				end
				self.hoverprog = MaterialDesignUtils.easing_curves.std_curve:evaluate(self.hovertime)
				self.normBgA = self.hoverprog * 255
				self.normBorderA = self.hoverprog * 255
			end
			function close:onclick() WindowUtils.open_windows[self.parent.windowID].closing = true end
		end
	if not WindowUtils.open_windows[id] then
		WindowUtils.open_windows[id] = container
	end
end

function WindowUtils.createPrompt(id, x, y, z, width, height, cCornerRadius, bCornerRadius, tCornerRadius, title, font, bgColor, textColor, borderColor, inputBG, inputBorder, enterCond, func, opt_container, opt_label, opt_close, opt_input, shadowDisplayed)
	local container = opt_container or Container(x, y, z, width, height, bgColor, borderColor, true, cCornerRadius, shadowDisplayed)
		container.windowID = id or "BLANK"
		if not opt_container then
			container.creationtime = 0
			container.creationprog = 0
			container.closing = false
			container.keyid = ""
			function container:postupdate()
				if self.creationtime <= 1 and not self.closing then
					if self.borderColor then self.borderColor.a = self.creationprog * 255 end
					if self.bgColor then self.bgColor.a = self.creationprog * 255 end
					for i, v in ipairs(self.children) do
						if v.bgColor then v.bgColor.a = self.creationprog * (v.normBgA and v.normBgA or 255) end
						if v.textColor then v.textColor.a = self.creationprog * (v.normTextA and v.normTextA or 255) end
						if v.borderColor then v.borderColor.a = self.creationprog * (v.normBorderA and v.normBorderA or 255) end
					end
					self.creationtime = math.min(1, self.creationtime + love.timer.getDelta() * 1000 / 125)
				elseif self.closing then
					if self.creationtime == 0 then WindowUtils.open_windows[self.windowID] = nil end
					if self.borderColor then self.borderColor.a = self.creationprog * 255 end
					if self.bgColor then self.bgColor.a = self.creationprog * 255 end
					for i, v in ipairs(self.children) do
						if v.bgColor then v.bgColor.a = self.creationprog * (v.normBgA and v.normBgA or 255) end
						if v.textColor then v.textColor.a = self.creationprog * (v.normTextA and v.normTextA or 255) end
						if v.borderColor then v.borderColor.a = self.creationprog * (v.normBorderA and v.normBorderA or 255) end
					end
					self.creationtime = math.max(0, self.creationtime - love.timer.getDelta() * 1000 / 125)
				end
				self.creationprog = MaterialDesignUtils.easing_curves.std_curve:evaluate(self.creationtime)
			end
		end
	local title = opt_label or TextLabel(0, fontawesome:getHeight() * 5/8 - font:getHeight() / 2, 0, nil, nil, title, false, font, nil, textColor, nil, true, tCornerRadius)
		title:addTo(container)
	local close = opt_button or TextLabel(width - fontawesome:getWidth(fontawesome_loaded and "" or "X") * 3/2, 0, 0, fontawesome:getWidth(fontawesome_loaded and "" or "X") * 3/2, (fontawesome:getBaseline() - fontawesome:getHeight() + fontawesome:getAscent()) * 7/5, fontawesome_loaded and "" or "X", true, fontawesome, MaterialDesignUtils.palettes.palette_red.pri.s700, MaterialDesignUtils.palettes.palette_red.pri.s50, MaterialDesignUtils.palettes.palette_red.pri.s700, true, bCornerRadius)
		close:addTo(container)
		if not opt_button then
			close.bgColor.a = 0
			close.hovertime = 0
			close.hoverprog = 0
			function close:postupdate()
				if self.entered then
					self.hovertime = math.min(1, self.hovertime + love.timer.getDelta() * 1000 / 125)
				else
					self.hovertime = math.max(0, self.hovertime - love.timer.getDelta() * 1000 / 125)
				end
				self.hoverprog = MaterialDesignUtils.easing_curves.std_curve:evaluate(self.hovertime)
				self.normBgA = self.hoverprog * 255
				self.normBorderA = self.hoverprog * 255
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
					elseif raw == "return" then
						if enterCond(name_input.text) then
							beholder.stopObserving(name_input.parent.keyid)
							WindowUtils.open_windows[name_input.parent.windowID].closing = true
							func(name_input.text)
						end
					else
						--if name_input.fontdata.size.x + name_input.fontdata.font:getWidth(text) < name_input.dim.x then
							name_input:changeText(name_input.text..text)
						--end
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
							--if self.fontdata.size.x + name_input.fontdata.font:getWidth(text) < name_input.dim.x then
								self:changeText(self.text..text)
							--end
						end
					end)
					if self.bgColor then self.bgColor = self.bgColor:shade(0.05) end
					if self.borderColor then self.borderColor = self.borderColor:shade(0.05) end
				end
			end
		end
	if not WindowUtils.open_windows[id] then
		WindowUtils.open_windows[id] = container
	end
end

function WindowUtils.createPopup(id, x, y, z, width, height, cCornerRadius, msg, font, bgColor, textColor, borderColor, timeOpen, opt_container, opt_label, shadowDisplayed)
	local container = opt_container or Container(x, y, z, width, height, bgColor, borderColor, true, cCornerRadius, shadowDisplayed)
	container.windowID = id or "BLANK"
	if not opt_container then
		container.creationtime = 0
		container.creationprog = 0
		container.closing = false
		container.clock = 0
		container.maxTime = timeOpen
		function container:postupdate()
			if self.creationtime <= 1 and not self.closing then
				if self.borderColor then self.borderColor.a = self.creationprog * 255 end
				if self.bgColor then self.bgColor.a = self.creationprog * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = self.creationprog * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = self.creationprog * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = self.creationprog * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.min(1, self.creationtime + love.timer.getDelta() * 1000 / 125)
			elseif self.closing then
				if self.creationtime == 0 then WindowUtils.open_windows[self.windowID] = nil end
				if self.borderColor then self.borderColor.a = self.creationprog * 255 end
				if self.bgColor then self.bgColor.a = self.creationprog * 255 end
				for i, v in ipairs(self.children) do
					if v.bgColor then v.bgColor.a = self.creationprog * (v.normBgA and v.normBgA or 255) end
					if v.textColor then v.textColor.a = self.creationprog * (v.normTextA and v.normTextA or 255) end
					if v.borderColor then v.borderColor.a = self.creationprog * (v.normBorderA and v.normBorderA or 255) end
				end
				self.creationtime = math.max(0, self.creationtime - love.timer.getDelta() * 1000 / 125)
			end
			self.creationprog = MaterialDesignUtils.easing_curves.std_curve:evaluate(self.creationtime)
			self.clock = math.min(self.maxTime, self.clock + love.timer.getDelta())
			if self.clock == self.maxTime then
				self.closing = true
			end
		end
	end
	local text = opt_label or TextLabel((width - font:getWidth(msg)) / 2, (height - font:getHeight()) / 2, 0, nil, nil, msg, false, font, nil, textColor, nil, true, 0, false)
	text:addTo(container)
	if not WindowUtils.open_windows[id] then
		WindowUtils.open_windows[id] = container
	end
end

return WindowUtils
