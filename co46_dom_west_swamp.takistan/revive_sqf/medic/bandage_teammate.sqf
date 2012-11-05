/*
  BANDAGE TEAMATE SCRIPT

  © JUNE 2009 - norrin
*/
_array = _this select 3;
_name = _array select 0;
_wounded = _array select 1;

_name removeAction NORRN_bandageBuddyAction;

["playhealed", _wounded] call RNetCallEvent;
_name playMove "AinvPknlMstpSlayWrflDnon_medic";

_var = _name getVariable "Norrn_bandages";
_name setVariable ["Norrn_bandages", (_var - 1), true]; 
_med_supplies = format ["Medpacks Remaining: %1\nBandages  Remaining: %2", (_name getVariable "Norrn_medpacks"), (_name getVariable "Norrn_bandages")];
hint _med_supplies;

_wounded setVariable ["NORRN_bleedDamage", (getDammage _wounded), true];
_wounded setVariable ["NORRN_Bleed", false, true];
_wounded setVariable ["NORRN_stopBleed", true, true];