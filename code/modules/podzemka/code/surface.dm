
// Mushrooms //
/obj/structure/flora/mushroom
	name = "mushroom"
	desc = "It's just a small green mushroom, nothing special about it. Why is it green? Radiation, i guess."
	icon = 'code\modules\podzemka\icons\surface.dmi'
	icon_state = "mushroom_1"
	anchored = 1

/obj/structure/flora/mushroom/atom_init()
	. = ..()
	icon_state = "mushroom_[rand(1, 4)]"

// Tall Grass //
/obj/structure/flora/tall_grass
	name = "tall grass"
	icon = 'code\modules\podzemka\icons\surface.dmi'
	icon_state = "tall_grass_1"
	anchored = 1

/obj/structure/flora/tall_grass/atom_init()
	. = ..()
	icon_state = "tall_grass_[rand(1, 4)]"

// Dense Grass //
/obj/structure/flora/dense_grass
	name = "dense grass"
	icon = 'code\modules\podzemka\icons\surface.dmi'
	icon_state = "dense_grass_1"
	anchored = 1

/obj/structure/flora/dense_grass/atom_init()
	. = ..()
	icon_state = "dense_grass_[rand(1, 4)]"

// Brushwood //
/obj/structure/flora/brushwood
	name = "brushwood"
	icon = 'code\modules\podzemka\icons\surface.dmi'
	icon_state = "brushwood_1"
	anchored = 1

/obj/structure/flora/brushwood/atom_init()
	. = ..()
	icon_state = "brushwood_[rand(1, 2)]"