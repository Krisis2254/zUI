# zUI

A GUI engine made for Löve2D!

# Information
* *Object-Oriented*
* *Simple, Customizable*

# Usage
The simplest way to use zUI is to download it, then include each file from it you need.

*Example:*

    ...
    local WindowUtils = require("WindowUtils")
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
    ...

*Remember to unpack() Color.lua!*

# Notes

* By default, WindowUtils uses the [GitHub's Octicon ](https://octicons.github.com/) font for close buttons, and [beholder.lua](https://github.com/kikito/beholder.lua) for text input.
