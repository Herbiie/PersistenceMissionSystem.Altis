[] spawn {
	waituntil {!isnull (finddisplay 46)};
	(findDisplay 46) displayAddEventHandler ["KeyDown", {
		params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"];
		if ((_key == 25) && !isNull (getAssignedCuratorLogic player) && !_alt) then {
			[] spawn pms_fnc_openSave;
		};
		if ((_key == 25) && !isNull (getAssignedCuratorLogic player) && _alt) then {
			[] spawn pms_fnc_openLoad;
		};
	}];
};

player createDiarySubject ["pms","PMS"];
player createDiaryRecord ["pms",["Keybinds","Open Save Game Menu: 'P'<br/>Open Load Game Menu : 'alt+P'"]];
player createDiaryRecord ["pms",["Read Me","The Persistence Mission System (PMS) is designed to allow Zeus missions to be saved and loaded, allowing missions to be ended and then loaded again at a different time.<br/>
<br/>
PMS is designed for Zeus missions as it does not seamlessly integrate with scripts, such as end condition scripts, in a mission.<br/>
<br/>
When a mission is saved, the following will be saved to a variable in the server's profileNameSpace:<br/>
- Player locations, directions, loadouts, damage.<br/>
- Vehicle locations, directions, fuel levels, inventories, damage.<br/>
- AI Groups units, locations, loadouts, AI features (such as disbaleai 'path'), vehicles, vehicle crews, vehicle inventories, damage, etc.<br/>
<br/>
In its current configuration, PMS will NOT save:<br/>
- Markers<br/>
- Zeus placed objects"]];
player createDiaryRecord ["pms",["IMPORTANT","IMPORTANT:<br/>
When you save the mission players will be forcibly ejected from their vehicles. Ensure all players are dismounted and vehicles are stationary."]];