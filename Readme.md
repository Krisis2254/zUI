# zUI

A GUI engine made in Lua for Löve2D!

# Information
* *Object-Oriented*
* *Simple, Customizable*

# Usage
The simplest way to use zUI is to download it, then include each file from it you need.

*Example:*

    ...
    local WindowUtils = require("zUI/WindowUtils")
    local BaseUI = require("zUI/BaseUI")
    local Animation = require("zUI/Animation")
    local Checkbox = require("zUI/Checkbox")
    local rgb, rgba, hex, hsl, hsv = unpack(require("zUI/Color"))
    local Container = require("zUI/Container")
    local Image = require("zUI/Image")
    local MaterialDesignPalettes = require("zUI/MaterialDesignPalettes")
    local TextField = require("zUI/TextField")
    local TextLabel = require("zUI/TextLabel")
    local Vec2 = require("zUI/Vec2")
    local Vec3 = require("zUI/Vec3")
    local beholder = require("zUI/beholder")
    ...

*Remember to unpack() Color.lua!*

# Notes

* By default, WindowUtils uses [Font Awesome](http://www.fontawesome.io) for close buttons, and [beholder.lua](https://github.com/kikito/beholder.lua) for text input.

* The Mouse and Hex files aren't really meant to be used, other than internally, but you *could* use Hex I suppose.

* This is licensed under the MIT license, so try not to lose the license file. :smile:
