/obj/item/weapon/storage/bag/fossils
	name = "Fossil Satchel"
	desc = "Transports delicate fossils in suspension so they don't break during transit."
	icon = 'icons/obj/xenoarchaeology/tools.dmi'
	icon_state = "fossil_satchel"
	item_state = "fossil_satchel"
	slot_flags = SLOT_FLAGS_BELT | SLOT_FLAGS_POCKET
	w_class = SIZE_SMALL
	storage_slots = 50
	max_w_class = SIZE_SMALL
	can_hold = list(
 		/obj/item/weapon/fossil,
 		/obj/item/weapon/ore/strangerock)
