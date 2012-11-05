// Norrn_LeaderFix
// © AUGUST 2009 - norrin
_group_leader = _this select 0;
_my_group = _this select 1;

_leader = missionNamespace getVariable _group_leader;
_group = group _leader; 
{_ur = missionNamespace getVariable _x;if (group _ur != _group  && !(_ur getVariable "Norrn_dead")) then {[_ur] joinsilent _group; _ur doMove (getPos _ur)}} forEach _my_group;
sleep 2;
{_ur = missionNamespace getVariable _x;if (group _ur != _group  && !(_ur getVariable "Norrn_dead")) then {[_ur] joinsilent _group; _ur doMove (getPos _ur)}} forEach _my_group;

if (_leader != formleader _name) then {
	{_x doFollow _leader} forEach units _group;
	{_x doMove getPos _x} forEach units _group;
};