/obj/effect/portal
	name = "portal"
	desc = "Looks unstable. Best to test it with the clown."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "portal"
	density = 1
	unacidable = 1//Can't destroy energy portals.
	var/failchance = 5
	var/obj/item/target = null
	var/creator = null
	anchored = 1.0

/obj/effect/portal/Bumped(mob/M)
	spawn(0)
		src.teleport(M)
		return
	return

/obj/effect/portal/Crossed(AM as mob|obj)
	spawn(0)
		src.teleport(AM)
		return
	return

/obj/effect/portal/New()
	spawn(300)
		qdel(src)
		return
	return

/obj/effect/portal/proc/teleport(atom/movable/M, density_check = TELE_CHECK_NONE, respect_entrydir = FALSE, use_forceMove = TRUE)
	if (istype(M, /obj/effect)) //sparks don't teleport
		return FALSE
	if (M.anchored && istype(M, /obj/mecha))
		return FALSE
	if (icon_state == "portal1")
		return FALSE
	if (!( target ))
		qdel(src)
		return FALSE
	if (istype(M, /atom/movable))
		if(prob(failchance)) //oh dear a problem, put em in deep space
			src.icon_state = "portal1"
			return do_teleport(M, locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), 3), 0, use_forceMove, adest_checkdensity = density_check, arespect_entrydir = respect_entrydir, aentrydir = get_dir(M, src))
		else
			return do_teleport(M, target, 1, use_forceMove, adest_checkdensity = density_check, arespect_entrydir = respect_entrydir, aentrydir = get_dir(M, src))

//Telescience wormhole
/obj/effect/portal/tsci_wormhole
	name = "wormhole"
	icon = 'icons/obj/objects.dmi'
	icon_state = "anom"
	failchance = 0

	var/obj/effect/portal/tsci_wormhole/linked_portal = null
	var/obj/machinery/computer/telescience/linked_console = null

/obj/effect/portal/tsci_wormhole/New(loc, turf/exit, other_side_portal = FALSE)
	if(!other_side_portal)
		linked_portal = new(exit, get_turf(src), TRUE)
		linked_portal.linked_portal = src
		target = linked_portal
		linked_portal.target = src

/obj/effect/portal/tsci_wormhole/Destroy()
	target = null
	if(linked_console)
		linked_console.active_wormhole = null
		linked_console.use_power = 1
		linked_console = null
	if(linked_portal)
		playsound(src, 'sound/effects/phasein.ogg', 25, 1)
		playsound(linked_portal, 'sound/effects/phasein.ogg', 25, 1)
		var/obj/effect/portal/tsci_wormhole/LP = linked_portal
		linked_portal = null
		LP.linked_portal = null
		qdel(LP)
	return ..()

/obj/effect/portal/tsci_wormhole/Bumped(mob/M)
	set waitfor = 0
	if(teleport(M, TELE_CHECK_ALL, TRUE, FALSE))
		handle_special_effects(M)

/obj/effect/portal/tsci_wormhole/Crossed(AM)
	set waitfor = 0
	if(teleport(AM, TELE_CHECK_ALL, TRUE, FALSE))
		handle_special_effects(AM)

/obj/effect/portal/tsci_wormhole/proc/handle_special_effects(AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/bad_effects = 0
		if(prob(20))
			bad_effects += 1
			H.confused += 3
			var/msg = pick("You feel dizzy.", "Your head starts spinning.")
			to_chat(H, "<span class='warning'>[msg]</span>")
		if(prob(20))
			bad_effects += 1
			H.vomit() //No msg required, since vomit() will handle this.
		if(bad_effects == 2)
			H.Paralyse(3)
