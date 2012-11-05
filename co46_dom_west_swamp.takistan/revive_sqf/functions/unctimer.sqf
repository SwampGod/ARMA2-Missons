// uncTimer.sqf
// © NOVEMBER 2009 - norrin 
_revive_time_limit 	= NORRN_revive_array select 27;
_revive_time 		= time + _revive_time_limit;
_timer 				= time + 1;
_timer_count 		= _revive_time_limit;

while {(player getVariable "NORRN_AIunconscious") && !(player getVariable "Norrn_respawn_at_base")} do {
	if (time > _timer) then {
		_timer = time + 1;
		_timer_count = _timer_count - 1;
		if (!mission_Over && !all_dead_check) then {titleText [format ["\n\n\n\n\n\n\n\n\n\nRevive Time Remaining: %1", _timer_count], "PLAIN", 1]};
	};
	sleep 0.05;
};