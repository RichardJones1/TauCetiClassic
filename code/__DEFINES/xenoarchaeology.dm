// Probability of getting a specific find:
#define FIND_PROBABILITY_ZERO 0 // For items that should not appear
#define FIND_PROBABILITY_MYTHICAL 25
#define FIND_PROBABILITY_RARE 50
#define FIND_PROBABILITY_UNCOMMON 75
#define FIND_PROBABILITY_COMMON 100 // Normal chance
#define FIND_PROBABILITY_EXTREME 150
#define FIND_PROBABILITY_DEBUG 10000

#define FIND_VIEW_RANGE 20 // how close excavation has to come to show a xenoarch overlay on the mine turf

// Origin (who created this relic). In order from the most recent to the oldest and powerful
#define ORIGIN_HUMAN "human"        // Mostly less powerful stuff, more of fluff things. Humans huh.
#define ORIGIN_WIZARD "wizard"      // Complicated machines, made to look archaic as to give the impression that it is magical. However, this magic has been mostly debunked by Nanotrasen researchers. Not overpowered effects, but can be very random.
#define ORIGIN_MARTIAN "martian"    // Flesh-based machines, originated initally from Mars. Powerful effects, focused on organics.
#define ORIGIN_ELDRITCH "eldritch"  // An unknown race, possibly not even from this dimension. Inspired by Lovecraftian horrors. Even more powerful, but there is always a cost. Experiment with your peril.
#define ORIGIN_PRECURSOR "precursor"// The oldest artifacts, made by a race that might have created all of life itself. Not much is known about them. Insanely powerful stuff, but also insanely rare..

///artifact energy release method
#define ARTIFACT_EFFECT_TOUCH 0
#define ARTIFACT_EFFECT_AURA 1
#define ARTIFACT_EFFECT_PULSE 2

///list of possible release methods to get
#define ARTIFACT_ALL_RELEASE_METHODS list(\
    ARTIFACT_EFFECT_TOUCH,\
    ARTIFACT_EFFECT_AURA,\
    ARTIFACT_EFFECT_PULSE)

///artifact trigger types
#define TRIGGER_TOUCH 0
#define TRIGGER_WATER 1
#define TRIGGER_ACID 2
#define TRIGGER_VOLATILE 3
#define TRIGGER_TOXIN 4
#define TRIGGER_FORCE 5
#define TRIGGER_ENERGY 6
#define TRIGGER_HEAT 7
#define TRIGGER_COLD 8
#define TRIGGER_PHORON 9
#define TRIGGER_OXY 10
#define TRIGGER_CO2 11
#define TRIGGER_NITRO 12
#define TRIGGER_PROXY 13

///list of possible artifact triggers
#define ARTIFACT_POSSIBLE_TRIGGERS list(\
    TRIGGER_TOUCH,\
    TRIGGER_WATER,\
    TRIGGER_ACID,\
    TRIGGER_VOLATILE,\
    TRIGGER_TOXIN,\
    TRIGGER_FORCE,\
    TRIGGER_ENERGY,\
    TRIGGER_HEAT,\
    TRIGGER_COLD,\
    TRIGGER_PHORON,\
    TRIGGER_OXY,\
    TRIGGER_CO2,\
    TRIGGER_NITRO)

///artifact icon_num defines
#define ARTIFACT_WIZARD_LARGE 1
#define ARTIFACT_WIZARD_SMALL 2
#define ARTIFACT_MARTIAN_LARGE 3
#define ARTIFACT_MARTIAN_SMALL 4
#define ARTIFACT_MARTIAN_PINK 5
#define ARTIFACT_CUBE 6
#define ARTIFACT_PILLAR 7
#define ARTIFACT_COMPUTER 8
#define ARTIFACT_VENTS 9
#define ARTIFACT_FLOATING 10
#define ARTIFACT_CRYSTAL_GREEN 11
#define ARTIFACT_CRYSTAL_PURPLE 12
#define ARTIFACT_CRYSTAL_BLUE 13

///artifact type_name

///unknown/none
#define ARTIFACT_EFFECT_UNKNOWN 0
///concentrated energy
#define ARTIFACT_EFFECT_ENERGY 1
///untermittent psionic wavefront
#define ARTIFACT_EFFECT_PSIONIC 2
///electromagnetic energy
#define ARTIFACT_EFFECT_ELECTRO 3
///particle field
#define ARTIFACT_EFFECT_PARTICLE 4
///organically reactive exotic particles
#define ARTIFACT_EFFECT_ORGANIC 5
///bluespace
#define ARTIFACT_EFFECT_BLUESPACE 6
///atomic synthesis
#define ARTIFACT_EFFECT_SYNTH 7
