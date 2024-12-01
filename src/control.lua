local beacons = require("beacons")

--initiate storage
script.on_init(function()
	storage.overloaded_machines = {}
end)

--check changed beacons / entities
local function on_entity_added(event)
	local entity = event.created_entity or event.entity
	if entity == nil or not entity.valid then return end
	if entity.type == "beacon" then
		beacons.on_beacon_change(entity, false)
	elseif entity.prototype.effect_receiver then
		beacons.check_machine(entity)
	end
end

local function on_entity_removed(event)
	local entity = event.created_entity or event.entity
	if entity == nil or not entity.valid then return end
	if entity.type == "beacon" then
		beacons.on_beacon_change(entity, true)
	end
end


script.on_event(defines.events.on_built_entity, on_entity_added)
script.on_event(defines.events.on_robot_built_entity, on_entity_added)
script.on_event(defines.events.script_raised_built, on_entity_added)
script.on_event(defines.events.script_raised_revive, on_entity_added)

script.on_event(defines.events.on_entity_died, on_entity_removed)
script.on_event(defines.events.on_pre_player_mined_item, on_entity_removed)
script.on_event(defines.events.on_robot_pre_mined, on_entity_removed)
script.on_event(defines.events.script_raised_destroy, on_entity_removed)

--keep the alert
script.on_nth_tick(300, beacons.alert_loop)
