// by Xeno
#define THIS_FILE "x_weaponcargor.sqf"
#include "x_setup.sqf"
private "_vec";
PARAMS_1(_vec);

#define __awc(wtype,wcount) _vec addWeaponCargo [#wtype,wcount];
#define __amc(mtype,mcount) _vec addMagazineCargo [#mtype,mcount];

if (isNil "x_ranked_weapons") then {
		_x_ranked_weapons_w = [
			[
				// private rifles
				[
					["M16A2",5],["M16A4",5],["MP5A5",5],["MP5SD",5],["M4A1",5],["SCAR_L_CQC",5],["LeeEnfield",5],
					["FN_FAL",5],["G36C_camo",5],["M14_EP1",5],["Sa58P_EP1",5]
				],
				// corporal rifles (gets added to private rifles)
				[
					["M16A2GL",5],["M16A4_GL",5],["M16A4_ACG",5],["M16A4_ACG_GL",5],["FN_FAL_ANPVS4",5],["G36A_camo",5],
					["M4A3_CCO_EP1",5],["SCAR_L_CQC_CCO_SD",5]
				],
				// sergeant rifles (gets added to corporal and private rifles)
				[
					["M4A1_HWS_GL",5],["M4A1_HWS_GL_camo",5],["M4A1_RCO_GL",5],["M4A1_Aim",5],["M4A1_Aim_camo",5],
					["FN_FAL_ANPVS4",5],["G36K_camo",5],["G36_C_SD_camo",5],["M4A3_RCO_GL_EP1",5],["SCAR_H_CQC_CCO",5]
				],
				// lieutenant rifles (gets added to...)
				[
					["M4A1_HWS_GL_SD_Camo",5],["M4A1_AIM_SD_camo",5],["M8_carbine",5],["M8_carbineGL",5],["M8_compact",1],
					["SCAR_H_CQC_CCO_SD",5],["SCAR_H_STD_EGLM_Spect",5]
				],
				// captain rifles (gets added...)
				[
					["G36a",5],["G36c",5],["G36k",5],["G36_C_SD_eotech",5],["SCAR_L_STD_EGLM_TWS",5],["SCAR_L_STD_EGLM_RCO",5]
				],
				// major rifles (gets...)
				[
					["SCAR_L_STD_Mk4CQT",5]
				],
				// colonel rifles (...)
				[
					["Sa58V_RCO_EP1",5],["AA12_PMC",5]
				]
			],
			[
				// private sniper rifles
				[
					["M24",5],["M24_des_EP1",5]
				],
				// corporal sniper rifles
				[
					["M4SPR",5],["M110_NVG_EP1",5],["SCAR_H_LNG_Sniper",5]
				],
				// sergeant sniper rifles
				[
					["DMR",5],["M110_TWS_EP1",5],["SCAR_H_LNG_Sniper_SD",5]
				],
				// lieutenant sniper rifles
				[
					["M40A3",5],["SCAR_H_STD_TWS_SD",5]
				],
				// captain sniper rifles
				[
					["M8_sharpshooter",5],["SVD_NSPU_EP1",5]
				],
				// major sniper rifles
				[
					["M107",5],["SVD_des_EP1",5]
				],
				// colonel sniper rifles
				[
					["m107_TWS_EP1",5],["PMC_AS50_scoped",5],["PMC_AS50_TWS",5]
				]
			],
			[
				// private MG
				[
					["M249_EP1",5],["M60A4_EP1",5]
				],
				// corporal MG
				[
					["M240",5],["M249_TWS_EP1",5]
				],
				// sergeant MG
				[
					["M249",5],["M249_m145_EP1",5]
				],
				// lieutenant MG
				[
					["M8_SAW",5],["MG36_camo",5]
				],
				// captain MG
				[
					["MG36",5],["Mk_48_DES_EP1",5]
				],
				// major MG
				[
					["Mk_48",5]
				],
				// colonel MG
				[
					["m240_scoped_EP1",5]
				]
			],
			[
				// private launchers
				[
					["M136",5],["M79_EP1",5]
				],
				// corporal launchers
				[
					["STINGER",5],["M32_EP1",5]
				],
				// sergeant launchers
				[
					["M47Launcher_EP1",5]
				],
				// lieutenant launchers
				[
					["SMAW",5],["MAAWS",5]
				],
				// capain launchers
				[
					["Mk13_EP1",5],["BAF_NLAW_Launcher",5]
				],
				// major launchers
				[
				],
				// colonel launchers
				[
					["JAVELIN",2]
				]
			],
			[
				// private pistols
				[
					["M9",5],["M9SD",5],["glock17_EP1",5]
				],
				// corporal pistols
				[
					["UZI_EP1",5],["Sa61_EP1",5]
				],
				// sergeant pistols
				[
					["Colt1911",5],["UZI_SD_EP1",5]
				],
				// lieutenant pistols
				[
					["revolver_EP1",5]
				],
				// captain pistols
				[
					["revolver_gold_EP1",5]
				],
				// major pistols
				[
				],
				// colonel pistols
				[
				]
			]
		];
	_x_ranked_weapons_e = [
		[
			// private rifles
			[
				["AK_74",5],["AKS_74_U",5],["AK_107_kobra",5],["AK_47_M",5],["AKS_74_kobra",5],
				["AK_74_GL",5],["AK_107_GL_kobra",5],["Bizon",5],["bizon_silenced",5],
				["AKS_74_UN_kobra",5],["AK_47_S",5],["Saiga12K",5],["VSS_vintorez",5],
				["AK_107_GL_pso",5],["AK_107_pso",5],["AKS_74_pso",5]
			],
			// corporal rifles (gets added to private rifles)
			[
				
			],
			// sergeant rifles (gets added to corporal and private rifles)
			[
				
			],
			// lieutenant rifles (gets added to...)
			[
				
			],
			// captain rifles (gets added...)
			[
			],
			// major rifles (gets...)
			[
			],
			// colonel rifles (...)
			[
			]
		],
		[
			// private sniper rifles
			[
				["SVD",5],["SVD_CAMO",5],["KSVK",5]
			],
			// corporal sniper rifles
			[
			],
			// sergeant sniper rifles
			[
			],
			// lieutenant sniper rifles
			[
			],
			// captain sniper rifles
			[
				
			],
			// major sniper rifles
			[
			],
			// colonel sniper rifles
			[
				
			]
		],
		[
			// private MG
			[
				["RPK_74",5],["PK",5],["Pecheneg",5]
			],
			// corporal MG
			[
				
			],
			// sergeant MG
			[
				
			],
			// lieutenant MG
			[
			],
			// captain MG
			[
			],
			// major MG
			[
			],
			// colonel MG
			[
			]
		],
		[
			// private launchers
			[
				["RPG7V",5],["STRELA",5],["RPG18",5],["Igla",5],["MetisLauncher",5]
			],
			// corporal launchers
			[
				
			],
			// sergeant launchers
			[
				
			],
			// lieutenant launchers
			[
			],
			// capain launchers
			[
				
			],
			// major launchers
			[
			],
			// colonel launchers
			[
				["JAVELIN",2]
			]
		],
		[
			// private pistols
			[
				["MakarovSD",5],["Makarov",5]
			],
			// corporal pistols
			[
				
			],
			// sergeant pistols
			[
			],
			// lieutenant pistols
			[
			],
			// captain pistols
			[
			],
			// major pistols
			[
			],
			// colonel pistols
			[
			]
		]
	];
	
	{GVAR(misc_store) setVariable [_x,[]]} forEach ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
	
	{
		for "_i" from 0 to (count _x) - 1 do {
			_typear = _x select _i;
			if (count _typear > 0) then {
				_rank = switch (_i) do {
					case 0: {
						{
							_ar = GV2(GVAR(misc_store),_x);
							{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
						} forEach ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
					};
					case 1: {
						{
							_ar = GV2(GVAR(misc_store),_x);
							{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
						} forEach ["CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
					};
					case 2: {
						{
							_ar = GV2(GVAR(misc_store),_x);
							{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
						} forEach ["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
					};
					case 3: {
						{
							_ar = GV2(GVAR(misc_store),_x);
							{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
						} forEach ["LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
					};
					case 4: {
						{
							_ar = GV2(GVAR(misc_store),_x);
							{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
						} forEach ["CAPTAIN","MAJOR","COLONEL"];
					};
					case 5: {
						{
							_ar = GV2(GVAR(misc_store),_x);
							{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
						} forEach ["MAJOR","COLONEL"];
					};
					case 6: {
						_ar = GV(GVAR(misc_store),COLONEL);
						{_ar set [count _ar, toUpper(_x select 0)]} forEach _typear;
					};
				};
			};
		};
	} forEach (_x_ranked_weapons_w + _x_ranked_weapons_e);
	
	x_ranked_weapons = if (GVAR(player_side) == west) then {_x_ranked_weapons_w} else {_x_ranked_weapons_e};
	_x_ranked_weapons_w = nil;
	_x_ranked_weapons_e = nil;
	
	execFSM "fsms\LimitWeaponsRanked.fsm";
};

[_vec] spawn {
	private ["_vec", "_old_rank", "_index", "_weapons", "_i", "_rk"];
	PARAMS_1(_vec);
	_old_rank = "";
	while {!isNull _vec && alive _vec} do {
		if (_old_rank != rank player) then {
			clearMagazineCargo _vec;
			clearWeaponCargo _vec;
			_old_rank = rank player;
			_index = _old_rank call FUNC(GetRankIndex);
			if (GVAR(player_side) == west) then {
				{
					_weapons = _x;
					for "_i" from 0 to _index do {
						_rk = _weapons select _i;
						{_vec addweaponcargo _x} forEach _rk;
					};
				} forEach x_ranked_weapons;
				
				__awc(Laserdesignator,1)
				__awc(Binocular,1)
				if (GVAR(without_nvg) == 1) then {
					__awc(NVGoggles,1)
				};
								__awc(Laserdesignator,1)
				__awc(Binocular,1)
				__awc(Binocular_Vector,1)
				__awc(NVGoggles,1)
				__awc(STINGER,1)
				
				__amc(HandGrenade_West,30)
				//__amc(HandGrenade_Stone,50)
				__amc(Smokeshell,20)
				__amc(Smokeshellred,20)
				__amc(Smokeshellgreen,20)
				__amc(SmokeShellYellow,20)
				__amc(SmokeShellOrange,20)
				__amc(SmokeShellPurple,50)
				__amc(SmokeShellBlue,50)
				__amc(30Rnd_9x19_MP5,30)
				__amc(30Rnd_9x19_MP5SD,30)
				__amc(7Rnd_45ACP_1911,30)
				__amc(6Rnd_45ACP,50)
				__amc(20Rnd_B_765x17_Ball,30)
				__amc(10Rnd_B_765x17_Ball,50)
				__amc(15Rnd_9x19_M9,30)
				__amc(15Rnd_9x19_M9SD,30)
				__amc(17Rnd_9x19_glock17,50)
				__amc(20Rnd_556x45_Stanag,30)
				__amc(30Rnd_556x45_Stanag,30)
				__amc(30Rnd_556x45_StanagSD,30)
				__amc(30Rnd_762x39_SA58,50)
				__amc(20Rnd_762x51_FNFAL,30)
				__amc(10x_303,50)
				__amc(30Rnd_556x45_G36,30)
				__amc(30Rnd_556x45_G36SD,30)
				__amc(200Rnd_556x45_M249,30)
				__amc(100Rnd_556x45_M249,30)
				__amc(100Rnd_556x45_BetaCMag,30)
				//__amc(8Rnd_B_Beneli_74Slug,50)
				__amc(5Rnd_762x51_M24,6)
				__amc(20Rnd_762x51_DMR,50)
				__amc(10Rnd_127x99_M107,12)
				__amc(20Rnd_762x51_B_SCAR,30)
				__amc(20rnd_762x51_SB_SCAR,30)
				__amc(100Rnd_762x51_M240,30)
				__amc(FlareWhite_M203,20)
				__amc(FlareGreen_M203,20)
				__amc(FlareRed_M203,20)
				__amc(FlareYellow_M203,20)
				__amc(1Rnd_HE_M203,30)
				__amc(6Rnd_FlareWhite_M203,20)
				__amc(6Rnd_FlareGreen_M203,20)
				__amc(6Rnd_FlareRed_M203,20)
				__amc(6Rnd_FlareYellow_M203,20)
				__amc(6Rnd_HE_M203,30)
				__amc(6Rnd_Smoke_M203,20)
				__amc(6Rnd_SmokeRed_M203,20)
				__amc(6Rnd_SmokeGreen_M203,20)
				__amc(6Rnd_SmokeYellow_M203,20)
				__amc(1Rnd_Smoke_M203,20)
				__amc(1Rnd_SmokeRed_M203,20)
				__amc(1Rnd_SmokeGreen_M203,20)
				__amc(1Rnd_SmokeYellow_M203,20)
				__amc(M136,10)
				__amc(Dragon_EP1,10)
				__amc(MAAWS_HEAT,2)
				__amc(MAAWS_HEDP,2)
				__amc(NLAW,6)
				__amc(Pipebomb,5)
				__amc(Mine,10)
				__amc(Laserbatteries,20)
				__amc(JAVELIN,1)
				__amc(STINGER,2)
				//__amc(30Rnd_545x39_AK,50)
				//__amc(PG7V,3)
				//__amc(PG7VR,3)
				//__amc(PG7VL,3)
				//__amc(100Rnd_762x54_PK,50)
				//__amc(60Rnd_762x54_DT,50)
				//__amc(75Rnd_545x39_RPK,50)
				__amc(IR_Strobe_Target,3)
				__amc(IR_Strobe_Marker,3)
				__amc(IRStrobe,3)
//PMC AMMO				
				__amc(20Rnd_B_AA12_Pellets,20)
				__amc(20Rnd_B_AA12_74Slug,20)
				__amc(20Rnd_B_AA12_HE,20)
				__amc(5Rnd_127x99_AS50,20)
				__amc(10Rnd_127x99_m107,20)
				
				__amc(30Rnd_9x19_UZI,30)
				__amc(30Rnd_9x19_UZI_SD,30)
				
				//__amc(30Rnd_762x39_AK47,50)
				//__amc(10Rnd_762x54_SVD,50)
				__amc(HandGrenade_West,50)
				__amc(HandGrenade_Stone,50)
				__amc(Smokeshell,50)
				__amc(Smokeshellred,50)
				__amc(Smokeshellgreen,50)
				__amc(SmokeShellYellow,50)
				__amc(SmokeShellOrange,50)
				__amc(SmokeShellPurple,50)
				__amc(30Rnd_9x19_MP5,50)
				__amc(30Rnd_9x19_MP5SD,50)
				__amc(7Rnd_45ACP_1911,50)
				__amc(15Rnd_9x19_M9,50)
				__amc(15Rnd_9x19_M9SD,50)
				__amc(20Rnd_556x45_Stanag,50)
				__amc(30Rnd_556x45_Stanag,50)
				__amc(30Rnd_556x45_StanagSD,50)
				__amc(30Rnd_556x45_G36,50)
				__amc(200Rnd_556x45_M249,50)
				__amc(100Rnd_556x45_BetaCMag,50)
				__amc(8Rnd_B_Beneli_74Slug,50)
				__amc(5Rnd_762x51_M24,6)
				__amc(20Rnd_762x51_DMR,6)
				__amc(10Rnd_127x99_M107,3)
				__amc(100Rnd_762x51_M240,50)
				__amc(FlareWhite_M203,50)
				__amc(FlareGreen_M203,50)
				__amc(FlareRed_M203,50)
				__amc(FlareYellow_M203,50)
				__amc(1Rnd_HE_M203,50)
				__amc(M136,10)
				__amc(SMAW_HEAA,3)
				__amc(SMAW_HEDP,3)
				__amc(Pipebomb,5)
				__amc(Mine,30)
				__amc(Laserbatteries,20)
				__amc(JAVELIN,1)
				__amc(STINGER,2)

			} else {
				{
					_weapons = _x;
					for "_i" from 0 to _index do {
						_rk = _weapons select _i;
						{_vec addweaponcargo _x} forEach _rk;
					};
				} forEach x_ranked_weapons;

				__awc(Laserdesignator,1)
				__awc(Binocular,1)
				if (GVAR(without_nvg) == 1) then {
					__awc(NVGoggles,1)
				};
				__awc(Laserdesignator,1)
				__awc(Binocular,1)
				__awc(Binocular_Vector,1)
				__awc(NVGoggles,1)
				
				__amc(30Rnd_545x39_AK,30)
				__amc(30Rnd_762x39_AK47,30)
				__amc(64Rnd_9x19_Bizon,30)
				__amc(64Rnd_9x19_SD_Bizon,30)
				__amc(8Rnd_B_Saiga12_74Slug,30)
				__amc(10Rnd_9x39_SP5_VSS,30)
				__amc(20Rnd_9x39_SP5_VSS,30)
				__amc(75Rnd_545x39_RPK,30)
				__amc(60Rnd_762x54_DT,50)
				__amc(30Rnd_9x19_UZI,50)
				__amc(30Rnd_9x19_UZI_SD,50)
				__amc(FlareWhite_GP25,20)
				__amc(FlareGreen_GP25,20)
				__amc(FlareRed_GP25,20)
				__amc(FlareYellow_GP25,20)
				__amc(1Rnd_HE_GP25,30)
				__amc(1Rnd_SMOKE_GP25,20)
				__amc(1Rnd_SmokeRed_GP25,20)
				__amc(1Rnd_SmokeGreen_GP25,20)
				__amc(1Rnd_SmokeYellow_GP25,20)
				__amc(30Rnd_545x39_AKSD,30)
				__amc(100Rnd_762x54_PK,30)
				__amc(10Rnd_762x54_SVD,6)
				__amc(8Rnd_9x18_Makarov,30)
				__amc(8Rnd_9x18_MakarovSD,30)
				__amc(PG7V,3)
				__amc(PG7VR,3)
				__amc(PG7VL,3)
				__amc(PG9_AT,3)
				__amc(OG7,3)
				__amc(OG9_HE,3)
				__amc(AT13,3)
				__amc(RPG18,3)
				__amc(Igla,5)
				__amc(SmokeShellRed,20)
				__amc(SmokeShellGreen,20)
				__amc(SmokeShellYellow,20)
				__amc(SmokeShellPurple,50)
				__amc(SmokeShellBlue,50)
				__amc(SmokeShellOrange,20)
				__amc(SmokeShell,20)
				__amc(HandGrenade_East,30)
				__amc(5Rnd_127x108_KSVK,3)
				__amc(Mine,10)
				__amc(Pipebomb,5)
				__amc(Laserbatteries,10)
				__amc(Strela,2)
				__amc(IR_Strobe_Target,3)
				__amc(IR_Strobe_Marker,3)
				__amc(IRStrobe,3)
				__amc(30Rnd_545x39_AK,50)
				__amc(30Rnd_762x39_AK47,50)
				__amc(64Rnd_9x19_Bizon,50)
				__amc(64Rnd_9x19_SD_Bizon,50)
				__amc(8Rnd_B_Saiga12_74Slug,50)
				__amc(10Rnd_9x39_SP5_VSS,50)
				__amc(75Rnd_545x39_RPK,50)
				__amc(FlareWhite_GP25,50)
				__amc(FlareGreen_GP25,50)
				__amc(FlareRed_GP25,50)
				__amc(FlareYellow_GP25,50)
				__amc(1Rnd_HE_GP25,50)
				__amc(30Rnd_545x39_AKSD,50)
				__amc(100Rnd_762x54_PK,50)
				__amc(10Rnd_762x54_SVD,6)
				__amc(8Rnd_9x18_Makarov,50)
				__amc(8Rnd_9x18_MakarovSD,50)
				__amc(PG7V,3)
				__amc(PG7VR,3)
				__amc(PG7VL,3)
				__amc(OG7,3)
				__amc(AT13,3)
				__amc(RPG18,3)
				__amc(Igla,5)
				__amc(SmokeShellRed,50)
				__amc(SmokeShellGreen,50)
				__amc(SmokeShell,50)
				__amc(HandGrenade_East,50)
				__amc(5Rnd_127x108_KSVK,3)
				__amc(Mine,30)
				__amc(Pipebomb,5)
				__amc(Laserbatteries,20)
				__amc(Strela,2)
			};
		};
		sleep 2.32;
	};
};
