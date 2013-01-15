/**
 * LANGUAGE
 * Language selection ("en" for english, "fr" for french, or other if you create your own "XX_strings_lang.sqf" file)
 */
R3F_REV_CFG_langage = "en";

/**
 * NUMBER OF REVIVES
 * Maximal number of revives for a player
 */
R3F_REV_CFG_nb_reanimations = 20;

/**
 * ALLOW TO RESPAWN AT CAMP
 * True to permits the player to respawn at the "respawn_xxx" marker
 * when he has no more revive credits or if there is no medic to revive
 */
R3F_REV_CFG_autoriser_reapparaitre_camp = true;

/**
 * ALLOW CAMERA
 * True to allow the players who are out of the game (no more revive credits and respawn at camp forbidden) to view the game in camera mode
 */
R3F_REV_CFG_autoriser_camera = true;

/**
 * SHOW MARKER
 * True to show a marker on map on the position of players who are waiting for being revived
 */
R3F_REV_CFG_afficher_marqueur = true;

/**
 * STILL INJURED AFTER REVIVE
 * True to keep the revived player slightly injured. So it need to be healed by a ("real") medic or a MASH (more "realistic")
 */
R3F_REV_CFG_revived_players_are_still_injured = false;

/**
 * ALLOW TO DRAG BODY
 * True to allow any player to drag unconscious bodies
 * The value can be changed with an external script at any time with an instant effect
 * 
 */
R3F_REV_CFG_player_can_drag_body = true;

/**
 * ALLOW TO REVIVE (system with three variables)
 * There are different ways to define who can revive unconscious bodies.
 * 
 * The variable R3F_REV_CFG_list_of_classnames_who_can_revive contains the list of classnames (i.e. the types of soldiers) who can revive.
 * To allow every soldiers to revive, you can write : R3F_REV_CFG_list_of_classnames_who_can_revive = ["CAManBase"];
 * To allow USMC officers and medics, you can write : R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer", "USMC_Soldier_Medic"];
 * To not use the classnames to specify who can revive, you can write an empty list : R3F_REV_CFG_list_of_classnames_who_can_revive = [];
 * To know the different classnames of soldiers, you can visit this page : http://www.armatechsquad.com/ArmA2Class/
 * 
 * The variable R3F_REV_CFG_list_of_slots_who_can_revive contains the list of named slots (or units) who can revive.
 * For example, consider that you have two playable units named "medic1" and "medic2" in your mission editor.
 * To allow these two medics to revive, you can write : R3F_REV_CFG_list_of_slots_who_can_revive = [medic1, medic2];
 * To not use the slots list to specify who can revive, you can write an empty list : R3F_REV_CFG_list_of_slots_who_can_revive = [];
 * 
 * The variable R3F_REV_CFG_all_medics_can_revive is a boolean to allow all medics to revive.
 * 
 * These three variables can be used together. The players who can revive are the union of the allowed players for each variable.
 * For example, if you set :
 *   R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer"];
 *   R3F_REV_CFG_list_of_slots_who_can_revive = [special_slot1, special_slot2];
 *   R3F_REV_CFG_all_medics_can_revive = true;
 * then all the medics, all the "USMC_Soldier_Officer" and the players at special_slot1, special_slot1 can revive.
 * If a player "appears" in two categories (e.g. he is an "USMC_Soldier_Officer" at the slot named "special_slot2"),
 * it is not a matter. He will be allowed to revive without problem.
 * 
 * The value of the three variables can be changed with an external script at any time with an instant effect.
 * 

 */
R3F_REV_CFG_list_of_classnames_who_can_revive = [
		"cacharacters_pmc",
		"CACharacters_BAF",
		"cacharacters2"
];
R3F_REV_CFG_list_of_slots_who_can_revive = [];
R3F_REV_CFG_all_medics_can_revive = true;
