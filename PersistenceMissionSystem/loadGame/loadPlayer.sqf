waitUntil {missionNameSpace getVariable "pms_loaded"};
private _playerSaved = getPlayerUID player in (missionNameSpace getVariable "pms_playerIDs");
if (_playerSaved) then {
	private _playerArray = [];
	{
		if (getPlayerUID player in _x) then {
			_playerArray = _x;
		};
	} forEach (missionNameSpace getVariable "pms_players");
	
	_playerArray params ["_playerIDSaved", "_dir", "_position", "_playerKit","_damage"];
	_playerKit params ["_weapons", "_PriKit", "_SecKit", "_PisKit", "_backpack", "_backpackitems", "_headgear", "_uniform", "_uniformItems", "_vest", "_vestItems", "_goggles", "_assignedItems"];
	private _backpackContents =  (_backpackItems) call BIS_fnc_consolidateArray;
	private _vestContents =  (_vestItems) call BIS_fnc_consolidateArray;
	private _uniformContents =  (_uniformItems) call BIS_fnc_consolidateArray;
	if (player isKindOf "Man") then {
	
		if ( local player ) then {
			removeAllAssignedItems player; 
			removeAllItemsWithMagazines player;
			{player removeWeapon _x;} forEach weapons player;
		
			if ( _uniform != "") then {
				[player,_uniform] call pms_tb3_fnc_SetUniform;
			};
			if (_backpack != "") then {
				[player,[_backpack,1]] call pms_tb3_fnc_Setbackpack;
			};
			if (_vest != "") then {
				[player,_vest] call pms_tb3_fnc_Setvest;
			};
			
			removeGoggles player;
			removeHeadGear player; //no you may not leave your hat on.
		};
	};

	if ((count _assignedItems) > 0) then { [player,_assignedItems] call pms_tb3_fnc_SetLinkedItems; };
	if (_headgear != "") then { 
		[player,_headgear] call pms_tb3_fnc_SetHeadgear;
	};		
	if (_goggles != "") then {
		[player,_goggles] call pms_tb3_fnc_SetGoggles;
	};
	
	if ((count _weapons) > 0) then { [player,_weapons,_priKit,_secKit,_pisKit] call pms_tb3_fnc_SetWeapons; };
	
	if ((count _backpackContents) > 0) then { [player,_backpackContents] call pms_tb3_fnc_setRuckContents; };
	if ((count _uniformContents) > 0) then { [player,_uniformContents] call pms_tb3_fnc_setUniformContents; };
	if ((count _vestContents) > 0) then { [player,_vestContents] call pms_tb3_fnc_setVestContents; };
		
	player setPos _position;
	player setDir _dir;	
	{
		[player, (_x select 0), (_x select 1)] call BIS_fnc_setHitPointDamage;
	} forEach _damage;
	
};