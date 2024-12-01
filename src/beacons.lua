local beacons = {}

--custom alert like the entity damaged one
local function alert(machine)
	for _, player in pairs(machine.force.players) do
		player.add_custom_alert(
			machine,
			{
				type = "virtual",
				name = "beacon-overload",
			},
			{ "beacon-overload.alert", "[entity="..machine.name.."] __ENTITY__"..machine.name.."__" },
			true
		)
	end
end

function beacons.check_machine(machine, removed)
	local beacon_count = machine.beacons_count or 0
	beacon_count = beacon_count - ((removed and 1) or 0)

	if (beacon_count > 1) then
		--check if machine is already overloaded
		if not storage.overloaded_machines[machine.unit_number] then
			--draw sprites and add them to the machine's table
			storage.overloaded_machines[machine.unit_number] = { machine, rendering.draw_sprite{
				sprite = "utility/entity_info_dark_background",
				x_scale = 1.2,
				y_scale = 1.2,
				target = {
					entity = machine,
					offset = {0, -0.25}
				},
				surface = machine.surface,
			}, rendering.draw_sprite{
				sprite = "virtual-signal.beacon-overload",
				x_scale = 1.2,
				y_scale = 1.2,
				target = {
					entity = machine,
					offset = {0, -0.25}
				},
				surface = machine.surface,
			} }

			--deactivate the machine, add a status, create alert and add popup text
			machine.active = false
			machine.custom_status = {
				diode = defines.entity_status_diode.red,
				label = { "beacon-overload.status" }
			}
			alert(machine)
			for _, player in pairs(machine.force.players) do
				if player.surface == machine.surface then
					player.create_local_flying_text{
						text = { "beacon-overload.popup" },
						position = machine.position
					}
				end
			end
		end
	elseif storage.overloaded_machines[machine.unit_number] then
		--remove the sprites
		storage.overloaded_machines[machine.unit_number][2].destroy()
		storage.overloaded_machines[machine.unit_number][3].destroy()

		--enable the machine
		machine.active = true
		machine.custom_status = nil

		--clear the table
		storage.overloaded_machines[machine.unit_number] = nil
	end
end

--iterate through all machines affected by the beacon
function beacons.on_beacon_change(beacon, removed)
	for _, machine in pairs(beacon.get_beacon_effect_receivers()) do
		beacons.check_machine(machine, removed)
	end
end

--force the overload alert to stay
function beacons.alert_loop()
	for key, value in pairs(storage.overloaded_machines) do
		machine = value[1]
		if machine.valid then
			alert(machine)
		else
			storage.overloaded_machines[key] = nil
		end
	end
end

return beacons