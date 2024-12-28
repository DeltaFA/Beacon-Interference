--Compatibilty with old saves

local beacons = require("beacons")

--find all beacons and trigger check
for surface_name in pairs(game.surfaces) do
	local surface = game.get_surface(surface_name)
	if surface then
		for _, beacon in pairs(surface.find_entities_filtered({type = "beacon"})) do
			beacons.on_beacon_change(beacon, false)
		end
	end
end