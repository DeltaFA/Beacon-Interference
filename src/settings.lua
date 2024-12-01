data:extend({
	{
		type = "int-setting",
		name = "beacon-rebalance-module-slots",
		order = "a-a",
		setting_type = "startup",
		default_value = 10,
		minimum_value = 1,
		maximum_value = 20,
	},
	{
		type = "int-setting",
		name = "beacon-rebalance-supply-area-distance",
		order = "a-b",
		setting_type = "startup",
		default_value = 10,
		minimum_value = 1,
		maximum_value = 30,
	},
	{
		type = "double-setting",
		name = "beacon-rebalance-distribution-effectivity",
		order = "b-a",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.1,
		maximum_value = 2,
	},
	{
		type = "double-setting",
		name = "beacon-rebalance-distribution-effectivity-per-quality",
		order = "b-b",
		setting_type = "startup",
		default_value = 0.2,
		minimum_value = 0,
		maximum_value = 1,
	}
})