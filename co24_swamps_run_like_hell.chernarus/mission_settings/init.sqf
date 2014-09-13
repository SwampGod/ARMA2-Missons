/*
 * Author:      Sinky
 * Date:        3rd February 2011
 * Last Edited: 3rd February 2011
 * Version:     1.0
 */
 
// Add the action for the settings dialog
player addAction [
	("<t color='#FFFFFF'>" + "Settings" + "</t>"), 
	"mission_settings\create.sqf", [], 0, false
];

// Used to re-add the settings action after respawn
player addMPEventHandler ["MPRespawn", {_this execVM "mission_settings\onPlayerRespawn.sqf"}];