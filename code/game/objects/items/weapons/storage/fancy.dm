/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 * WARNING: var/icon_type is used for both examine text and sprite name. Please look at the procs below and adjust your sprite names accordingly
 *		TODO: Cigarette boxes should be ported to this standard
 *
 * Contains:
 *		Donut Box
 *		Egg Box
 *		Candle Box
 *		Crayon Box
 *		Glowsticks Box
 *		Cigarette Box
 */

/obj/item/weapon/storage/fancy/
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox6"
	name = "donut box"
	var/icon_type = "donut"

/obj/item/weapon/storage/fancy/update_icon(itemremoved = 0)
	var/total_contents = src.contents.len - itemremoved
	src.icon_state = "[src.icon_type]box[total_contents]"
	return

/obj/item/weapon/storage/fancy/examine(mob/user)
	..()
	if(src in view(1, user))
		if(contents.len <= 0)
			to_chat(user, "There are no [src.icon_type]s left in the box.")
		else if(contents.len == 1)
			to_chat(user, "There is one [src.icon_type] left in the box.")
		else
			to_chat(user, "There are [src.contents.len] [src.icon_type]s in the box.")


/*
 * Donut Box
 */

/obj/item/weapon/storage/fancy/donut_box
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox6"
	icon_type = "donut"
	name = "donut box"
	storage_slots = 6
	can_hold = list("/obj/item/weapon/reagent_containers/food/snacks/donut")


/obj/item/weapon/storage/fancy/donut_box/New()
	..()
	for(var/i=1; i <= storage_slots; i++)
		new /obj/item/weapon/reagent_containers/food/snacks/donut/normal(src)
	return

/*
 * Egg Box
 */

/obj/item/weapon/storage/fancy/egg_box
	icon = 'icons/obj/food.dmi'
	icon_state = "eggbox"
	icon_type = "egg"
	name = "egg box"
	storage_slots = 12
	max_combined_w_class = 24
	can_hold = list("/obj/item/weapon/reagent_containers/food/snacks/egg")

/obj/item/weapon/storage/fancy/egg_box/New()
	..()
	for(var/i=1; i <= storage_slots; i++)
		new /obj/item/weapon/reagent_containers/food/snacks/egg(src)
	return

/*
 * Candle Box
 */

/obj/item/weapon/storage/fancy/candle_box
	name = "candle pack"
	desc = "A pack of red candles."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candlebox5"
	icon_type = "candle"
	item_state = "candlebox5"
	storage_slots = 5
	throwforce = 2
	slot_flags = SLOT_BELT


/obj/item/weapon/storage/fancy/candle_box/New()
	..()
	for(var/i=1; i <= storage_slots; i++)
		new /obj/item/candle(src)
	return

/*
 * Crayon Box
 */

/obj/item/weapon/storage/fancy/crayons
	name = "box of crayons"
	desc = "A box of crayons for all your rune drawing needs."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonbox"
	w_class = 2.0
	storage_slots = 6
	icon_type = "crayon"
	can_hold = list(
		"/obj/item/toy/crayon"
	)

/obj/item/weapon/storage/fancy/crayons/New()
	..()
	new /obj/item/toy/crayon/red(src)
	new /obj/item/toy/crayon/orange(src)
	new /obj/item/toy/crayon/yellow(src)
	new /obj/item/toy/crayon/green(src)
	new /obj/item/toy/crayon/blue(src)
	new /obj/item/toy/crayon/purple(src)
	update_icon()

/obj/item/weapon/storage/fancy/crayons/update_icon()
	overlays = list() //resets list
	overlays += image('icons/obj/crayons.dmi',"crayonbox")
	for(var/obj/item/toy/crayon/crayon in contents)
		overlays += image('icons/obj/crayons.dmi',crayon.colourName)

/obj/item/weapon/storage/fancy/crayons/attackby(obj/item/W, mob/user)
	if(istype(W,/obj/item/toy/crayon))
		switch(W:colourName)
			if("mime")
				to_chat(usr, "This crayon is too sad to be contained in this box.")
				return
			if("rainbow")
				to_chat(usr, "This crayon is too powerful to be contained in this box.")
				return
	..()

/*
 * Glowsticks Box
 */

/obj/item/weapon/storage/fancy/glowsticks
	name = "box of glowsticks"
	desc = "A box of glowsticks (Do not eat)."
	icon = 'icons/obj/glowsticks.dmi'
	icon_state = "sticksbox"
	w_class = 2.0
	storage_slots = 5
	icon_type = "glowstick"
	can_hold = list(
		"/obj/item/weapon/reagent_containers/food/snacks/glowstick"
	)

/obj/item/weapon/storage/fancy/glowsticks/New()
	..()
	new /obj/item/weapon/reagent_containers/food/snacks/glowstick/green(src)
	new /obj/item/weapon/reagent_containers/food/snacks/glowstick/red(src)
	new /obj/item/weapon/reagent_containers/food/snacks/glowstick/blue(src)
	new /obj/item/weapon/reagent_containers/food/snacks/glowstick/yellow(src)
	new /obj/item/weapon/reagent_containers/food/snacks/glowstick/orange(src)
	update_icon()

/obj/item/weapon/storage/fancy/glowsticks/update_icon()
	overlays = list() //resets list
	overlays += image('icons/obj/glowsticks.dmi',"sticksbox")
	for(var/obj/item/weapon/reagent_containers/food/snacks/glowstick/glowstick in contents)
		overlays += image('icons/obj/glowsticks.dmi',glowstick.colourName)

////////////
//CIG PACK//
////////////
/obj/item/weapon/storage/fancy/cigarettes
	name = "cigarette packet"
	desc = "The most popular brand of Space Cigarettes, sponsors of the Space Olympics."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigpacket"
	item_state = "cigpacket"
	w_class = 1
	throwforce = 2
	slot_flags = SLOT_BELT
	storage_slots = 6
	can_hold = list("/obj/item/clothing/mask/cigarette","/obj/item/weapon/lighter")
	icon_type = "cigarette"

/obj/item/weapon/storage/fancy/cigarettes/New()
	..()
	flags |= NOREACT
	for(var/i = 1 to storage_slots)
		new /obj/item/clothing/mask/cigarette(src)
	create_reagents(15 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one

/obj/item/weapon/storage/fancy/cigarettes/update_icon()
	icon_state = "[initial(icon_state)][contents.len]"
	return

/obj/item/weapon/storage/fancy/cigarettes/remove_from_storage(obj/item/W, atom/new_location)
	if(istype(W, /obj/item/clothing/mask/cigarette))
		if(reagents)
			reagents.trans_to(W, (reagents.total_volume/contents.len))
	..()

/obj/item/weapon/storage/fancy/cigarettes/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_sel.selecting == "mouth" && contents.len > 0 && !user.wear_mask)
		var/has_cigarette = 0
		for(var/obj/item/I in contents)
			if(istype(I, /obj/item/clothing/mask/cigarette))
				var/obj/item/clothing/mask/cigarette/C = I
				has_cigarette = 1
				contents.Remove(C)
				user.equip_to_slot_if_possible(C, slot_wear_mask)
				to_chat(user, "<span class='notice'>You take a cigarette out of the pack.</span>")
				update_icon()
				break
		if(!has_cigarette)
			to_chat(user, "<span class='notice'>You tried to get any cigarette, but they ran out.</span>")
	else
		..()

/obj/item/weapon/storage/fancy/cigarettes/dromedaryco
	name = "\improper DromedaryCo packet"
	desc = "A packet of six imported DromedaryCo cancer sticks. A label on the packaging reads, \"Wouldn't a slow death make a change?\""
	icon_state = "Dpacket"
	item_state = "Dpacket"

/obj/item/weapon/storage/fancy/cigarettes/cigpack_syndicate
	name = "unknown"
	desc = "An obscure brand of cigarettes."
	icon_state = "syndie"

/obj/item/weapon/storage/fancy/cigarettes/cigpack_syndicate/New()
	..()
	for(var/i = 1 to storage_slots)
		reagents.add_reagent("tricordrazine",15)
	name = "cigarette packet"

/*
 * Vial Box
 */

/obj/item/weapon/storage/fancy/vials
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox6"
	icon_type = "vial"
	name = "vial storage box"
	storage_slots = 6
	can_hold = list("/obj/item/weapon/reagent_containers/glass/beaker/vial")


/obj/item/weapon/storage/fancy/vials/New()
	..()
	for(var/i=1; i <= storage_slots; i++)
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(src)
	return

/obj/item/weapon/storage/lockbox/vials
	name = "secure vial storage box"
	desc = "A locked box for keeping things away from children."
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox0"
	item_state = "syringe_kit"
	max_w_class = 3
	can_hold = list("/obj/item/weapon/reagent_containers/glass/beaker/vial")
	max_combined_w_class = 14 //The sum of the w_classes of all the items in this storage item.
	storage_slots = 6
	req_access = list(access_virology)

/obj/item/weapon/storage/lockbox/vials/New()
	..()
	update_icon()

/obj/item/weapon/storage/lockbox/vials/update_icon(itemremoved = 0)
	var/total_contents = src.contents.len - itemremoved
	src.icon_state = "vialbox[total_contents]"
	src.overlays.Cut()
	if (!broken)
		overlays += image(icon, src, "led[locked]")
		if(locked)
			overlays += image(icon, src, "cover")
	else
		overlays += image(icon, src, "ledb")
	return

/obj/item/weapon/storage/lockbox/vials/attackby(obj/item/weapon/W, mob/user)
	..()
	update_icon()
