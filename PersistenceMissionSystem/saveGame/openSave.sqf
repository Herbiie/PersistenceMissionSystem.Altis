private _dialog = createDialog "saveGameDialog";
missionNameSpace setVariable ["pms_currentSaveGamesLoaded",false,true];
[] remoteExec ["pms_fnc_getSaves",2];
waitUntil {missionNameSpace getVariable ["pms_currentSaveGamesLoaded",false];};
private _allSaves = missionNameSpace getVariable ["pms_currentSaveGames",[]];
{
	private _split = _x splitString "-";
	private _thisWorld = format ["%1save",worldName];
	private _variableWorld = _split # 0;
	if ((_thisWorld == _variableWorld) && (count _split > 1)) then {
		private _variableName = _split # 1;
		private _thisLine = lbAdd [1500,_variableName];
		lbSetData  [1500,_thisLine,_variableName];
	};
} forEach _allSaves;