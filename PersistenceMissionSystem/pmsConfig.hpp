class cfgFunctions {
	class pms {
		class saveGame {
			class savePlayer {
				file = "PersistenceMissionSystem\saveGame\savePlayer.sqf";
			};
			class saveVehicle {
				file = "PersistenceMissionSystem\saveGame\saveVehicle.sqf";
			};
			class saveMission {
				file = "PersistenceMissionSystem\saveGame\saveMission.sqf";
			};
			class openSave {
				file = "PersistenceMissionSystem\saveGame\openSave.sqf";
			};
			class saveGroup {
				file = "PersistenceMissionSystem\saveGame\saveGroup.sqf";
			};
			class getSaves {
				file = "PersistenceMissionSystem\saveGame\getSaves.sqf";				
			};
		};
		
		class loadGame {
			class loadPlayer {
				file = "PersistenceMissionSystem\loadGame\loadPlayer.sqf";
			};	
			class loadVehicles {
				file = "PersistenceMissionSystem\loadGame\loadVehicles.sqf";
			};
			class loadMission {
				file = "PersistenceMissionSystem\loadGame\loadMission.sqf";
			};	
			class openLoad {
				file = "PersistenceMissionSystem\loadGame\openLoad.sqf";
			};	
			class loadGroup {
				file = "PersistenceMissionSystem\loadGame\loadgroup.sqf";
			};		
		};
	};
	class pms_tb3 {
        #include "tb3\f\gear\CfgFunctions.hpp"
	};
};


#include "dialogs.hpp"

class saveGameDialog {
	idd = 19990;
	movingEnable = true;
	controlsBackground[] = { };
	objects[] = { };
	class controls {
		class rscFrame_1900: RscFrame
		{
			idc = 1900;
			x = 0.25;
			y = 0.25;
			w = safeZoneW/4;
			h = (safeZoneH/3)+((safeZoneH/24)*3);
		};
		class rscBack_2000: RscBack
		{
			idc = 2000;
			x = 0.25;
			y = 0.25;
			w = safeZoneW/4;
			h = (safeZoneH/3)+((safeZoneH/24)*3);
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.25;
			y = 0.25;
			w = safeZoneW/4;
			h = safeZoneH/3;
		};
		class rscText_1801: RscText
		{
			idc = 1801;
			x = 0.25;
			y = 0.25+safeZoneH/3;
			w = (safeZoneW/4)/3;
			h = safeZoneH/24;
			text = "New Save Name:";
		};
		class rscEdit_1802: RscEdit
		{
			idc = 1802;
			x = 0.25+((safeZoneW/4)/3);
			y = 0.25+safeZoneH/3;
			w = ((safeZoneW/4)/3)*2;
			h = safeZoneH/24;
			text = "SaveGame1";
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			x = 0.25;
			y = 0.25+((safeZoneH/3)+(safeZoneH/24));
			w = (safeZoneW/4)/3;
			h = safeZoneH/24;
			text = "New Save";
			action = "[(ctrlText 1802)] remoteExec ['pms_fnc_saveMission',2]; closeDialog 0";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			x = 0.25+((safeZoneW/4)/3);
			y = 0.25+((safeZoneH/3)+(safeZoneH/24));
			w = (safeZoneW/4)/3;
			h = safeZoneH/24;
			text = "Overwrite Save";
			action = "[lbData [1500,lbCurSel 1500]] remoteExec ['pms_fnc_saveMission',2]; closeDialog 0";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			x = 0.25+(((safeZoneW/4)/3)*2);
			y = 0.25+((safeZoneH/3)+(safeZoneH/24));
			w = (safeZoneW/4)/3;
			h = safeZoneH/24;
			text = "Cancel";
			action = "closeDialog 0";
		};
		class rscText_1802: RscText
		{
			idc = 1801;
			x = 0.25;
			y = 0.25+((safeZoneH/3)+((safeZoneH/24)*2));
			w = safeZoneW/4;
			h = safeZoneH/24;
			text = "*******SAVE NAMES MAY NOT CONTAIN THE CHARACTER - *******";
		};
	};
};

class loadGameDialog {
	idd = 19991;
	movingEnable = true;
	controlsBackground[] = { };
	objects[] = { };
	class controls {
		class rscFrame_1900: RscFrame
		{
			idc = 1900;
			x = 0.25;
			y = 0.25;
			w = safeZoneW/4;
			h = (safeZoneH/3)+(safeZoneH/24);
		};
		class rscBack_2000: RscBack
		{
			idc = 2000;
			x = 0.25;
			y = 0.25;
			w = safeZoneW/4;
			h = (safeZoneH/3)+(safeZoneH/24);
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.25;
			y = 0.25;
			w = safeZoneW/4;
			h = safeZoneH/3;
		};
		
		class RscButton_1601: RscButton
		{
			idc = 1601;
			x = 0.25;
			y = 0.25+(safeZoneH/3);
			w = safeZoneW/8;
			h = safeZoneH/24;
			text = "Load Game";
			action = "[lbData [1500,lbCurSel 1500]] remoteExec ['pms_fnc_loadMission',2]; closeDialog 0";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			x = 0.25+(safeZoneW/8);
			y = 0.25+(safeZoneH/3);
			w = safeZoneW/8;
			h = safeZoneH/24;
			text = "Cancel";
			action = "closeDialog 0";
		};
		
	};
};