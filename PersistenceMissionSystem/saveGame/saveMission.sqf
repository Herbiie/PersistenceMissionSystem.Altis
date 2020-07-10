params ["_variableText"];
pms_vehicles = [];
pms_players = [];
pms_playerIDs = [];
pms_groups = [];
private _variable = format ["%1save-%2",worldName,_variableText];
["Saving players..."] remoteExec ["hint",0];
{
	if (vehicle _x != _x) then {
		_x action ["Eject",vehicle _x];
	};
	[_x] call pms_fnc_savePlayer;
} forEach allPlayers;
["Saving vehicles..."] remoteExec ["hint",0];

{
	if (count crew _x == 0) then {
		[_x] call pms_fnc_saveVehicle;
	};
} forEach allMissionObjects "LandVehicle";

{
	if (count crew _x == 0) then {
		[_x] call pms_fnc_saveVehicle;
	};
} forEach allMissionObjects "Air";

{
	if (count crew _x == 0) then {
		[_x] call pms_fnc_saveVehicle;
	};
} forEach allMissionObjects "Ship";

private _saveGroups = [];

{
	private _save = true;
	private _group = _x;
	{
		if (isPlayer _x) exitWith {
			_save = false;
		};
	} forEach units _group;
	if (_save) then {
		_saveGroups pushBackUnique _x;
	};
} forEach allGroups;

{
	[_x] call pms_fnc_saveGroup;
} forEach _saveGroups;

profileNameSpace setVariable [_variable,[pms_vehicles,pms_players,pms_playerIDs,pms_groups]];
private _allSaves = profileNameSpace getVariable ["pms_saveGames",[]];
if (_variable in _allsaves) then {
	_allSaves deleteAt (_allSaves find _variable);
};
_allSaves pushBackUnique _variable;
profileNameSpace setVariable ["pms_saveGames",_allSaves];

saveProfileNameSpace;
["Saved"] remoteExec ["hint",0];