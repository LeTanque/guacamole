--this is a lua script for use in conky
--[[ Lua libraries used are listed as the below "requires". Following
	are the installed libraries
	liblua5.1-oocairo0
	liblua5.1-oocairo-dev
	liblua5.1-oopango
	liblua5.1-oopango-dev
]]
require 'cairo'
function conky_main()
	if conky_window == nil then
		return
	end

	cpu=conky_parse("${cpu}")
	memory=conky_parse("${memperc}")
	home_used=conky_parse("${fs_used /home/tank}")

	local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
		cr = cairo_create(cs)
	local updates=tonumber(conky_parse('${updates}'))
	if updates>5 then
		print ("hello world")
	end
	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cr=nil
end
