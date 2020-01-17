params ["_variable"];
missionNameSpace setVariable ["pms_loaded",false,true];
private _loadVariable = profileNameSpace getVariable _variable;
_loadVariable params ["_loadVehicles","_loadPlayers","_loadPlayerIDs","_loadGroups"];

missionNameSpace setVariable ["pms_playerIDs",_loadPlayerIDs,true];
missionNameSpace setVariable ["pms_players",_loadPlayers,true];
[] remoteExec ["pms_fnc_loadPlayer",2];


{
	deleteVehicle _x;
} forEach allMissionObjects "LandVehicle";

{
	deleteVehicle _x;
} forEach allMissionObjects "Air";

{
	deleteVehicle _x;
} forEach allMissionObjects "Ship";

{
	if (!isPlayer _x) then {
		deleteVehicle _x;
	};
} forEach allUnits;

{
	_x call pms_fnc_loadGroup;
} forEach _loadGroups;

[_loadVehicles] spawn pms_fnc_loadVehicles;
missionNameSpace setVariable ["pms_loaded",true,true];