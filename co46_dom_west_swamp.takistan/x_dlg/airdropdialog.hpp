class x_x_RscText {
	type = CT_STATIC;
	idc = -1;
	style = ST_LEFT;
	x = 0.0;y = 0.0;w = 0.3;h = 0.03;
	sizeEx = 0.023;
	colorBackground[] = {0.5, 0.5, 0.5, 0.75};
	colorText[] = {0, 0, 0, 1};
	font = FontM;
	text = "";
};
class XD_AirDropDialog {
	idd = -1;
	movingEnable = true;
	onLoad="uiNamespace setVariable ['D_DROP_DIALOG', _this select 0]";
	objects[] = {};
	class controlsBackground {
		class XD_BackGround : XC_RscText {
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0;
			w = 1.93;
			h = 1.3;
			XCTextBlack;
			colorBackground[] = {0,0,0,0};
			text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
			font = "Zeppelin32";
			sizeEx = 0.032;
		};
	};
	class controls {
		class XD_MainCaption : XC_RscText {
			x = 0.12;
			y = 0.05;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			text = "SUPPORT DIALOG";
		};
		class XD_CancelButton: XD_ButtonBase {
			idc = -1;
			text = "Cancel"; 
			action = "closeDialog 0";
			default = true;
			x = 0.68;
			y = 0.945;
		};
		class XD_Drop3: XD_ButtonBase {
			idc = 11004;
			text = "Drop Ammo";
			action = "x_drop_type = (X_Drop_Array select 2) select 1;closeDialog 0";
			x = 0.68;
			y = 0.32;
		};
		class XD_Drop2: XD_ButtonBase {
			idc = 11003;
			text = "Drop Vehicle";
			action = "x_drop_type = (X_Drop_Array select 1) select 1;closeDialog 0";
			x = 0.68;
			y = 0.26;
		};
		class XD_Drop1: XD_ButtonBase {
			idc = 11002;
			text = "Drop Artillery";
			action = "x_drop_type = (X_Drop_Array select 0) select 1;closeDialog 0";
			x = 0.68;
			y = 0.20;
		};
		class XD_DropText : XC_RscText {
			x = 0.68;
			y = 0.16;
			w = 0.3;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			sizeEx = 0.03;
			text = "Select Support:";
		};
		class XD_DropMapText : x_x_RscText {
			x = 0.12;
			y = 0.12;
			w = 0.3;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select drop zone by map click:";
		};
		class XD_Map : XD_RscMapControl {
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.12;
			y = 0.2;
			w = 0.52;
			h = 0.64;
			showCountourInterval = false;
		};
		class Dom2 : XC_RscText {
			x = 0.12;
			y = 0.945;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCMainCapt;
			text = "Domination! 2";
		};
	};
};
