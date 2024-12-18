data:extend {
	{
		type = "virtual-signal",
		name = "beacon-overload",
		icon = "__delta-beacon-rebalance__/graphics/beacon-overload.png",
		icon_size = 64
	},
	{
		type = "tips-and-tricks-item-category",
		name = "beacon-overload",
		order = "n-[delta]-b"
	  },
	  {
		type = "tips-and-tricks-item",
		name = "beacon-overload",
		category = "beacon-overload",
		order = "a",
		tag = "[entity=beacon][virtual-signal=beacon-overload]",
		is_title = true,
		trigger =
		{
			type = "build-entity",
			entity = "beacon",
			match_type_only = true
		},
		simulation = require("simulation")
	}
}