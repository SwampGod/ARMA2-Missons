class XD_ArtilleryDialog {
	idd = -1;
	movingEnable = true;
	onLoad="uiNamespace setVariable ['D_ARTI_DISP', _this select 0]";
	objects[] = {};
	class controlsBackground {
		class XD_BackGround : XC_RscText {
			idc = -1;
			type = 0;
			style = 48;
			x = 0;
			y = 0;
			w = 1.93;
			h = 1.30;
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
			XCMainCapt;
			text = "ARTILLERY DIALOG";
		};
		class XD_CancelButton: XD_ButtonBase {
			idc = -1;
			text = "Cancel";
			action = "closeDialog 0";
			default = true;
			x = 0.68;
			y = 0.945;
		};
		class XD_SeriesOne: XD_ButtonBase {
			idc = 11006;
			text = "Series One"; 
			action = "((uiNamespace getVariable 'D_ARTI_DISP') displayCtrl 11009) ctrlSetText 'Fire: Series One';d_ari_salvos = 1";
			x = 0.68;
			y = 0.60;
		};
		class XD_SeriesTwo: XD_ButtonBase {
			idc = 11007;
			text = "Series Two"; 
			action = "((uiNamespace getVariable 'D_ARTI_DISP') displayCtrl 11009) ctrlSetText 'Fire: Series Two';d_ari_salvos = 2";
			x = 0.68;
			y = 0.66;
		};
		class XD_SeriesThree: XD_ButtonBase {
			idc = 11008;
			text = "Series Three"; 
			action = "((uiNamespace getVariable 'D_ARTI_DISP') displayCtrl 11009) ctrlSetText 'Fire: Series Three';d_ari_salvos = 3";
			x = 0.68;
			y = 0.72;
		};
		class XD_SalvosText : XC_RscText {
			idc = 11009;
			x = 0.68;
			y = 0.56;
			w = 0.3;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			sizeEx = 0.03;
			text = "Fire: Series One";
		};
		class XD_SADARMButton: XD_ButtonBase {
			idc = 11011;
			text = "Fire SADARM"; 
			action = "d_ari_type = 'sadarm';closeDialog 0";
			x = 0.68;
			y = 0.44;
		};
		class XD_SmokeButton: XD_ButtonBase {
			idc = 11004;
			text = "Fire Smoke"; 
			action = "d_ari_type = 'smoke';closeDialog 0";
			x = 0.68;
			y = 0.38;
		};
		class XD_FlareButton: XD_ButtonBase {
			idc = 11003;
			text = "Fire Flare"; 
			action = "d_ari_type = 'flare';closeDialog 0";
			x = 0.68;
			y = 0.32;
		};
		class XD_HEButton: XD_ButtonBase {
			idc = 11002;
			text = "Fire HE"; 
			action = "d_ari_type = 'he';closeDialog 0";
			x = 0.68;
			y = 0.26;
		};
		class XD_DPICMButton: XD_ButtonBase {
			idc = 11005;
			text = "Fire DPICM"; 
			action = "d_ari_type = 'dpicm';closeDialog 0";
			x = 0.68;
			y = 0.20;
		};
		class XD_ArtiText : XC_RscText {
			x = 0.68;
			y = 0.16;
			w = 0.3;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			sizeEx = 0.03;
			text = "Select Ordnance: ";
		};
		class XD_ArtiMapText : XC_RscText {
			x = 0.12;
			y = 0.12;
			w = 0.3;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select artillery target by map click:";
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
