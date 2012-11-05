#define __isEast if (d_own_side == "EAST") then {
#define __isWest if (d_own_side == "WEST") then {
#define __getMNsVar(mvarname) (missionNamespace getVariable #mvarname)
#define __mNsSetVar missionNamespace setVariable
#define __pGetVar(pvarname) (player getVariable #pvarname)
#define __pSetVar player setVariable
#define __XJIPGetVar(jvarname) (X_JIPH getVariable #jvarname)
#define __XJIPSetVar X_JIPH setVariable
#define __uiGetVar(uvarname) (uiNamespace getVariable #uvarname)
#define __ReviveVer "REVIVE" in d_version
#define __AIVer "AI" in d_version
#define __AIVer "AI" in d_version
#define __ACEVer "ACE" in d_version
#define __TTVer "TT" in d_version
#define __OAVer "OA" in d_version
#define __MANDOVer "MANDO" in d_version
#define __RankedVer "RANKED" in d_version
#define __WoundsVer "WOUNDS" in d_version
#define __AddToExtraVec(ddvec) extra_mission_vehicle_remover_array set [count extra_mission_vehicle_remover_array, ddvec];
#define __GetEGrp(grpnamexx) grpnamexx = [d_side_enemy] call x_creategroup;
#define __TargetInfo _target_array2 = d_target_names select (X_JIPH getVariable "current_target_index");_current_target_name = _target_array2 select 1;
#define __addRemoveVehi(xvecx) xvecx execFSM "fsms\removevehi.fsm";
#define __addDead(xunitx) d_allunits_add set [count d_allunits_add, xunitx];
#define __Poss _poss = x_sm_pos select 0;
#define __PossAndOther _poss = x_sm_pos select 0;_pos_other = x_sm_pos select 1;
#define __ccppfln(xfile1) call compile preprocessFileLineNumbers #xfile1
#define __cppfln(xdfunc,xfile2) xdfunc = compile preprocessFileLineNumbers #xfile2
#define __addkpw(wpoints) d_kill_points_west = d_kill_points_west + wpoints
#define __addkpe(epoints) d_kill_points_east = d_kill_points_east + epoints
#define __notlocalexit(xtheunit) if (!local xtheunit) exitWith {}
#define __INC(vari) vari = vari + 1
#define __DEC(vard) vard = vard - 1
#define __MPCheck if (X_MP) then {waitUntil {sleep (1.012 + random 1);(call XPlayersNumber) > 0}}
// uncomment/comment for debug messages
//#define __DEBUG_NET(dscript,dmsg) if (isServer) then {diag_log format ['NET: %1: dmsg = %2', dscript,dmsg]} else {server globalChat format ['NET: %1: dmsg = %2', dscript,dmsg];diag_log format ['NET: %1: dmsg = %2', dscript,dmsg]};
#define __DEBUG_NET(dscript,dmsg)
//#define __DEBUG_SERVER(dscript,dmsg) if (isServer) then {diag_log format ['%1: dmsg = %2', dscript,dmsg]};
#define __DEBUG_SERVER(dscript,dmsg)
//#define __DEBUG_CLIENT(dscript,dmsg) if (X_Client) then {_dm = format ['%1: dmsg = %2', dscript,dmsg];player sideChat _dm;diag_log _dm};
#define __DEBUG_CLIENT(dscript,dmsg)