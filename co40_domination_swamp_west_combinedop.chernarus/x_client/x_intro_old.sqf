// by Xeno
#define THIS_FILE "x_intro_old.sqf"
#include "x_setup.sqf"
if (!X_Client) exitWith {};

disableSerialization;

GVAR(still_in_intro) = true;
titleText ["", "BLACK IN",3];
1 fadeSound 1;

sleep 4;
#ifdef __CO__
playMusic "Track07_Last_Men_Standing";
#endif
#ifdef __OA__
playMusic "EP1_Track01D";
#endif

#ifndef __TT__
titleText ["D O M I N A T I O N ! 2\n\nOne Team", "PLAIN DOWN", 1];
#else
titleText ["D O M I N A T I O N ! 2\n\nTwo Teams", "PLAIN DOWN", 1];
#endif

sleep 2;
55 cutRsc ["dXlabel","PLAIN"];

GVAR(still_in_intro) = false;

sleep 12;

if (GVAR(reserverd_slot) != "") then {
	if (str(player) == GVAR(reserverd_slot)) then {
		execVM "x_client\x_reserverdslot.sqf";
	};
};

sleep 10;
xr_phd_invulnerable = false;
__pSetVar ["ace_w_allow_dam", nil];
