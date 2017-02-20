local rgb, rgba, hex, hsl, hsv = unpack(require("zUI/Color"))
local palettes = {}
    palettes.palette_indigo = {}
    palettes.palette_purple = {}
    palettes.palette_red = {}
    palettes.palette_green = {}
    palettes.palette_blue = {}
    palettes.palette_pink = {}
    palettes.palette_dpurple = {}
    palettes.palette_lblue = {}
    palettes.palette_cyan = {}
    palettes.palette_teal = {}
    palettes.palette_lgreen = {}
    palettes.palette_lime = {}
    palettes.palette_yellow = {}
    palettes.palette_amber = {}
    palettes.palette_orange = {}
    palettes.palette_dorange = {}
    palettes.palette_brown = {}
    palettes.palette_grey = {}
    palettes.palette_bgrey = {}
local easing_curves = {}
    easing_curves.std_curve = love.math.newBezierCurve(0, 0, 0.4, 0, 0.2, 1, 1, 1)
    easing_curves.decel_curve = love.math.newBezierCurve(0, 0, 0, 0, 0.2, 1, 1, 1)
    easing_curves.accel_curve = love.math.newBezierCurve(0, 0, 0.4, 0, 1, 1, 1, 1)
    easing_curves.sharp_curve = love.math.newBezierCurve(0, 0, 0.4, 0, 0.6, 1, 1, 1)

palettes.palette_indigo.pri = {}
palettes.palette_indigo.pri.s50 = rgba(233, 234, 246, 255)
palettes.palette_indigo.pri.s100 = rgba(197, 202, 233, 255)
palettes.palette_indigo.pri.s200 = rgba(159, 168, 218, 255)
palettes.palette_indigo.pri.s300 = rgba(121, 134, 203, 255)
palettes.palette_indigo.pri.s400 = rgba(92, 107, 193, 255)
palettes.palette_indigo.pri.s500 = rgba(63, 81, 181, 255)
palettes.palette_indigo.pri.s600 = rgba(57, 73, 171, 255)
palettes.palette_indigo.pri.s700 = rgba(48, 63, 159, 255)
palettes.palette_indigo.pri.s800 = rgba(40, 53, 147, 255)
palettes.palette_indigo.pri.s900 = rgba(26, 35, 126, 255)
palettes.palette_indigo.acc = {}
palettes.palette_indigo.acc.s100 = rgba(140, 158, 255, 255)
palettes.palette_indigo.acc.s200 = rgba(82, 109, 254, 255)
palettes.palette_indigo.acc.s400 = rgba(61, 90, 254, 255)
palettes.palette_indigo.acc.s700 = rgba(48, 79, 254, 255)
palettes.palette_indigo.text = {}
palettes.palette_indigo.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_indigo.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_purple.pri = {}
palettes.palette_purple.pri.s50 = rgba(243, 229, 245, 255)
palettes.palette_purple.pri.s100 = rgba(225, 190, 231, 255)
palettes.palette_purple.pri.s200 = rgba(205, 147, 215, 255)
palettes.palette_purple.pri.s300 = rgba(186, 104, 200, 255)
palettes.palette_purple.pri.s400 = rgba(171, 71, 187, 255)
palettes.palette_purple.pri.s500 = rgba(156, 39, 176, 255)
palettes.palette_purple.pri.s600 = rgba(142, 36, 170, 255)
palettes.palette_purple.pri.s700 = rgba(123, 31, 162, 255)
palettes.palette_purple.pri.s800 = rgba(106, 27, 154, 255)
palettes.palette_purple.pri.s900 = rgba(74, 20, 140, 255)
palettes.palette_purple.acc = {}
palettes.palette_purple.acc.s100 = rgba(234, 129, 252, 255)
palettes.palette_purple.acc.s200 = rgba(224, 64, 251, 255)
palettes.palette_purple.acc.s400 = rgba(213, 0, 249, 255)
palettes.palette_purple.acc.s700 = rgba(170, 0, 255, 255)
palettes.palette_purple.text = {}
palettes.palette_purple.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_purple.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_red.pri = {}
palettes.palette_red.pri.s50 = rgba(255, 235, 238, 255)
palettes.palette_red.pri.s100 = rgba(255, 205, 210, 255)
palettes.palette_red.pri.s200 = rgba(238, 154, 154, 255)
palettes.palette_red.pri.s300 = rgba(230, 115, 115, 255)
palettes.palette_red.pri.s400 = rgba(239, 83, 80, 255)
palettes.palette_red.pri.s500 = rgba(244, 67, 54, 255)
palettes.palette_red.pri.s600 = rgba(229, 57, 53, 255)
palettes.palette_red.pri.s700 = rgba(210, 47, 47, 255)
palettes.palette_red.pri.s800 = rgba(198, 40, 40, 255)
palettes.palette_red.pri.s900 = rgba(184, 28, 28, 255)
palettes.palette_red.acc = {}
palettes.palette_red.acc.s100 = rgba(255, 138, 128, 255)
palettes.palette_red.acc.s200 = rgba(255, 82, 82, 255)
palettes.palette_red.acc.s400 = rgba(255, 23, 68, 255)
palettes.palette_red.acc.s700 = rgba(213, 0, 0, 255)
palettes.palette_red.text = {}
palettes.palette_red.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_red.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_green.pri = {}
palettes.palette_green.pri.s50 = rgba(232, 245, 233, 255)
palettes.palette_green.pri.s100 = rgba(200, 230, 201, 255)
palettes.palette_green.pri.s200 = rgba(165, 214, 167, 255)
palettes.palette_green.pri.s300 = rgba(129, 199, 132, 255)
palettes.palette_green.pri.s400 = rgba(102, 187, 106, 255)
palettes.palette_green.pri.s500 = rgba(76, 175, 80, 255)
palettes.palette_green.pri.s600 = rgba(67, 159, 71, 255)
palettes.palette_green.pri.s700 = rgba(56, 142, 60, 255)
palettes.palette_green.pri.s800 = rgba(46, 125, 50, 255)
palettes.palette_green.pri.s900 = rgba(27, 94, 32, 255)
palettes.palette_green.acc = {}
palettes.palette_green.acc.s100 = rgba(185, 246, 202, 255)
palettes.palette_green.acc.s200 = rgba(105, 240, 174, 255)
palettes.palette_green.acc.s400 = rgba(0, 230, 118, 255)
palettes.palette_green.acc.s700 = rgba(0, 200, 83, 255)
palettes.palette_green.text = {}
palettes.palette_green.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_green.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_blue.pri = {}
palettes.palette_blue.pri.s50 = rgba(226, 241, 252, 255)
palettes.palette_blue.pri.s100 = rgba(187, 222, 251, 255)
palettes.palette_blue.pri.s200 = rgba(144, 202, 249, 255)
palettes.palette_blue.pri.s300 = rgba(100, 181, 246, 255)
palettes.palette_blue.pri.s400 = rgba(66, 165, 245, 255)
palettes.palette_blue.pri.s500 = rgba(33, 150, 243, 255)
palettes.palette_blue.pri.s600 = rgba(30, 136, 230, 255)
palettes.palette_blue.pri.s700 = rgba(25, 118, 210, 255)
palettes.palette_blue.pri.s800 = rgba(21, 101, 193, 255)
palettes.palette_blue.pri.s900 = rgba(13, 71, 161, 255)
palettes.palette_blue.acc = {}
palettes.palette_blue.acc.s100 = rgba(130, 177, 255, 255)
palettes.palette_blue.acc.s200 = rgba(68, 138, 255, 255)
palettes.palette_blue.acc.s400 = rgba(41, 121, 255, 255)
palettes.palette_blue.acc.s700 = rgba(41, 98, 255, 255)
palettes.palette_blue.text = {}
palettes.palette_blue.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_blue.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_pink.pri = {}
palettes.palette_pink.pri.s50 = rgba(252, 228, 236, 255)
palettes.palette_pink.pri.s100 = rgba(249, 188, 209, 255)
palettes.palette_pink.pri.s200 = rgba(244, 142, 176, 255)
palettes.palette_pink.pri.s300 = rgba(240, 98, 146, 255)
palettes.palette_pink.pri.s400 = rgba(236, 64, 122, 255)
palettes.palette_pink.pri.s500 = rgba(233, 30, 99, 255)
palettes.palette_pink.pri.s600 = rgba(215, 27, 96, 255)
palettes.palette_pink.pri.s700 = rgba(194, 24, 91, 255)
palettes.palette_pink.pri.s800 = rgba(173, 20, 87, 255)
palettes.palette_pink.pri.s900 = rgba(136, 14, 79, 255)
palettes.palette_pink.acc = {}
palettes.palette_pink.acc.s100 = rgba(255, 128, 171, 255)
palettes.palette_pink.acc.s200 = rgba(255, 64, 129, 255)
palettes.palette_pink.acc.s400 = rgba(245, 0, 87, 255)
palettes.palette_pink.acc.s700 = rgba(198, 17, 98, 255)
palettes.palette_pink.text = {}
palettes.palette_pink.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_pink.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_dpurple.pri = {}
palettes.palette_dpurple.pri.s50 = rgba(237, 231, 246, 255)
palettes.palette_dpurple.pri.s100 = rgba(209, 196, 233, 255)
palettes.palette_dpurple.pri.s200 = rgba(179, 157, 219, 255)
palettes.palette_dpurple.pri.s300 = rgba(149, 117, 205, 255)
palettes.palette_dpurple.pri.s400 = rgba(126, 87, 194, 255)
palettes.palette_dpurple.pri.s500 = rgba(103, 58, 184, 255)
palettes.palette_dpurple.pri.s600 = rgba(94, 53, 177, 255)
palettes.palette_dpurple.pri.s700 = rgba(81, 45, 168, 255)
palettes.palette_dpurple.pri.s800 = rgba(69, 39, 159, 255)
palettes.palette_dpurple.pri.s900 = rgba(49, 27, 147, 255)
palettes.palette_dpurple.acc = {}
palettes.palette_dpurple.acc.s100 = rgba(179, 136, 255, 255)
palettes.palette_dpurple.acc.s200 = rgba(124, 77, 255, 255)
palettes.palette_dpurple.acc.s400 = rgba(101, 31, 255, 255)
palettes.palette_dpurple.acc.s700 = rgba(98, 0, 235, 255)
palettes.palette_dpurple.text = {}
palettes.palette_dpurple.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_dpurple.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_lblue.pri = {}
palettes.palette_lblue.pri.s50 = rgba(225, 245, 254, 255)
palettes.palette_lblue.pri.s100 = rgba(179, 229, 252, 255)
palettes.palette_lblue.pri.s200 = rgba(129, 212, 250, 255)
palettes.palette_lblue.pri.s300 = rgba(79, 195, 247, 255)
palettes.palette_lblue.pri.s400 = rgba(41, 182, 246, 255)
palettes.palette_lblue.pri.s500 = rgba(2, 168, 244, 255)
palettes.palette_lblue.pri.s600 = rgba(3, 155, 230, 255)
palettes.palette_lblue.pri.s700 = rgba(2, 136, 209, 255)
palettes.palette_lblue.pri.s800 = rgba(2, 119, 189, 255)
palettes.palette_lblue.pri.s900 = rgba(1, 87, 156, 255)
palettes.palette_lblue.acc = {}
palettes.palette_lblue.acc.s100 = rgba(128, 216, 255, 255)
palettes.palette_lblue.acc.s200 = rgba(64, 196, 255, 255)
palettes.palette_lblue.acc.s400 = rgba(0, 176, 255, 255)
palettes.palette_lblue.acc.s700 = rgba(0, 145, 235, 255)
palettes.palette_lblue.text = {}
palettes.palette_lblue.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_lblue.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_cyan.pri = {}
palettes.palette_cyan.pri.s50 = rgba(224, 247, 250, 255)
palettes.palette_cyan.pri.s100 = rgba(178, 235, 242, 255)
palettes.palette_cyan.pri.s200 = rgba(128, 223, 235, 255)
palettes.palette_cyan.pri.s300 = rgba(76, 207, 224, 255)
palettes.palette_cyan.pri.s400 = rgba(38, 198, 218, 255)
palettes.palette_cyan.pri.s500 = rgba(0, 188, 212, 255)
palettes.palette_cyan.pri.s600 = rgba(0, 172, 193, 255)
palettes.palette_cyan.pri.s700 = rgba(0, 151, 167, 255)
palettes.palette_cyan.pri.s800 = rgba(0, 131, 143, 255)
palettes.palette_cyan.pri.s900 = rgba(0, 95, 99, 255)
palettes.palette_cyan.acc = {}
palettes.palette_cyan.acc.s100 = rgba(133, 255, 255, 255)
palettes.palette_cyan.acc.s200 = rgba(24, 255, 255, 255)
palettes.palette_cyan.acc.s400 = rgba(0, 229, 255, 255)
palettes.palette_cyan.acc.s700 = rgba(0, 184, 212, 255)
palettes.palette_cyan.text = {}
palettes.palette_cyan.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_cyan.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_teal.pri = {}
palettes.palette_teal.pri.s50 = rgba(224, 242, 241, 255)
palettes.palette_teal.pri.s100 = rgba(179, 223, 219, 255)
palettes.palette_teal.pri.s200 = rgba(128, 203, 196, 255)
palettes.palette_teal.pri.s300 = rgba(77, 182, 172, 255)
palettes.palette_teal.pri.s400 = rgba(38, 166, 154, 255)
palettes.palette_teal.pri.s500 = rgba(0, 150, 136, 255)
palettes.palette_teal.pri.s600 = rgba(0, 136, 122, 255)
palettes.palette_teal.pri.s700 = rgba(0, 121, 107, 255)
palettes.palette_teal.pri.s800 = rgba(0, 105, 92, 255)
palettes.palette_teal.pri.s900 = rgba(0, 77, 64, 255)
palettes.palette_teal.acc = {}
palettes.palette_teal.acc.s100 = rgba(167, 255, 235, 255)
palettes.palette_teal.acc.s200 = rgba(99, 255, 218, 255)
palettes.palette_teal.acc.s400 = rgba(29, 233, 182, 255)
palettes.palette_teal.acc.s700 = rgba(0, 191, 165, 255)
palettes.palette_teal.text = {}
palettes.palette_teal.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_teal.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_lgreen.pri = {}
palettes.palette_lgreen.pri.s50 = rgba(242, 249, 234, 255)
palettes.palette_lgreen.pri.s100 = rgba(220, 237, 200, 255)
palettes.palette_lgreen.pri.s200 = rgba(197, 224, 165, 255)
palettes.palette_lgreen.pri.s300 = rgba(174, 213, 129, 255)
palettes.palette_lgreen.pri.s400 = rgba(156, 204, 101, 255)
palettes.palette_lgreen.pri.s500 = rgba(139, 195, 74, 255)
palettes.palette_lgreen.pri.s600 = rgba(124, 179, 66, 255)
palettes.palette_lgreen.pri.s700 = rgba(104, 159, 56, 255)
palettes.palette_lgreen.pri.s800 = rgba(85, 139, 47, 255)
palettes.palette_lgreen.pri.s900 = rgba(51, 105, 30, 255)
palettes.palette_lgreen.acc = {}
palettes.palette_lgreen.acc.s100 = rgba(204, 255, 144, 255)
palettes.palette_lgreen.acc.s200 = rgba(178, 255, 89, 255)
palettes.palette_lgreen.acc.s400 = rgba(118, 255, 3, 255)
palettes.palette_lgreen.acc.s700 = rgba(100, 221, 23, 255)
palettes.palette_lgreen.text = {}
palettes.palette_lgreen.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_lgreen.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_lime.pri = {}
palettes.palette_lime.pri.s50 = rgba(249, 251, 231, 255)
palettes.palette_lime.pri.s100 = rgba(240, 244, 195, 255)
palettes.palette_lime.pri.s200 = rgba(230, 238, 156, 255)
palettes.palette_lime.pri.s300 = rgba(220, 231, 117, 255)
palettes.palette_lime.pri.s400 = rgba(212, 225, 87, 255)
palettes.palette_lime.pri.s500 = rgba(206, 221, 57, 255)
palettes.palette_lime.pri.s600 = rgba(191, 201, 50, 255)
palettes.palette_lime.pri.s700 = rgba(175, 180, 43, 255)
palettes.palette_lime.pri.s800 = rgba(158, 157, 36, 255)
palettes.palette_lime.pri.s900 = rgba(130, 119, 23, 255)
palettes.palette_lime.acc = {}
palettes.palette_lime.acc.s100 = rgba(244, 255, 129, 255)
palettes.palette_lime.acc.s200 = rgba(238, 255, 65, 255)
palettes.palette_lime.acc.s400 = rgba(198, 255, 0, 255)
palettes.palette_lime.acc.s700 = rgba(174, 235, 0, 255)
palettes.palette_lime.text = {}
palettes.palette_lime.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_lime.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_yellow.pri = {}
palettes.palette_yellow.pri.s50 = rgba(255, 253, 231, 255)
palettes.palette_yellow.pri.s100 = rgba(255, 249, 196, 255)
palettes.palette_yellow.pri.s200 = rgba(255, 245, 157, 255)
palettes.palette_yellow.pri.s300 = rgba(255, 241, 119, 255)
palettes.palette_yellow.pri.s400 = rgba(255, 238, 88, 255)
palettes.palette_yellow.pri.s500 = rgba(255, 235, 59, 255)
palettes.palette_yellow.pri.s600 = rgba(252, 216, 53, 255)
palettes.palette_yellow.pri.s700 = rgba(251, 192, 45, 255)
palettes.palette_yellow.pri.s800 = rgba(249, 168, 37, 255)
palettes.palette_yellow.pri.s900 = rgba(245, 127, 23, 255)
palettes.palette_yellow.acc = {}
palettes.palette_yellow.acc.s100 = rgba(255, 255, 142, 255)
palettes.palette_yellow.acc.s200 = rgba(255, 255, 0, 255)
palettes.palette_yellow.acc.s400 = rgba(255, 234, 0, 255)
palettes.palette_yellow.acc.s700 = rgba(255, 214, 0, 255)
palettes.palette_yellow.text = {}
palettes.palette_yellow.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_yellow.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_amber.pri = {}
palettes.palette_amber.pri.s50 = rgba(255, 248, 224, 255)
palettes.palette_amber.pri.s100 = rgba(255, 236, 179, 255)
palettes.palette_amber.pri.s200 = rgba(255, 224, 130, 255)
palettes.palette_amber.pri.s300 = rgba(255, 213, 79, 255)
palettes.palette_amber.pri.s400 = rgba(255, 202, 40, 255)
palettes.palette_amber.pri.s500 = rgba(255, 193, 6, 255)
palettes.palette_amber.pri.s600 = rgba(255, 179, 0, 255)
palettes.palette_amber.pri.s700 = rgba(255, 160, 0, 255)
palettes.palette_amber.pri.s800 = rgba(255, 143, 0, 255)
palettes.palette_amber.pri.s900 = rgba(255, 111, 0, 255)
palettes.palette_amber.acc = {}
palettes.palette_amber.acc.s100 = rgba(255, 229, 128, 255)
palettes.palette_amber.acc.s200 = rgba(255, 215, 64, 255)
palettes.palette_amber.acc.s400 = rgba(255, 196, 0, 255)
palettes.palette_amber.acc.s700 = rgba(255, 171, 0, 255)
palettes.palette_amber.text = {}
palettes.palette_amber.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_amber.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_orange.pri = {}
palettes.palette_orange.pri.s50 = rgba(255, 243, 224, 255)
palettes.palette_orange.pri.s100 = rgba(255, 224, 179, 255)
palettes.palette_orange.pri.s200 = rgba(255, 204, 128, 255)
palettes.palette_orange.pri.s300 = rgba(255, 183, 77, 255)
palettes.palette_orange.pri.s400 = rgba(255, 167, 38, 255)
palettes.palette_orange.pri.s500 = rgba(255, 152, 0, 255)
palettes.palette_orange.pri.s600 = rgba(251, 140, 0, 255)
palettes.palette_orange.pri.s700 = rgba(245, 124, 0, 255)
palettes.palette_orange.pri.s800 = rgba(238, 108, 0, 255)
palettes.palette_orange.pri.s900 = rgba(230, 81, 0, 255)
palettes.palette_orange.acc = {}
palettes.palette_orange.acc.s100 = rgba(255, 209, 128, 255)
palettes.palette_orange.acc.s200 = rgba(255, 171, 64, 255)
palettes.palette_orange.acc.s400 = rgba(255, 145, 0, 255)
palettes.palette_orange.acc.s700 = rgba(255, 109, 0, 255)
palettes.palette_orange.text = {}
palettes.palette_orange.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_orange.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_dorange.pri = {}
palettes.palette_dorange.pri.s50 = rgba(251, 233, 231, 255)
palettes.palette_dorange.pri.s100 = rgba(255, 204, 187, 255)
palettes.palette_dorange.pri.s200 = rgba(255, 171, 145, 255)
palettes.palette_dorange.pri.s300 = rgba(255, 138, 101, 255)
palettes.palette_dorange.pri.s400 = rgba(255, 112, 68, 255)
palettes.palette_dorange.pri.s500 = rgba(255, 87, 34, 255)
palettes.palette_dorange.pri.s600 = rgba(244, 81, 30, 255)
palettes.palette_dorange.pri.s700 = rgba(230, 74, 25, 255)
palettes.palette_dorange.pri.s800 = rgba(215, 66, 20, 255)
palettes.palette_dorange.pri.s900 = rgba(191, 54, 12, 255)
palettes.palette_dorange.acc = {}
palettes.palette_dorange.acc.s100 = rgba(255, 158, 128, 255)
palettes.palette_dorange.acc.s200 = rgba(255, 110, 64, 255)
palettes.palette_dorange.acc.s400 = rgba(255, 61, 0, 255)
palettes.palette_dorange.acc.s700 = rgba(221, 44, 0, 255)
palettes.palette_dorange.text = {}
palettes.palette_dorange.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_dorange.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_brown.pri = {}
palettes.palette_brown.pri.s50 = rgba(238, 234, 232, 255)
palettes.palette_brown.pri.s100 = rgba(215, 204, 200, 255)
palettes.palette_brown.pri.s200 = rgba(187, 169, 163, 255)
palettes.palette_brown.pri.s300 = rgba(161, 136, 127, 255)
palettes.palette_brown.pri.s400 = rgba(142, 110, 99, 255)
palettes.palette_brown.pri.s500 = rgba(121, 85, 72, 255)
palettes.palette_brown.pri.s600 = rgba(108, 75, 64, 255)
palettes.palette_brown.pri.s700 = rgba(93, 64, 55, 255)
palettes.palette_brown.pri.s800 = rgba(78, 52, 46, 255)
palettes.palette_brown.pri.s900 = rgba(62, 39, 35, 255)
palettes.palette_brown.text = {}
palettes.palette_brown.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_brown.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_grey.pri = {}
palettes.palette_grey.pri.s50 = rgba(250, 250, 250, 255)
palettes.palette_grey.pri.s100 = rgba(245, 245, 245, 255)
palettes.palette_grey.pri.s200 = rgba(238, 238, 238, 255)
palettes.palette_grey.pri.s300 = rgba(224, 224, 224, 255)
palettes.palette_grey.pri.s400 = rgba(189, 189, 189, 255)
palettes.palette_grey.pri.s500 = rgba(158, 158, 158, 255)
palettes.palette_grey.pri.s600 = rgba(117, 117, 117, 255)
palettes.palette_grey.pri.s700 = rgba(97, 97, 97, 255)
palettes.palette_grey.pri.s800 = rgba(66, 66, 66, 255)
palettes.palette_grey.pri.s900 = rgba(33, 33, 33, 255)
palettes.palette_grey.text = {}
palettes.palette_grey.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_grey.text.s2 = rgba(235, 235, 235, 255)

palettes.palette_bgrey.pri = {}
palettes.palette_bgrey.pri.s50 = rgba(236, 239, 241, 255)
palettes.palette_bgrey.pri.s100 = rgba(207, 217, 221, 255)
palettes.palette_bgrey.pri.s200 = rgba(177, 191, 198, 255)
palettes.palette_bgrey.pri.s300 = rgba(144, 164, 173, 255)
palettes.palette_bgrey.pri.s400 = rgba(120, 144, 156, 255)
palettes.palette_bgrey.pri.s500 = rgba(96, 125, 139, 255)
palettes.palette_bgrey.pri.s600 = rgba(84, 110, 122, 255)
palettes.palette_bgrey.pri.s700 = rgba(69, 90, 99, 255)
palettes.palette_bgrey.pri.s800 = rgba(55, 71, 79, 255)
palettes.palette_bgrey.pri.s900 = rgba(38, 50, 56, 255)
palettes.palette_bgrey.text = {}
palettes.palette_bgrey.text.s1 = rgba(35, 35, 35, 255)
palettes.palette_bgrey.text.s2 = rgba(235, 235, 235, 255)

local MaterialDesignUtils = { palettes = palettes, easing_curves = easing_curves }

return MaterialDesignUtils
