// by Xeno
#define THIS_FILE "x_savelayout.sqf"
#include "x_setup.sqf"

if (primaryWeapon player == "" || primaryWeapon player == " ") exitWith {"You need a primary weapon to save the layout !!!" call FUNC(GlobalChat)};

_d_custom_layout = [weapons player,magazines player];

GVAR(custom_layout) = _d_custom_layout;

__pSetVar [QGVAR(custom_backpack), if (count __pGetVar(GVAR(player_backpack)) > 0) then {
	[__pGetVar(GVAR(player_backpack)) select 0, __pGetVar(GVAR(player_backpack)) select 1]
} else {
	[]
}];

#ifdef __ACE__
GVAR(custom_ruckbkw) = __pGetVar(ACE_weapononback);
GVAR(custom_ruckmag) = __pGetVar(ACE_RuckMagContents);
GVAR(custom_ruckwep) = __pGetVar(ACE_RuckWepContents);
#endif

"Weapons and magazines layout saved. You will respawn with this layout, means all magazines that you currently have." call FUNC(GlobalChat);