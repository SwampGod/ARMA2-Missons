class XD_MsgDialog {
	idd = -1;
	movingEnable = 1;
	objects[] = {};
	onLoad="uiNamespace setVariable ['XD_MsgDialog', _this select 0]";
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
		class SettingsCaption : XC_RscText {
			x = 0.12;
			y = 0.04;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			text = "MESSAGE SYSTEM";
		};
		class MessageLine : XC_RscText {
			idc = -1;
			x = 0.12;
			y = 0.3;
			w = 0.776;
			h = 0.002;
			sizeEx = 0.001;
			colorBackground[] = {0, 0, 0, 0.8};
			XCTextBlack;
			text = "";
		};
		class MessageCaption : XC_RscText {
			idc = 1505;
			x = 0.12;
			y = 0.15;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select Player";
		};
		class MessageHint : XC_RscText {
			idc = 1506;
			x = 0.12;
			y = 0.175;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.017;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Select player to send message to";
		};
		class MessageCombo:XD_UIComboBox {
			idc = 1005;
			x = 0.128;
			y = 0.24;
			w = 0.23;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'x_msg\x_pmselchanged.sqf'";
		};
		class MessageEditCap : XC_RscText {
			idc = -1;
			x = 0.12;
			y = 0.29;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			text = "Message Text:";
		};
		class MessageEditbox {
			idc = 1201;
			type = 2;
			style = ST_LEFT + ST_MULTI;
			x = 0.13;
			y = 0.38;
			w = 0.758;
			h = 0.44;
			sizeEx = 0.035;
			font = "Zeppelin32";
			text = "";
			colorBackground[] = {0.95,0.95,0.95,1};
			colorText[] = {1, 1, 1, 0.8};
			autocomplete = false;
			colorSelection[] = {0.543, 0.5742, 0.4102, 1};
		};
		class MessageNameSel : XC_RscText {
			idc = 1010;
			x = 0.365;
			y = 0.81;
			w = 0.4;
			h = 0.1;
			sizeEx = 0.03;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBI;
			text = "";
		};
		class MessageSendBut: XD_ButtonBase {
			idc = -1;
			text = "Send Msg To:"; 
			action = "call XSendMsgSysMsg";
			x = 0.125;
			y = 0.81;
		};
		class MessageClearBut: XD_ButtonBase {
			idc = -1;
			text = "Clear Text Box"; 
			action = "_ctrl = (uiNamespace getVariable 'XD_MsgDialog') displayCtrl 1201;_ctrl ctrlsettext ''";
			x = 0.665;
			y = 0.81;
		};
		class MessageRecCaption : XC_RscText {
			idc = -1;
			x = 0.65;
			y = 0.15;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select Received Msg:";
		};
		class MessageRecHint : XC_RscText {
			idc = -1;
			x = 0.65;
			y = 0.175;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.017;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Select received messages";
		};
		class MessageRecCombo:XD_UIComboBox {
			idc = 1030;
			x = 0.658;
			y = 0.24;
			w = 0.23;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'x_msg\x_pmrecchanged.sqf'";
		};
		class MessageSendCaption : XC_RscText {
			idc = -1;
			x = 0.385;
			y = 0.15;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCTextBlack;
			text = "Select Send Msg:";
		};
		class MessageSendHint : XC_RscText {
			idc = -1;
			x = 0.385;
			y = 0.175;
			w = 0.25;
			h = 0.1;
			sizeEx = 0.017;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {0.5, 0.5, 0.5, 0.8};
			text = "Select send messages";
		};
		class MessageSendCombo:XD_UIComboBox {
			idc = 1031;
			x = 0.393;
			y = 0.24;
			w = 0.23;
			h = 0.03;
			onLBSelChanged = "[_this] execVM 'x_msg\x_pmrsendchanged.sqf'";
		};
		class CloseButton: XD_ButtonBase {
			idc = -1;
			text = "Close"; 
			action = "closeDialog 0";
			default = true;
			x = 0.68;
			y = 0.945;
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