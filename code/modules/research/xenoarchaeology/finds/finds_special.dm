

// a talking gas mask!
/obj/item/clothing/mask/gas/poltergeist
	flags = HEAR_TALK
	var/list/heard_talk = list()
	var/last_twitch = 0
	var/max_stored_messages = 100

/obj/item/clothing/mask/gas/poltergeist/atom_init()
	. = ..()
	START_PROCESSING(SSobj, src)

var/global/list/bad_messages = list("Never take me off, please!",
		"They all want to wear me... But I'm yours!",
		"They're all want to take me from you! Bastards!",
		"We are one",
		"I want to be only yours!",
		"Help me!")

/obj/item/clothing/mask/gas/poltergeist/process(mob/living/H)
	if(heard_talk.len && isliving(src.loc) && prob(20))
		var/mob/living/M = src.loc
		if(M.stat == CONSCIOUS)
			M.say(pick(heard_talk))
	if(isliving(src.loc) && prob(2))
		var/mob/living/M = src.loc
		to_chat(M, "A strange voice goes through your head: <font color='red' size='[num2text(rand(1,3))]'><b>[pick(bad_messages)]</b></font>")

/obj/item/clothing/mask/gas/poltergeist/hear_talk(mob/M, text)
	..()
	if(heard_talk.len > max_stored_messages)
		heard_talk.Remove(pick(heard_talk))
	heard_talk.Add(text)
	if(isliving(src.loc) && world.time - last_twitch > 50)
		last_twitch = world.time

 // healing tool
/obj/item/weapon/strangetool
	name = "strange device"
	desc = "This device is made of metal, emits a strange purple formation of unknown origin."
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "strange_tool"
	var/last_time_used = 0

/obj/item/weapon/strangetool/attack(mob/M, mob/user, def_zone)
	emmit_healing(M)

/obj/item/weapon/strangetool/attack_self(mob/user)
	emmit_healing(user)

/obj/item/weapon/strangetool/proc/emmit_healing(mob/M)
	if(last_time_used + 50 < world.time)
		visible_message("<span class='notice'><font color='purple'>[bicon(src)]Device blinks brightly.</font></span>")
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			to_chat(C, "<span class='notice'><font color='blue'>You feel a soothing energy invigorate you.</font></span>")
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				for(var/obj/item/organ/external/BP in H.bodyparts)
					BP.heal_damage(rand(20,30), rand(20,30))
				H.blood_add(5)
				H.fixblood()
				H.nutrition += rand(30, 40)
				H.adjustBrainLoss(rand(-10, -25))
				H.radiation -= min(H.radiation, rand(20, 30))
				H.bodytemperature = initial(H.bodytemperature)

			C.adjustOxyLoss(rand(-40, -20))
			C.adjustToxLoss(rand(-40, -20))
			C.adjustBruteLoss(rand(-40, -20))
			C.adjustFireLoss(rand(-40, -20))

			C.regenerate_icons()

		last_time_used = world.time
	else
		visible_message("<span class='notice'><font color='red'>[bicon(src)] Device blinks faintly.</font></span>")
