class XD_UnloadDialog {
	idd = -1;
	movingEnable = 1;
	onLoad="uiNamespace setVariable ['D_UNLOAD_DIALOG', _this select 0];[] execVM 'x_client\x_fillunload.sqf'";
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
			XCTextBI;
			text = "UNLOAD DIALOG";
		};
		class XD_SelectButton: XD_ButtonBase {
			idc = -1;
			text = "Select"; 
			action = "0 execVM 'x_client\x_setcargo.sqf'";
			x = 0.23;
			y = 0.70;
		};
		class XD_CancelButton: XD_ButtonBase {
			idc = -1;
			text = "Cancel"; 
			action = "closeDialog 0";
			x = 0.56;
			y = 0.70;
			default = true;
		};
		class XD_Unloadlistbox : SXRscListBox {
			idc = 101115;
			x = 0.36;
			y = 0.3;
			w = 0.275;
			h = 0.36;
			sizeEx = 0.023;
			rowHeight = 0.06;
			style = ST_LEFT;
		};
		class XD_UnloadCaption : XC_RscText {
			x = 0.4;
			y = 0.22;
			w = 0.2;
			h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select vehicle to unload:";
		};
	};
};
