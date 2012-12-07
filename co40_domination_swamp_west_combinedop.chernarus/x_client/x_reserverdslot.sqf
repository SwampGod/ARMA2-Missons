// by Xeno
#define THIS_FILE "x_reservedslot.sqf"
#include "x_setup.sqf"

sleep 1;

if (serverCommandAvailable "#shutdown") exitWith {};

for "_i" from 1 to 3 do {
	hint "Attention!\nThis is a reserved admin slot.\nIf you are an admin on this server log in in the next 20 seconds otherwise you'll get kicked automatically!";
	sleep 5;
};

if (serverCommandAvailable "#shutdown") exitWith {
	hint format ["Welcome %1!\nYou logged in, no kick", GVAR(name_pl)];
};

hint "Attention!\nYou have 5 seconds to log in or you get kicked automatically!";

sleep 5;

if (serverCommandAvailable "#shutdown") exitWith {
	hint format ["Welcome %1!\nYou logged in, no kick", GVAR(name_pl)];
};

hint "You will be kicked now... !!!";
sleep 1;
[QGVAR(p_f_b_k), [player, GVAR(name_pl),2]] call FUNC(NetCallEvent);