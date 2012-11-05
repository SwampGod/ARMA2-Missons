// by Xeno
#include "x_setup.sqf"

if (primaryWeapon player == "" || primaryWeapon player == " ") exitWith {"You need a primary weapon to save the layout !!!" call XfGlobalChat};

_d_custom_layout = [weapons player,magazines player];

d_custom_layout = _d_custom_layout;

__pSetVar ["d_custom_backpack", if (count __pGetVar(d_player_backpack) > 0) then {
	[__pGetVar(d_player_backpack) select 0, __pGetVar(d_player_backpack) select 1]
} else {
	[]
}];

#ifdef __ACE__
d_custom_ruckbkw = __pGetVar(ACE_weapononback);
d_custom_ruckmag = __pGetVar(ACE_RuckMagContents);
d_custom_ruckwep = __pGetVar(ACE_RuckWepContents);
#endif

"Weapons and magazines layout saved. You will respawn with this layout, means all magazines that you currently have." call XfGlobalChat;