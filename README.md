# Biological Machines: Modpack

### Warning

See BM: Planet Wit and BM: Homeworld for warnings.

### Description  

Biological Machines is a space age overhaul focused on mundane and sci-fi biological processes. This mod is the intended BM experience, although it only contains dependencies, any of which may be left out for preference/compatibility.

*Includes*

- BM: Hunger ()
- BM: Industry ()
- BM: Radioactive tissue ()
- BM: Planet Wit ()
- BM: Planet Balack ()
- BM: Homeworld ()
- BM: Cloning ()
- BM: Warp Drive ()
- BM: Core ()
- BM: K2 Assets ()

Most optional dependencies for the above mods are modified by compatibility patches which can be skipped by disabling the mod override setting. All override settings are enabled by default and can be disabled for preference/compatibility. Any compatibility patch which fixes game breaking bugs has no override setting.

### Future Plans

- Bugfixes including script/gui ups optimizations
- Balance tweaks including extra settings so players can customize the balance for their preferences
- Compatibility with content mods including Maraxis Cerys, Moshine and Orbital ion cannon
- Graphics upgrades including berry bush, circuit board, scrapyard, recipe icons and BM: Homeworld generally
- Additional content including a Gleba moon, an enemy on wit and demolisher spawners on Vulcanus

If you want to help with anything, particularly with graphics or additional localizations, please let me know I would appreciate it.  

### Other Supported Mods

*Utility*

- [Editor Extensions](https://mods.factorio.com/mod/EditorExtensions) by raiguard
- [Cursor Enhancements](https://mods.factorio.com/mod/CursorEnhancements?from=search) by raiguard
- [Rate calculator](https://mods.factorio.com/mod/RateCalculator) by raiguard
- [Factory Planner](https://mods.factorio.com/mod/factoryplanner) by Therenas
- [P.U.M.P.](https://mods.factorio.com/mod/pump) by Xcone
- [Mining patch planner](https://mods.factorio.com/mod/mining-patch-planner) by rimbas

*Graphics*

- [Visible planets in space](https://mods.factorio.com/mod/visible-planets) by Nauviax
- [4k planets](https://mods.factorio.com/mod/4k_planets) by grog2
- [Cleaned concrete](https://mods.factorio.com/mod/CleanedConcrete) by JusticeDroid
- [Bullet tracers](https://mods.factorio.com/mod/visual_tracers) by kittah_khan
- [Smooth Platform Walls](https://mods.factorio.com/mod/smooth_platform_walls) by wretlaw120

*Content*

- [Text Plates](https://mods.factorio.com/mod/textplates?from=search) by Earendel
- [Pollution detector](https://mods.factorio.com/mod/pollution-detector) by Schorty
- [Extra Storage Tanks: Tiny Storage Tanks](https://mods.factorio.com/mod/est-tiny-storage-tank) by ZarSasha
- [Wood Walls and floors](https://mods.factorio.com/mod/Wood-Walls) by zanven
- [Big wooden pole](https://mods.factorio.com/mod/big-wooden-pole) by ElAdamo

### Credit

Inspiration and concepts of a plan from [AAI Industry](https://mods.factorio.com/mod/aai-industry?from=search) + [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search). Specifically DoshDoshington's [playthrough and critique](https://www.youtube.com/watch?v=y4TIDFJaKrU&t=1872s) on Youtube.

# Biological Machines: Hunger

###  Description

Adds a hunger mechanic which consumes selected foods from the engineers inventory or the engineer starves. Different foods give the engineer passive regen/movement buffs/debuffs while they are being consumed. Also adds equipment which prevents starvation and more.

*Includes*

- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()

### Features

- Saturation, every player has a saturation level that decreases each tick, decreasing faster while injured. Once the engineers saturation runs out they automatically attempt to consume a food item from the engineers inventory (or occupied space platform inventory)
  - When a food item is consumed, passive effects are applied until the foods saturation runs out. Poor foods like nutrients apply speed debuffs while good foods like fish apply regen and/or speed buffs
  - When no food items are consumed the engineer takes starvation damage until they find food or die
- Hunger shortcut menu, rank food preferences. Only ranked foods will be consumed by the engineer
- Hunger widget, above engineers armor slot. From top to bottom displays most recent food source, how spoiled that food is and current saturation
- Alternative nutrients sources including berry bush on early game Nauvis and new bacteria on Vulcanus and Fulgora
- Basic food like berries and fish can be preserved with steam. Berries become paste while fish requires an empty can which is returned after the canned fish is consumed
- Stringfronds can be farmed on Gleba to produce fortified nutrient slurry, a food which applies a large speed buff
- Foods like fish or Bioflux can no longer be consumed as capsules to gain effects. Instead medkits and stims can be made on Gleba to provide instant regen/speed. Also nutrient wine/ethanol barrels can be consumed as capsules to apply regen buff followed by a speed debuff
- Biorecycler, equipment which prevents starvation damage when an engineers saturation is at 0, applies speed debuff instead
- Artificial organs, act as Biorecycler without the debuff and allows the consumption of u-235 which gives large movement/regen buffs
- Settings to adjust rate of food consumption at rest and when injured

### Credit

- Can graphics from [canned fish](https://mods.factorio.com/mod/canned-fish?from=search) by chesapeake
- Soy plant graphic from [food industry 2.0](https://mods.factorio.com/mod/FoodIndustry) by Oceanel
- Concept, code and graphics from [stingfrond farming](https://mods.factorio.com/mod/fluroflux) by LordMiguel
- Medkit/stims graphics from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search) by raiguard, Krastor and Linver

# Biological Machines: Industry

### Description

Adds new biological materials and intermediates to basic recipes including steel, circuits, concrete and explosives. To do so it brings several space age mechanics to the Nauvis early game including spoilage, recycling, crushing and agriculture. Also makes significant additions to Gleba including napalm and biodiesel.

*Includes*

- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()

### Features

- Trees can be farmed in the early game on Nauvis along with a new berry plant
- Steel requires carbon. Carbon can be made in the early game by burning wood/spoilage/coal in a carbonizer
- Carbon is also required for basic ammo and gunpowder which is required for piercing ammo and explosives
- Stone can be crushed and processed to make produce sand and lime. These products are required to make glass mix (smeltable into glass) and cement mix (required to make cement)
- Green circuits made with circuit boards instead of iron. Circuit boards on Nauvis can be made from stone bricks + wood resin (made from wood) or plastic + glass
- Pistons are added as an intermediate required for engine units. Iron intermediates are added to lots of building materials to make up lack of iron needed for circuits
- Nutrients can be turned into wine and refined into ethanol which is required to crack oil
- Ore smelting produces slag byproduct which can be crushed into sand carbon and sulfur
- Waste items can be voided in a scrapyard and fluid in an offshore dump
- Seeds can be turned into seed oil then heavy oil after unlocking biodiesel tech on Gleba
- Optionally adds ability to farm Boompuff on Gleba, producing puff gas. Gas can be used to produce grenades, explosives and napalm, a more damaging flamethrower fuel
- Optionally slightly increase complexity of inner planet science packs

### Supported Mods

- [AAI Loaders](https://mods.factorio.com/mod/aai-loaders) by Earendel. Changes recipes to be more in line with BM: Industry splitters
- [Slipstack agriculture](https://mods.factorio.com/mod/slipstacks) by LordMiguel. Changes spore recipe
- [Larger lamps 2.0](https://mods.factorio.com/mod/LargerLamps-2_0) by goakiller900. Changes recipes, removes all but 1 lamp
- [Hypercell substation](https://mods.factorio.com/mod/snouz_better_substation) by snouz. Changes tech and recipe
- [Shield projector](https://mods.factorio.com/mod/shield-projector) by earendel. Changes tech and recipe
- [Pollution detector](https://mods.factorio.com/mod/pollution-detector) by Schorty. Changes recipe and tech prereqs
- [Big wooden pole](https://mods.factorio.com/mod/big-wooden-pole) by ElAdamo. Reduces copper cost and moves order after small wooden pole

### Credit

- concept, code and graphics from [boompuff farming](https://mods.factorio.com/mod/boompuff-agriculture?from=downloaded) by LordMiguel
- concept and code from [diverse external rocket parts](https://mods.factorio.com/mod/diverse-external-rocket-parts) by ShaneS15_
- sand resource graphics/code from [factorio+](https://mods.factorio.com/mod/factorioplus) by fishbus
- Glass plate icon from [glass](https://mods.factorio.com/mod/Glass) by GotLag
- Graphics/code from [Offshore dump](https://mods.factorio.com/mod/offshore-dump/downloads) by chocoman
- Sand/potash/lime/potassium nitrate graphics from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search) by raiguard, Krastor and Linver

# Biological Machines Radioactive Tissue

### Description

Adds tissue dropped by biter nests which may be cultivated in a biochamber using bioflux and u-235. The tissue may be crafted into a new nuclear military science pack, various machines (including new military assembler with 50% base productivity), poison gas, uranium ore (centrifuge) and clones.

*Includes*

- BM: Cloning ()
- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()

### Features

- Biter nests drop radioactive tissue which can be turned into a new nuclear science pack
- Tissue can also be turned into poison which is used in poison gun ammo, poison capsules and poison landmines. Poison damage can be increased via infinite tech, requires nuclear science pack
- Tissue can be propagated with bioflux and u-235 and processed with iron ore into uranium ore. This loop can yield net positive uranium
- Nuclear science packs now required to unlock nuclear bomb, uranium ammo, biolab, spidertron, portable nuclear reactor and railgun
- Biolab also consumes u-235 as fuel instead of electricity
- Military assembler is unlocked via nuclear science packs and gives 50% base productivity
- Poison gas can be used to make grenades, bullets and mines and its damage is increased with an infinite research
- Clones, after Aquilo tissue may be turned into clones which can be held in tanks for when the player respawns. Quality clones give the engineer increased health and mining/crafting/running speed

### Supported Mods

- [K2 Shelter](https://mods.factorio.com/mod/shelter-k2) by zanven. Complicates shelter recipe and move the tech later
- [Ironclad gunboat and mortar turret (fork)](https://mods.factorio.com/mod/ironclad-gunboat-and-mortar-turret-fork) by Keysivi. Adds poison/fire mortar ammo to  relavent infinite damage technologies
- [Handcannon](https://mods.factorio.com/mod/snouz-handcannon) by snouz. Adds nuclear military science pack as prereq for the handcannon

### Credit

- Code from [K2 Advanced Assembly Machine](https://mods.factorio.com/mod/AdvancedAssemblyMachineStandalone) by RockPaperKatana
- Code for cutscene and player quality from [player recycling](https://mods.factorio.com/mod/player-recycling?from=search) by PickledCow
- Military assembler graphics and code from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search) by raiguard, Krastor and Linver

# Biological Machines: Planet Wit

### Warning

Burner buildings (including the stone furnace and boiler) cannot be placed on Wit. Bring at least 1 solar panel, 1 electric furnace and 1 power pole to get started.

### Description

Adds Wit, a moon of Nauvis covered in asteroid craters, glass, helium and coper sulfate. Use these resources to produce helium power cells, a necessary ingredient in space science, laser turrets and the robotics facility (req to craft asteroid collectors, 50% base prod). Return post Aquilo for interstellar science pack.

*Includes*

- BM: Warp Drive ()
- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()

### Features

- New planet Wit, a moon of Nauvis. Connection to Nauvis contains small asteroids but there are only chunks in Wit orbit
- Space science packs are now made on Wit and are required to unlock asteroid collectors. Ship materials to make thruster fuel and oxidizer to a starter platform and ride it to Wit to get started
- Asteroid ore can be mined to get metallic, carbonic and oxide asteroids which can be crushed to get basic resources
- Glass ore can be mined to get glass shards which can be crafted into bricks, landfill, rails or glass plates
- Copper sulfate can be mined and mixed with water to produce copper dust and sulfuric acid
- Thruster fuel and oxidizer can be produced on wit and are required to produce petroleum products like plastic, lubricant and rocket fuel
- Helium gas which must be pumped from the ground and is used in helium power cells, a requirement for lasers and the robotics facility
- Adds a robotics facility which has 50% base productivity and is required to produce asteroid collectors, spidertrons and mech armor
- Adds glass dust which can be pumped from the craters and filtered for glass shards. Fluid can also be dumped into the crater with an offshore dump
- Adds mixed gas power cells which are used to produce interstellar science packs and the buildings they unlock including advanced accumulators
- Optionally moves logistics system tech to pre space science tier so the engineer can set up full logistics on Nauvis before traveling to Wit
- Optionally adds advanced solar panels and equipment made with helium power cells
- Optionally changes combat robot recipes to require flying robot frames and more advanced intermediates. Also extends their lifetimes

### Supported Mods

- [AAI Signal Transmission](https://mods.factorio.com/mod/aai-signal-transmission) by Earendel. Complicates the recipes
- [Personal tesla defense equipment](https://mods.factorio.com/mod/PersonalTeslaDefenseEquipment) by  pluralmonad. Changes recipe and tech
- [Repair turret](https://mods.factorio.com/mod/Repair_Turret?from=downloaded) by Klonan. Changes tech and recipe
- [Reach equipment](https://mods.factorio.com/mod/reach-equipment) by between walls. Changes tech and recipe

### Credit

- Goblin ore graphics from [factorio+](https://mods.factorio.com/mod/factorioplus) by fishbus
- Concept and moon/interstellar science graphics from [Muluna](https://mods.factorio.com/mod/planet-muluna?from=search), Moon of Nauvis by MeteorSwarm
- Glass plate icon from [glass](https://mods.factorio.com/mod/Glass) by GotLag
- [Offshore dump](https://mods.factorio.com/mod/offshore-dump/downloads) graphics/code by chocoman
- Glass dust/copper dust graphics from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search by raiguard, Krastor and Linver
- Graphics for advanced accumulator from [Research Center](https://mods.factorio.com/user/hurricane046) by Hurricane046
- Advanced accumulator code from [Quality condensor](https://mods.factorio.com/mod/quality-condenser?from=search) by Quezler

# Biological Machines: Planet Balack

### Description

Adds Balack, a post aquilo planet containing new scrap, oil sludge and strong enemies. A single bio fabricator can be placed at spawn and is required to produce new intermediates and products including a new module at the cost of massive pollution. The intermediates can be used to produce tank mk2, mech armor mk2 and warp drive.

*Includes*

- BM: Warp Drive ()
- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()

### Features

- New planet, Balack, connected to Fulgora, Aquilo and solar systems edge with huge asteroids in the way
- Balack and shattered planet unlocked with promethium science packs. Starter packs can be made with chunks mined from promethium ore on Fulgora
- Balack is covered in thick cloud and is completely dark without nightvision equipment. There is no solar power so startup energy must come from wind turbines
- Surface has promethium ore, a new scrap and an oil sludge ocean. Scrap can be broken down into machinery intermediates, carbon based materials and uranium-238. Oil sludge can be filtered into water, spoilage and oil
- Spawn has 4 electric turrets surounding a green patch on the ground, the only place a new bio fabricator can be placed. The bio fabricator has a number of unique recipes and outputs a lot of pollution
- Tinted ruin vaults are spawners for armored biters and pentapods. The vaults are indestructable and spawn outside of a large starting circle. Worms and pentapod shells filled with wrigglers do spawn in the starting area
- The armored biters spawn worms when killed and all the pentapods spawn lots of wrigglers. Balack enemies have a lot of health and resistance but are most vulnerable to physical/explosive damage
- The bio fabricator can make ai modules with all 4 t3 modules and quantum processors. They give large speed buff with a large quality/productivity/consumption debuff. The modules can be activated for 15 min by feeding them u-235, flipping quality to a large buff and increasing polution debuff
- The bio fabricator can also make radiation sheilding from promethium chunks and other intermediates. The rad sheilding and ai control units are required to produce an improved tank and mech armor as well as warp drive parts and power cells
- Hypersonic machine gun ammo can be made with radiation shielding and deals massive damage
- Optionally adds shattered planet surface. Surface covered promethium ore and a free electric grid. Promethium science can be crafted on the surface. Altered promethium asteroids float by, exploding randomly but vulnerable to lasers

### Supported Mods

- [Promethium belts](https://mods.factorio.com/mod/promethium-belts?from=search) by Helios467
- [Buggis Nuclear Bots](https://mods.factorio.com/mod/BuggisNuclearBots?from=search) by Buggi

### Credit

- Planet graphics from [4k planets](https://mods.factorio.com/mod/4k_planets?from=search) by Grog2
- Concept for spoilable module from [Yeild Module](https://mods.factorio.com/mod/yield-module?from=search) by AnotherZach
- Graphics and code for darkness from [Tenebris](https://mods.factorio.com/mod/tenebris?from=search) by Big_J
- Graphics for bio fabricator from [Pathogen Lab](https://mods.factorio.com/user/hurricane046) by Hurricane046
- Graphics/code from [Offshore dump](https://mods.factorio.com/mod/offshore-dump/downloads) by chocoman
- Oil sludge/warp power cell/tier II graphics from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search) by raiguard, Krastor and Linver
- Hypersonic ammo graphics/code from [Tungsten ammo](https://mods.factorio.com/mod/tungsten-munition) by Hanuryk

# Biological Machines: Homeworld

### Warning

Any sufficient platforms sent to the new system will be destroyed. Also, bring construction materials to the dyson sphere construction platform as nothing is provided.

### Description

Use a warp drive to travel back to the engineers home star. Land on a dyson sphere construction platform to exchange materials for credits. Spend the credits on different materials and power uplinks which can send the power of the dyson sphere to the engineers factories. Also includes a new ending.

*Includes*

- BM: Warp Drive ()
- BM: Cloning ()
- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()

### Features

- An input chest (green) to deposit materials and an output chest (gold) where coin is deposited. Input materials are removed instantly from the chest and tallied until sufficient materials have been deposited to complete a transaction.
  - Every payment is 200 credits but the different required materials take different initial amounts and the required amount of any requested material increases by 10% of the initial amount every time a payment is made.
  - Gui format for a single line in as follows {item icon} input amount / required amount for next transaction (completed transaction count)
  - Requested materials include space platform foundation, tungsten plate, processing units, lds, electric engine units, superconductors, supercapacitors and more
- Credits can be traded in a market which can be made from iron and steel but can only be placed on the construction platform.
  - All requested materials can be bought in the market plus a few others like rocket fuel or silos
  - Market productivity research affects all trades in the market
- Free power is provided on the construction platform from the output (gold) chest
- Adds super credits which can be purchased with credits in the market and recycled with quality modules to produce high quality, non super credits
- Send a space platform with a suspended clone to a new, uncolonized solar system to get a large amount of credits at the construction platform. The new system is not accesible by the player and any platform sent there will be removed from the game
  - insufficient platforms will be returned to the solar system edge location, including platforms without a clone or platforms with an active engineer
  - Sending your first clone to colonize a new world will trigger the new victory screen

### Credit

- Dyson sphere construction platform graphics from [Metal and Stars](https://mods.factorio.com/mod/metal-and-stars) by 5forsilver
- New system graphics from [New Star Graphics](https://mods.factorio.com/mod/sun-graphics?from=search) by bunshaman
- Energy link entity and various item/recipe graphics from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search) by raiguard, Krastor and Linver

# Biological Machines: Cloning

### Description

Clones can be made in a biochamber and stored in dedicated tanks. Getting in a tank will fill the tank and open a respawn screen where the engineer can respawn at any filled tank or at the default spawn. Higher quality clones will have increased health, running speed, crafing speed and mining speed.

*Includes*

- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()
- BM: Radioactive tissue ()
- BM: Homeworld ()

### Features

- Clones grown in biochambers may be placed in tanks. The tanks have 3 states, empty, prepared and filled.
  - Only empty tanks are blueprint-able
  - Prepared tanks are enterable, instantly respawning the player and filled tanks can be respawned at
  - Filled or prepared tanks can be renamed and the new name will be used in the respawn menu
- When a player respawns they are made temporarily invulnerable while they select where to respawn
- Filled tanks constantly consume suspension fluid and empty tanks must be filled with suspension fluid to allow a player to enter
- When a player respawns at a tank their engineer gains the quality of the clone originally placed in the tank. Higher quality clone bodies gives the engineer increased health and mining/crafting/running speed
### Credit
- Graphics and code from [Cloning Vat](https://mods.factorio.com/mod/Cloning-vat-building?from=search) by snouz

# Biological Machines: Warp Drive

### Description

Adds a warp drive machine which consumes warp power cells to transport a space platform to the next space location instantly. Platform must be moving forward to be teleported.

*Includes*

- BM: Core ()
- BM: K2 Assets ()

*Included in*

- BM: Modpack ()
- BM: Planet Wit ()
- BM: Planet Balack ()
- BM: Homeworld ()

### Features

- Warp drive, available post Aquilo and craft-able only in space. Consumes massive amount of power and a warp drive to teleport moving platforms to the next space location
- If the platform is not moving towards a location when the warp drive finished the warp recipe, the consumed power cell will be returned to the warp drives input. Shut off the drive when not traveling to conserve power
- Warp power cell productivity research

### Credit

- Graphics for warp drive from warp drive from [Quantum Stabilizer](https://mods.factorio.com/user/hurricane046) by Hurricane046
- Warp power cell/warp recipe graphics from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search by raiguard, Krastor and Linver

# Biological Machines: Core

### Description

Contains shared modules and compatibility patches for other Biological Machines mods. Does nothing on its own by default although some modules can be enabled as standalone via mod settings.

*Includes*

- BM: K2 Assets ()

*Included in*

- BM: Modpack ()
- BM: Hunger ()
- BM: Industry ()
- BM: Radioactive tissue ()
- BM: Planet Wit ()
- BM: Planet Balack ()
- BM: Homeworld ()
- BM: Cloning ()
- BM: Warp Drive ()

### Standalone Modules

- *Bot start*, adds a repair harness and 10 bots to players starting inventory
  - Auto included with BM: Modpack
  - Internal setting name is bm-bot-start-standalone
- *Alternative nutrients*, adds source of nutrients to early game Nauvis and Vulcanus/Fulgora. This includes plant-able berries on Nauvis and new bacteria to Vulcanus/Fulgora. Also adds nutrient wine and ethanol which may be consumed to gain a short regen buff followed by a movement speed debuff
  - Auto included with BM: Hunger and BM: Industry
  - Internal setting name is bm-alternative-nutrients-standalone
- *Scrapyard*, adds an early game recycler which consumes no power, is less space efficient and outputs a lot of pollution
  - Auto included with BM: Industry and BM: Planet Wit
  - Internal setting name is bm-scrapyard-standalone
- *Reinforced wall*, adds a more durable wall made from refined concrete and tungsten plate
  - Auto included with BM: Radioactive Tissue and BM: Planet Balack
  - Internal setting name is bm-reinforced-wall-standalone

### Modding Support

Third party mods with BM: Core as a dependency can use the following tools

- *Data helper*, a util file with functions to manipulate data in the prototype stage. Load into your mod by calling

  `local dh = require("__biological-machines-core__.data-helper")`

- *Full resistances*, a table containing entity prototypes which will be made 100% resistant to all damage in the data-final-fixes stage. Mark an entity for full resistance in the data or data-updates stages by calling

  `ENTITY_PROTOTYPE = data.raw[ENTITY_TYPE][ENTITY_NAME]  
  table.insert(bm_add_full_resistences, ENTITY_PROTOTYPE)`

- *All science*, a table containing names of technologies which will be made to consume all science packs during the data-final-fixes stage. Mark a technology for all science in the data or data-updates stages by calling

  `table.insert(bm_add_all_packs, TECHNOLOGY_NAME)`

- *Standalone modules*, a global function to force a standalone module to be loaded and hide the setting. Call the function in any of the setting stages using the standalone modules internal setting name

  `BM_STANDALONE_SETTING_OVERRIDE(INTERNAL_SETTING_NAME)`

### Credit

- Repair harness graphics/code from [survival gear](https://mods.factorio.com/mod/SurvivalGear) by GotLag
- Glass plate icon from [glass](https://mods.factorio.com/mod/Glass) by GotLag
- Graphics/code from [Offshore dump](https://mods.factorio.com/mod/offshore-dump/downloads) by chocoman

# Biological Machines: K2 Assets

### Description

Does nothing on its own. Derived from Krastorio 2 and kept separate for BM mods to comply with K2's license.

Please let me know if I am not properly complying with the license and I will fix ASAP.

*Included in*

- BM: Modpack ()
- BM: Hunger ()
- BM: Industry ()
- BM: Radioactive tissue ()
- BM: Planet Wit ()
- BM: Planet Balack ()
- BM: Homeworld ()
- BM: Cloning ()
- BM: Warp Drive ()
- BM: Core ()

### Credit

- Graphics and code from [Krastorio 2](https://mods.factorio.com/mod/Krastorio2?from=search) by raiguard, Krastor and Linver
