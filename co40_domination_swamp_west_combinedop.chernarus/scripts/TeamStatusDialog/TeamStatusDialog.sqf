// Desc: Team Status Dialog
// Features: Group joining, Team Leader selection, statistics for team/group/vehicle/opposition
// By: Dr Eyeball
#define THIS_FILE "TeamStatusDialog.sqf"
#include "x_setup.sqf"

TSD9_VehicleSearchComplete = true;
TSD9_Vehicle = objNull;
TSD9_HideIcons = false;
TSD9_DeleteRemovedAI = false;
TSD9_AllowAILeaderSelect = false;
TSD9_AllowAIRecruitment = false;
TSD9_AllowPlayerInvites = false;
TSD9_AllowPlayerRecruitment = false;
TSD9_ShowAIGroups = false;
TSD9_CloseOnKeyPress = false;

d_teamstatus_dialog_params call TSD9_ProcessParameters;
[] call TSD9_DrawPage;
