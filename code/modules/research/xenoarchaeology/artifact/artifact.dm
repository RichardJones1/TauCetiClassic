
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Large finds - (Potentially) active alien machinery from the dawn of time
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TO DO LIST:
// * Consider about adding constructshell back
// * Do something about hoverpod, its quite useless now. Maybe get a chance to find a space pod
// * Consider adding more big artifacts
// * Add more effects from /vg/
//

/datum/artifact_find
	var/artifact_id
	var/artifact_find_type
	var/artifact_detect_range

/datum/artifact_find/New()
	artifact_detect_range = rand(5,300)

	artifact_id = "[pick("kappa","sigma","antaeres","beta","omicron","iota","epsilon","omega","gamma","delta","tau","alpha")]-[rand(100,999)]"

	artifact_find_type = pick(\
	5;/obj/machinery/power/supermatter,\
//	5;/obj/structure/constructshell,\  //
	5;/obj/machinery/syndicate_beacon,\
	25;/obj/machinery/power/supermatter/shard,\
	50;/obj/random/mecha/wreckage,\
	100;/obj/machinery/auto_cloner,\
	100;/obj/machinery/giga_drill,\
	100;/obj/mecha/working/hoverpod,\
	100;/obj/machinery/replicator,\
	150;/obj/machinery/power/crystal,\
	1000;/obj/machinery/artifact)

