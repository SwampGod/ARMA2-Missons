/*
  BANDAGE WOUND SCRIPT

  � JUNE 2009 - norrin
*/
_name = _this select 3;

_name removeAction NORRN_bandageAction;

_name playMove "AinvPknlMstpSlayWrflDnon_healed";
_var = _name getVariable "Norrn_bandages";
_name setVariable ["Norrn_bandages", (_var - 1), true]; 
_med_supplies = format ["Medpacks Remaining: %1\nBandages  Remaining: %2", (_name getVariable "Norrn_medpacks"), (_name getVariable "Norrn_bandages")];
if (_name == player) then {hint _med_supplies};

_name setVariable ["NORRN_bleedDamage", (getDammage _name), false];
_name setVariable ["NORRN_Bleed", false, true];
_name setVariable ["NORRN_stopBleed", true, true];