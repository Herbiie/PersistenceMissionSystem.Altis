private _dialog = createDialog "saveGameDialog";
{
	private _split = _x splitString "-";
	private _thisWorld = format ["%1save",worldName];
	private _variableWorld = _split # 0;
	if ((_thisWorld == _variableWorld) && (count _split > 1)) then {
		private _variableName = _split # 1;
		private _thisLine = lbAdd [1500,_variableName];
		lbSetData  [1500,_thisLine,_variableName];
	};
} forEach allVariables profileNameSpace;