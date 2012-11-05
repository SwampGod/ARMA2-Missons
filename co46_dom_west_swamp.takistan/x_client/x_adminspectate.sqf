// by Xeno
#include "x_setup.sqf"

d_phd_invulnerable = true;
if (__TTVer) then {
	if (d_side_player == east) then {
		KEGs_ShownSides = [east, west];
	} else {
		KEGs_ShownSides = [west, east];
	};
} else {
	KEGs_ShownSides = [d_side_player];
};
KEGs_can_exit_spectator = true;
KEGs_playable_only = true;
KEGs_no_butterfly_mode = true;

[player, objNull, "x"] execVM "spect\specta.sqf";
