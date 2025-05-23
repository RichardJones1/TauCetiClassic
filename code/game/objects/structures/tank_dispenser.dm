ADD_TO_GLOBAL_LIST(/obj/structure/dispenser, tank_dispenser_list)
/obj/structure/dispenser
	name = "tank storage unit"
	desc = "A simple yet bulky storage device for gas tanks. Has room for up to ten oxygen tanks, and ten phoron tanks."
	icon = 'icons/obj/objects.dmi'
	icon_state = "dispenser"
	density = TRUE
	anchored = TRUE
	var/oxygentanks = 10
	var/phorontanks = 10
	var/list/oxytanks = list()	//sorry for the similar var names
	var/list/platanks = list()


/obj/structure/dispenser/oxygen
	phorontanks = 0

/obj/structure/dispenser/phoron
	oxygentanks = 0


/obj/structure/dispenser/atom_init()
	. = ..()
	update_icon()


/obj/structure/dispenser/update_icon()
	cut_overlays()
	switch(oxygentanks)
		if(1 to 4)	add_overlay("oxygen-[oxygentanks]")
		if(5 to INFINITY) add_overlay("oxygen-5")
	switch(phorontanks)
		if(1 to 4)	add_overlay("phoron-[phorontanks]")
		if(5 to INFINITY) add_overlay("phoron-5")


/obj/structure/dispenser/attack_hand(mob/user)
	user.set_machine(src)
	var/dat
	dat += "Oxygen tanks: [oxygentanks] - [oxygentanks ? "<A href='byond://?src=\ref[src];oxygen=1'>Dispense</A>" : "empty"]<br>"
	dat += "Phoron tanks: [phorontanks] - [phorontanks ? "<A href='byond://?src=\ref[src];phoron=1'>Dispense</A>" : "empty"]"
	var/datum/browser/popup = new(user, "window=dispenser", "[src]")
	popup.set_content(dat)
	popup.open()
	return


/obj/structure/dispenser/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/tank/oxygen) || istype(I, /obj/item/weapon/tank/air) || istype(I, /obj/item/weapon/tank/anesthetic))
		if(oxygentanks < 10)
			user.drop_from_inventory(I, src)
			oxytanks.Add(I)
			oxygentanks++
			to_chat(user, "<span class='notice'>You put [I] in [src].</span>")
		else
			to_chat(user, "<span class='notice'>[src] is full.</span>")
		updateUsrDialog()
		return
	if(istype(I, /obj/item/weapon/tank/phoron))
		if(phorontanks < 10)
			user.drop_from_inventory(I, src)
			platanks.Add(I)
			phorontanks++
			to_chat(user, "<span class='notice'>You put [I] in [src].</span>")
		else
			to_chat(user, "<span class='notice'>[src] is full.</span>")
		updateUsrDialog()
		return
	if(iswrenching(I))
		if(anchored)
			to_chat(user, "<span class='notice'>You lean down and unwrench [src].</span>")
			anchored = FALSE
		else
			to_chat(user, "<span class='notice'>You wrench [src] into place.</span>")
			anchored = TRUE
		return

/obj/structure/dispenser/deconstruct(disassembled)
	for(var/obj/item/I as anything in contents)
		I.forceMove(loc)
	oxytanks -= oxytanks.len
	phorontanks -= platanks.len
	oxytanks.Cut()
	platanks.Cut()
	if(flags & NODECONSTRUCT)
		return ..()
	for(var/i in 1 to oxygentanks)
		new /obj/item/weapon/tank/oxygen(loc)
	for(var/i in 1 to phorontanks)
		new /obj/item/weapon/tank/phoron(loc)
	new /obj/item/stack/sheet/metal(loc, 2)
	..()

/obj/structure/dispenser/Topic(href, href_list)
	if(usr.incapacitated())
		return
	if(Adjacent(usr))
		usr.set_machine(src)
		if(href_list["oxygen"])
			if(oxygentanks > 0)
				var/obj/item/weapon/tank/oxygen/O
				if(oxytanks.len == oxygentanks)
					O = oxytanks[1]
					oxytanks.Remove(O)
				else
					O = new /obj/item/weapon/tank/oxygen(loc)
				O.loc = loc
				to_chat(usr, "<span class='notice'>You take [O] out of [src].</span>")
				oxygentanks--
				update_icon()
		if(href_list["phoron"])
			if(phorontanks > 0)
				var/obj/item/weapon/tank/phoron/P
				if(platanks.len == phorontanks)
					P = platanks[1]
					platanks.Remove(P)
				else
					P = new /obj/item/weapon/tank/phoron(loc)
				P.loc = loc
				to_chat(usr, "<span class='notice'>You take [P] out of [src].</span>")
				phorontanks--
				update_icon()
		add_fingerprint(usr)
		updateUsrDialog()
	else
		usr << browse(null, "window=dispenser")
		return
	return
