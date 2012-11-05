// by Xeno
#include "x_setup.sqf"
if (!X_Client) exitWith {};

if (isNil "XfTeamStatusD") then {
	__cppfln(XfTeamStatusD,scripts\TeamStatusDialog\TeamStatusDialog.sqf);
};

if (vehicle player == player) then {
	[player, player, 0, ["Page", "Team"],"HideOpposition","HideVehicle","DeleteRemovedAI","AllowPlayerInvites"] spawn XfTeamStatusD;
} else {
	[player, player, 0, ["Page", "Vehicle"],["VehicleObject", vehicle player],"HideTeam","HideGroup","HideOpposition","DeleteRemovedAI","AllowPlayerInvites"] spawn XfTeamStatusD;
};