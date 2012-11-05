// by Xeno
#include "x_setup.sqf"
if (!X_Client) exitWith {};

disableSerialization;

d_still_in_intro = true;

sleep 4;
#ifndef __OA__
playMusic "Track07_Last_Men_Standing";
#else
playMusic "EP1_Track01D";
#endif

#ifndef __TT__
titleText ["D O M I N A T I O N ! 2\n\nOne Team", "PLAIN DOWN", 1];
#else
titleText ["D O M I N A T I O N ! 2\n\nTwo Teams", "PLAIN DOWN", 1];
#endif

sleep 14;
titleRsc ["Titel1", "PLAIN"];

d_still_in_intro = false;

if (d_reserverd_slot != "") then {
	if (str(player) == d_reserverd_slot) then {
		execVM "x_client\x_reserverdslot.sqf";
	};
};

sleep 10;
#ifndef __ACE__
if (!isNil {__pGetVar(d_p_ev_hd)}) then {d_phd_invulnerable = false};
#else
player setVariable ["ace_w_allow_dam", nil];
#endif