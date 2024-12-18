local beacons = require("beacons")

return {
	mods = { "delta-beacon-rebalance" },
	init = [[
	game.surfaces[1].create_entities_from_blueprint_string
	{
		string = "0eNqlleuSojAQhd8lv5MpLqLgq0xZVIBGUxsCm8vMuBbvvg2s6GxFVln/mU6+c/pUQl9IIR10WihL9hciylYZsn+/ECOOisthTfEGyJ5wY6AppFBH1vDyJBSwiPSUCFXBF9mHPfUcKoAj8W5b1B8oAWWFFTAJjX/OuXJNARo59HpWqFooLLHyBMYSSrrW4DHEIR9RLErfEkrOZL97S0aFaX9uwFq0aYZ9Gpr2A3KHNWlBQ5ULCw2Wai4NUDItT06uurpVrJPcAmqWrRuSCYOAkqatxiAsk8BHR3Pvh35o/69Wohdayf6jFasd+PTjWb+BSriGgYTSalGyrpXgc7G9c+EBbmYgfHUajGGy5RVWFhrKsB177qYUOmeJh5u8wE3vuJXQ2NBYTWeV1tkHMtubzDUIUKCPZ4a3H3TNS28ok16KeoWra9C5Eb9gvBLXn0drN2vVeFWY1VyZrtWWFSAXL0AY+LNPVwNDPzB7FZjeA7+H78GHwWp+8BQ/XB1I5A8kjFYT4wfEeHUG8VMZbFbzo6f4t4dZOPkDn4kBbZffZbh5kMX2u9clVnbP+rfL21vzzqglge0ogHjRzZ/+I3DNPk8AklxL+U/HJWriFtXqBkecz0e6+ns7+vAhb4/0zyRdaiYbIDhePzGvYaK9xzSh6Co54OIwKwbMPO0p+cDBN4KSbZRtsixJgiTbhZu+/w0yWaig",
		position = {-4, -3}
	}

	game.simulation.camera_position = {-3, 0.5}
	player = game.simulation.create_test_player{name = "big k"}
	player.teleport({0, 0})
	player.character.direction = defines.direction.west
	game.simulation.camera_player = player
	game.simulation.camera_player_cursor_position = {-2.5, 2.5}
	game.simulation.camera_alt_info = false

	function start()
		local count = 180

	  	script.on_nth_tick(1, function()
			if count > 0 then count = count - 1 return end
			beacon = game.surfaces[1].find_entity("beacon", {-3.5, 2.5})
			if beacon then
				beacon.mine()
			else
				player.cursor_stack.set_stack{name = "beacon", count = 2}
				player.build_from_cursor{position = game.simulation.camera_player_cursor_position}
				player.cursor_stack.clear()
			end
			start()
	  	end)
	end

	start()
  ]]
}