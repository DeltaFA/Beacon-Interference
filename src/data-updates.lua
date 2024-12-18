local function get_setting(name)
	local setting_name = "beacon-rebalance-"..name
	if settings.startup[setting_name] == nil then return nil end
	return settings.startup[setting_name].value
end

local beacon = data.raw["beacon"]["beacon"]

beacon.energy_usage = "2MW"
beacon.module_slots = get_setting("module-slots")
beacon.distribution_effectivity = get_setting("distribution-effectivity")
beacon.distribution_effectivity_bonus_per_quality_level = get_setting("distribution-effectivity-per-quality")
beacon.supply_area_distance = get_setting("supply-area-distance")

beacon.icons_positioning = {{
	inventory_index = defines.inventory.beacon_modules,
	shift = {0, 0},
	multi_row_initial_height_modifier = -0.3,
	max_icons_per_row = 5
}}

beacon.localised_description = { "", {"entity-description.beacon"}, {"beacon-overload.description"} }