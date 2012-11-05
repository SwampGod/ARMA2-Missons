class XD_VecDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['X_VEC_DIALOG', _this select 0]";
	objects[] = {};
	class controlsBackground {
		class XD_BackGround : XC_RscText {
			idc = -1;
			type = 0;
			style = 48;
			x = 0.1;
			y = 0;
			w = 1.5;
			h = 1.3;
			XCTextBlack;
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;
		};
	};
	class controls {
		class XD_CloseButton: XD_ButtonBase {
			idc = -1;
			text = "Close"; 
			action = "closeDialog 0";
			default = true;
			x = 0.58;
			y = 0.945;
		};
		class XD_VecDialogCaption : XC_RscText {
			x = 0.18;
			y = 0.03;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.04;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			text = "VEHICLE DIALOG";
		};
		class XD_VecPicture : XD_RscPicture {
			idc = 44444;
			x=0.43; y=0.195; w=0.1; h=0.1;
			text="";
			sizeEx = 256;
		};
		class XD_VecDialogCaption2 : XC_RscText {
			idc = 44445;
			x = 0.55;
			y = 0.2;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.032;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			text = "Chopper 1";
		};
		class XD_AmmoBoxCaption : XC_RscText {
			idc = 44454;
			x = 0.24;
			y = 0.30;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Ammobox loaded:";
		};
		class XD_BoxPicture : XD_RscPicture {
			idc = 44446;
			x=0.23; y=0.35; w=0.17; h=0.17;
			text="";
			sizeEx = 256;
		};
		class XD_BoxPicture2 : XD_RscPicture {
			idc = 44447;
			x=0.25; y=0.375; w=0.12; h=0.12;
			text="";
			sizeEx = 256;
		};
		class XD_DropAmmoButton: XD_ButtonBase {
			idc = 44448;
			text = "Drop Box"; 
			action = "closeDialog 0;if (!AmmoBoxHandling) then {[vehicle player, player] execVM 'x_client\x_dropammobox2.sqf'} else {[vehicle player, player] execVM 'x_client\x_dropammobox_old.sqf'}";
			x = 0.20;
			y = 0.52;
		};
		class XD_LoadAmmoButton: XD_ButtonBase {
			idc = 44452;
			text = "Load Box"; 
			action = "closeDialog 0;[vehicle player, player] execVM 'x_client\x_loaddropped.sqf'";
			x = 0.20;
			y = 0.58;
		};
		class XD_CreateVecCaption : XC_RscText {
			idc = 44450;
			x = 0.50;
			y = 0.30;
			w = 0.25;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Create Vehicle:";
		};
		class XD_CreateListbox : SXRscListBox {
			idc = 44449;
			x = 0.50;
			y = 0.40;
			w = 0.275;
			h = 0.20;
			sizeEx = 0.023;
			rowHeight = 0.06;
			style = ST_LEFT;
			borderSize = 1;
		};
		class XD_CreateVecButton: XD_ButtonBase {
			idc = 44451;
			text = "Create Vehicle"; 
			action = "0 execVM 'x_client\x_create_vec.sqf'";
			x = 0.52;
			y = 0.64;
		};
		class dtext2 : SXRscText {
			x = 0.14;
			y = 0.99;
			w = 0.2;
			h = 0.03;
			sizeEx = 0.032;
			colorText[] = {0.643, 0.5742, 0.4102, 1};
			text = "Domination! 2";
		};
		class XD_TeleportButton: XD_ButtonBase {
			idc = 44453;
			text = "Teleport"; 
			action = "closeDialog 0;[] execVM 'x_client\x_teleport.sqf'";
			x = 0.20;
			y = 0.64;
		};
		class XD_SATViewButton: XD_ButtonBase {
			idc = 44459;
			text = "SAT View"; 
			action = "closeDialog 0;[] execVM 'scripts\SatellitenBild.sqf'";
			x = 0.20;
			y = 0.70;
		};
		class XD_DeployMHQ: XD_ButtonBase {
			idc = 44462;
			text = "Deploy MHQ"; 
			action = "closeDialog 0;[] execVM 'x_client\x_deploymhq.sqf'";
			x = 0.37;
			y = 0.80;
		};
	};
};
