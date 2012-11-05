#include "x_setup.sqf"
private ["_display","_mr1text","_mr2text","_mr1_available","_mr2_available"];

if (x_loop_end) exitWith {};

disableSerialization;

_display = __uiGetVar(X_TELE_DIALOG);

_mr1text = _display displayCtrl 100105;
_mr2text = _display displayCtrl 100106;

_mr1_available = true;
_mr2_available = true;

_mr1text ctrlSetText "";
_mr2text ctrlSetText "";

#ifdef __TT__
if (playerSide == west) then {
#endif
switch (true) do {
	case (__XJIPGetVar(mr1_in_air)): {
		_mr1text ctrlSetText "Mobile respawn one gets transported by airlift...";
		_mr1_available = false;
	};
	case (speed MRR1 > 4): {
		_mr1text ctrlSetText "Mobile respawn one currently driving...";
		_mr1_available = false;
	};
	case (surfaceIsWater [(position MRR1) select 0,(position MRR1) select 1]): {
		_mr1text ctrlSetText "Mobile respawn one is currently in water...";
		_mr1_available = false;
	};
	case (!(if (!isNil {MRR1 getVariable "ace_canmove"}) then {MRR1 call ace_v_alive} else {alive MRR1})): {
		_mr1text ctrlSetText "Mobile respawn one destroyed...";
		_mr1_available = false;
	};
	default {
		_depl = [MRR1, "D_MHQ_Deployed", false] call XfGetVar;
		if (!_depl) then {
			_mr1text ctrlSetText "Mobile respawn one not deployed...";
			_mr1_available = false;
		};
	};
};
switch (true) do {
	case (__XJIPGetVar(mr2_in_air)): {
		_mr2text ctrlSetText "Mobile respawn two gets transported by airlift...";
		_mr2_available = false;
	};
	case (speed MRR2 > 4): {
		_mr2text ctrlSetText "Mobile respawn two currently driving...";
		_mr2_available = false;
	};
	case (surfaceIsWater [(position MRR2) select 0,(position MRR2) select 1]): {
		_mr2text ctrlSetText "Mobile respawn two is currently in water...";
		_mr2_available = false;
	};
	case (!(if (!isNil {MRR2 getVariable "ace_canmove"}) then {MRR2 call ace_v_alive} else {alive MRR2})): {
		_mr2text ctrlSetText "Mobile respawn two destroyed...";
		_mr2_available = false;
	};
	default {
		_depl = [MRR2, "D_MHQ_Deployed", false] call XfGetVar;
		if (!_depl) then {
			_mr2text ctrlSetText "Mobile respawn two not deployed...";
			_mr2_available = false;
		};
	};
};
#ifdef __TT__
} else {
	switch (true) do {
		case (__XJIPGetVar(mrr1_in_air)): {
			_mr1text ctrlSetText "Mobile respawn one gets transported by airlift...";
			_mr1_available = false;
		};
		case (speed MRRR1 > 4): {
			_mr1text ctrlSetText "Mobile respawn one currently driving...";
			_mr1_available = false;
		};
		case (surfaceIsWater [(position MRRR1) select 0,(position MRRR1) select 1]): {
			_mr1text ctrlSetText "Mobile respawn one is currently in water...";
			_mr1_available = false;
		};
		case (!alive MRRR1): {
			_mr1text ctrlSetText "Mobile respawn one destroyed...";
			_mr1_available = false;
		};
		default {
			_depl = MRRR1 getVariable "D_MHQ_Deployed";
			if (isNil "_depl") then {_depl = false};
			if (!_depl) then {
				_mr1text ctrlSetText "Mobile respawn one not deployed...";
				_mr1_available = false;
			};
		};
	};
	switch (true) do {
		case (__XJIPGetVar(mrr2_in_air)): {
			_mr2text ctrlSetText "Mobile respawn two gets transported by airlift...";
			_mr2_available = false;
		};
		case (speed MRRR2 > 4): {
			_mr2text ctrlSetText "Mobile respawn two currently driving...";
			_mr2_available = false;
		};
		case (surfaceIsWater [(position MRRR2) select 0,(position MRRR2) select 1]): {
			_mr2text ctrlSetText "Mobile respawn two is currently in water...";
			_mr2_available = false;
		};
		case (!alive MRRR2): {
			_mr2text ctrlSetText "Mobile respawn two destroyed...";
			_mr2_available = false;
		};
		default {
			_depl = MRRR2 getVariable "D_MHQ_Deployed";
			if (isNil "_depl") then {_depl = false};
			if (!_depl) then {
				_mr2text ctrlSetText "Mobile respawn two not deployed...";
				_mr2_available = false;
			};
		};
	};
};
#endif

if (x_loop_end) exitWith {};

if (!_mr1_available) then {
	_button = _display displayCtrl 100108;
	_button ctrlEnable false;
	if (d_beam_target == 1) then {
		d_beam_target = -1;
		_textctrl = _display displayCtrl 100110;
		_textctrl ctrlSetText "";
	};
} else {
	_button = _display displayCtrl 100108;
	_button ctrlEnable true;
};

if (!_mr2_available) then {
	_button = _display displayCtrl 100109;
	_button ctrlEnable false;
	if (d_beam_target == 2) then {
		d_beam_target = -1;
		_textctrl = _display displayCtrl 100110;
		_textctrl ctrlSetText "";
	};
} else {
	_button = _display displayCtrl 100109;
	_button ctrlEnable true;
};
