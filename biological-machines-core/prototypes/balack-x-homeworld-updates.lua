local dh = require("__biological-machines-core__.data-helper")



dh.remove_ingredient("bm-interstellar-energy-link", "low-density-structure")
dh.add_ingredient("bm-interstellar-energy-link", "item", "bm-radiation-sheilding", 100)



K2_WIND_TURBINE_ZARS_FORK.OVERRIDE_SOLAR_POWER_SCALING["bm-dyson-sphere"] = 0
