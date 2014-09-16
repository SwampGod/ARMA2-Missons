/**
 * Configuration file - English and french translated
 * Fichier de configuration - Traduit en anglais et en français
 */

/**
 * LANGUAGE
 * Language selection ("en" for english, "fr" for french, or other if you create your own "XX_strings_lang.sqf" file)
 * Sélection de la langue ("en" pour anglais, "fr" pour français, ou autre si vous créez votre propre fichier "XX_strings_lang.sqf")
 */
R3F_REV_CFG_langage = "en";

/**
 * NUMBER OF REVIVES
 * Maximal number of revives for a player
 * Nombre maximal de réanimations par joueur
 */
R3F_REV_CFG_nb_reanimations = 10;

/**
 * ALLOW TO RESPAWN AT CAMP
 * True to permits the player to respawn at the "respawn_xxx" marker
 * when he has no more revive credits or if there is no medic to revive
 * 
 * Vrai pour que le joueur puisse réapparaitre sur le marqueur "respawn_xxx"
 * lorsqu'il a épuisé ses réanimations ou que personne ne peut le réanimer
 */
R3F_REV_CFG_autoriser_reapparaitre_camp = true;

/**
 * ALLOW CAMERA
 * True to allow the players who are out of the game (no more revive credits and respawn at camp forbidden) to view the game in camera mode
 * Vrai pour autoriser un joueur hors jeu (plus de réanimation possible et retour au camp non autorisé) à suivre la partie en mode caméra
 */
R3F_REV_CFG_autoriser_camera = true;

/**
 * SHOW MARKER
 * True to show a marker on map on the position of players who are waiting for being revived
 * Vrai pour afficher un marqueur sur carte sur la position des joueurs en attente de réanimation
 */
R3F_REV_CFG_afficher_marqueur = true;

/**
 * STILL INJURED AFTER REVIVE
 * True to keep the revived player slightly injured. So it need to be healed by a ("real") medic or a MASH (more "realistic")
 * Vrai pour garder le joueur réanimé légèrement blessé, de sorte qu'il doit être soigner par un ("vrai") infirmier ou un MASH (plus "réaliste")
 */
R3F_REV_CFG_revived_players_are_still_injured = false;

/**
 * ALLOW TO DRAG BODY
 * True to allow any player to drag unconscious bodies
 * The value can be changed with an external script at any time with an instant effect
 * 
 * Vrai pour autoriser les joueurs à traîner les corps inconscients
 * Cette variable peut-être modifiée par un script externe à n'importe quelle moment avec effet immédiat
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
 *************************************************************************************
 * Il y a différentes façons de définir qui peut réanimer les corps inconscients.
 * 
 * La variable R3F_REV_CFG_list_of_classnames_who_can_revive contient la listes des noms de classes (càd des types de soldats) qui peuvent réanimer.
 * Pour autoriser tous les soldats, vous pouvez écrire : R3F_REV_CFG_list_of_classnames_who_can_revive = ["CAManBase"];
 * Pour autoriser les officiers et infirmiers USMC, vous pouvez écrire : R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer", "USMC_Soldier_Medic"];
 * Pour ne pas utiliser les noms de classes pour définir qui peut réanimer, vous pouvez écrire : R3F_REV_CFG_list_of_classnames_who_can_revive = [];
 * Pour connaître les différents noms de classes des soldats, vous pouvez visiter cette page : http://www.armatechsquad.com/ArmA2Class/
 * 
 * La variable R3F_REV_CFG_list_of_slots_who_can_revive contient la liste des slots nommés (ou des unités) pouvant réanimer.
 * Par exemple, prenons deux unités jouables nommées "infimier1" et "infimier2" dans l'éditeur de mission.
 * Pour autoriser ces deux médecins à réanimer, vous pouvez écrire : R3F_REV_CFG_list_of_slots_who_can_revive = [infimier1, infimier2];
 * Pour ne pas utiliser la liste de slots pour définir qui peut réanimer, vous pouvez écrire : R3F_REV_CFG_list_of_slots_who_can_revive = [];
 * 
 * La variable R3F_REV_CFG_all_medics_can_revive est un booléen permettant d'autoriser tous les infimiers à réanimer.
 * 
 * Ces trois variables peuvent être utilisées ensemble. Les joueurs pouvant réanimer sont l'union des joueurs autorisés pour chacune des variables.
 * Par exemple, si vous avez :
 *   R3F_REV_CFG_list_of_classnames_who_can_revive = ["USMC_Soldier_Officer"];
 *   R3F_REV_CFG_list_of_slots_who_can_revive = [slot_special1, slot_special2];
 *   R3F_REV_CFG_all_medics_can_revive = true;
 * alors tous les infirmiers, tous les "USMC_Soldier_Officer" et les joueurs occupant les slots slot_special1, slot_special2 pourront réanimer.
 * Si un joueur rentre dans plusieurs catégories (ex : c'est un "USMC_Soldier_Officer" occupant le slot "slot_special2"),
 * ce n'est pas un problème. Il sera correctement autorisé à réanimer.
 * 
 * Ces trois variables peuvent-être modifiées par un script externe à n'importe quelle moment avec effet immédiat.
 */
R3F_REV_CFG_list_of_classnames_who_can_revive = ["CAManBase",
"CACharacters_BAF",
"FR_Miles",
"FR_Cooper",
"FR_Ohara",
"FR_Rodriguez",
"FR_Sykes",
"FR_AC",
"FR_AR",
"FR_Assault_GL",
"FR_Assault_R",
"FR_Commander",
"FR_Corpsman",
"FR_GL",
"FR_Light",
"FR_Marksman",
"FR_R",
"FR_Sapper",
"FR_TL",
"USMC_LHD_Crew_Blue",
"USMC_LHD_Crew_Brown",
"USMC_LHD_Crew_Green",
"USMC_LHD_Crew_Purple",
"USMC_LHD_Crew_Red",
"USMC_LHD_Crew_White",
"USMC_LHD_Crew_Yellow",
"USMC_Soldier",
"USMC_Soldier2",
"USMC_SoldierM_Marksman",
"USMC_SoldierS",
"USMC_SoldierS_Engineer",
"USMC_SoldierS_Sniper",
"USMC_SoldierS_SniperH",
"USMC_SoldierS_Spotter",
"USMC_Soldier_AA",
"USMC_Soldier_AR",
"USMC_Soldier_AT",
"USMC_Soldier_Crew",
"USMC_Soldier_GL",
"USMC_Soldier_HAT",
"USMC_Soldier_LAT",
"USMC_Soldier_Light",
"USMC_Soldier_MG",
"USMC_Soldier_Medic",
"USMC_Soldier_Officer",
"USMC_Soldier_Pilot",
"USMC_Soldier_SL",
"USMC_Soldier_TL",
"CDF_Soldier",
"CDF_Commander",
"CDF_Soldier_AR",
"CDF_Soldier_Crew",
"CDF_Soldier_Engineer",
"CDF_Soldier_GL",
"CDF_Soldier_Light",
"CDF_Soldier_MG",
"CDF_Soldier_Marksman",
"CDF_Soldier_Medic",
"CDF_Soldier_Militia",
"CDF_Soldier_Officer",
"CDF_Soldier_Pilot",
"CDF_Soldier_RPG",
"CDF_Soldier_Sniper",
"CDF_Soldier_Spotter",
"CDF_Soldier_Strela",
"CDF_Soldier_TL",
"Drake",
"Drake_Light",
"Graves",
"Graves_Light",
"Herrera",
"Herrera_Light",
"Pierce",
"Pierce_Light",
"US_Delta_Force_AR_EP1",
"US_Delta_Force_Air_Controller_EP1",
"US_Delta_Force_MG_EP1",
"US_Delta_Force_Assault_EP1",
"US_Delta_Force_EP1",
"US_Delta_Force_M14_EP1",
"US_Delta_Force_Marksman_EP1",
"US_Delta_Force_Medic_EP1",
"US_Delta_Force_Night_EP1",
"US_Delta_Force_SD_EP1",
"US_Delta_Force_TL_EP1",
"US_Delta_Force_Undercover_Takistani06_EP1",
"US_Soldier_AR_EP1",
"US_Soldier_AT_EP1",
"US_Soldier_AA_EP1",
"US_Soldier_HAT_EP1",
"US_Soldier_MG_EP1",
"US_Soldier_AMG_EP1",
"US_Soldier_AAR_EP1",
"US_Soldier_AAT_EP1",
"US_Soldier_AHAT_EP1",
"US_Soldier_EP1",
"US_Soldier_B_EP1",
"US_Soldier_Crew_EP1",
"US_Soldier_Engineer_EP1",
"US_Soldier_GL_EP1",
"US_Soldier_LAT_EP1",
"US_Pilot_Light_EP1",
"US_Soldier_Light_EP1",
"US_Soldier_MG_EP1",
"US_Soldier_Marksman_EP1",
"US_Soldier_Medic_EP1",
"US_Soldier_Officer_EP1",
"US_Soldier_Pilot_EP1",
"US_Soldier_SL_EP1",
"US_Soldier_SniperH_EP1",
"US_Soldier_Sniper_EP1",
"US_Soldier_Sniper_NV_EP1",
"US_Soldier_Spotter_EP1",
"US_Soldier_TL_EP1",
"CZ_Soldier_AT_DES_EP1",
"CZ_Soldier_DES_EP1",
"CZ_Soldier_AMG_DES_EP1",
"CZ_Soldier_B_DES_EP1",
"CZ_Soldier_Light_DES_EP1",
"CZ_Soldier_MG_DES_EP1",
"CZ_Soldier_Office_DES_EP1",
"CZ_Soldier_Pilot_DES_EP1",
"CZ_Soldier_SL_DES_EP1",
"CZ_Soldier_Sniper_DES_EP1",
"CZ_Special_Forces_DES_EP1",
"CZ_Special_Forces_GL_DES_EP1",
"CZ_Special_Forces_MG_DES_EP1",
"CZ_Special_Forces_Scout_DES_EP1",
"CZ_Special_Forces_TL_DES_EP1",
"GER_Soldier_EP1",
"GER_Soldier_MG_EP1",
"GER_Soldier_Medic_EP1",
"GER_Soldier_Scout_EP1",
"GER_Soldier_TL_EP1",
"CIV_Contractor1_BAF",
"CIV_Contractor2_BAF",
"BAF_crewman_DDPM",
"BAF_crewman_W",
"BAF_crewman_MTP",
"BAF_Soldier_FAC_DDPM",
"BAF_Soldier_FAC_W",
"BAF_Soldier_FAC_MTP",
"BAF_Soldier_N_DDPM",
"BAF_Soldier_N_W",
"BAF_Soldier_N_MTP",
"BAF_Soldier_AT_DDPM",
"BAF_Soldier_AT_W",
"BAF_Soldier_AT_MTP",
"BAF_Soldier_HAT_DDPM",
"BAF_Soldier_HAT_W",
"BAF_Soldier_HAT_MTP",
"BAF_Soldier_MG_DDPM",
"BAF_Soldier_MG_W",
"BAF_Soldier_MG_MTP",
"BAF_Soldier_AR_DDPM",
"BAF_Soldier_AR_W",
"BAF_Soldier_AR_MTP",
"BAF_Soldier_AAT_DDPM",
"BAF_Soldier_AAT_W",
"BAF_Soldier_AAT_MTP",
"BAF_Soldier_AHAT_DDPM",
"BAF_Soldier_AHAT_W",
"BAF_Soldier_AHAT_MTP",
"BAF_Soldier_AHAT_DDPM",
"BAF_Soldier_AHAT_W",
"BAF_Soldier_AHAT_MTP",
"BAF_Soldier_AMG_DDPM",
"BAF_Soldier_AMG_W",
"BAF_Soldier_AMG_MTP",
"BAF_Soldier_AAR_DDPM",
"BAF_Soldier_AAR_W",
"BAF_Soldier_AAR_MTP",
"BAF_Soldier_Marksman_DDPM",
"BAF_Soldier_Marksman_W",
"BAF_Soldier_Marksman_MTP",
"BAF_Soldier_Officer_DDPM",
"BAF_Soldier_Officer_W",
"BAF_Soldier_Officer_MTP",
"BAF_Soldier_L_DDPM",
"BAF_Soldier_L_W",
"BAF_Soldier_L_MTP",
"BAF_Soldier_DDPM",
"BAF_Soldier_W",
"BAF_Soldier_MTP",
"BAF_ASoldier_DDPM",
"BAF_ASoldier_DDPM",
"BAF_ASoldier_MTP",
"BAF_Soldier_Medic_DDPM",
"BAF_Soldier_Medic_W",
"BAF_Soldier_Medic_MTP",
"BAF_Soldier_SL_DDPM",
"BAF_Soldier_SL_W",
"BAF_Soldier_SL_MTP",
"BAF_Pilot_DDPM",
"BAF_Pilot_W",
"BAF_Pilot_MTP",
"BAF_Soldier_GL_DDPM",
"BAF_Soldier_GL_W",
"BAF_Soldier_GL_MTP",
"BAF_Soldier_EN_DDPM",
"BAF_Soldier_EN_W",
"BAF_Soldier_EN_MTP",
"BAF_Soldier_AA_DDPM",
"BAF_Soldier_AA_W",
"BAF_Soldier_AA_MTP",
"BAF_Soldier_TL_DDPM",
"BAF_Soldier_TL_W",
"BAF_Soldier_TL_MTP",
"BAF_Soldier_SniperH_MTP",
"BAF_Soldier_SniperH_W",
"BAF_Soldier_SniperN_MTP",
"BAF_Soldier_SniperN_W",
"BAF_Soldier_spotterN_MTP",
"BAF_Soldier_spotterN_W",
"BAF_Soldier_Sniper_MTP",
"BAF_Soldier_Sniper_W",
"UN_CDF_Soldier_AT_EP1",
"UN_CDF_Soldier_MG_EP1",
"UN_CDF_Soldier_EP1",
"UN_CDF_Soldier_AAT_EP1",
"UN_CDF_Soldier_AMG_EP1",
"UN_CDF_Soldier_B_EP1",
"UN_CDF_Soldier_Crew_EP1",
"UN_CDF_Soldier_Guard_EP1",
"UN_CDF_Soldier_Light_EP1",
"UN_CDF_Soldier_Officer_EP1",
"UN_CDF_Soldier_Pilot_EP1",
"UN_CDF_Soldier_SL_EP1",
"Soldier_TL_PMC",
"Soldier_Bodyguard_AA12_PMC",
"Soldier_Bodyguard_M4_PMC",
"Soldier_Sniper_PMC",
"Soldier_Medic_PMC",
"Soldier_MG_PMC",
"Soldier_MG_PKM_PMC",
"Soldier_AT_PMC",
"Soldier_Engineer_PMC",
"Soldier_GL_M16A2_PMC",
"Soldier_M4A3_PMC",
"Soldier_GL_PMC",
"Soldier_PMC",
"Soldier_Crew_PMC",
"Soldier_Pilot_PMC",
"Soldier_Sniper_KSVK_PMC",
"Soldier_AA_PMC",
"Poet_PMC",
"Tanny_PMC",
"Reynolds_PMC",
"Dixon_PMC",
"Ry_PMC"
];
R3F_REV_CFG_list_of_slots_who_can_revive = [];
R3F_REV_CFG_all_medics_can_revive = true;
