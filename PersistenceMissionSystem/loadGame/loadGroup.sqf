params ["_side","_saveUnits","_vehiclesArray"];

private _newGroup = createGroup _side;

private _groupVehicles = [];

{
	_x params ["_class", "_position", "_dir", "_fuel","_magazines","_weapons","_items","_backpacks","_damage"];
	private _vehicle = _class createVehicle _position;
	_vehicle setDir _dir;
	_vehicle setFuel _fuel;
	clearMagazineCargoGlobal _vehicle;
	clearWeaponCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;
	if (count _magazines > 0) then {
		private _addMagazines = _magazines call BIS_fnc_consolidateArray;
		{
			_vehicle addMagazineCargoGlobal _x;
		} forEach _addMagazines;
	};
	if (count _weapons > 0) then {
		private _addWeapons = _weapons call BIS_fnc_consolidateArray;
		{
			_vehicle addWeaponCargoGlobal _x;
		} forEach _addWeapons;
	};
	if (count _items > 0) then {
		private _addItems = _items call BIS_fnc_consolidateArray;
		{
			_vehicle addItemCargoGlobal _x;
		} forEach _addItems;
	};
	if (count _backpacks > 0) then {
		{
			_vehicle addBackpackCargoGlobal [_x select 0, 1];
			private _backpackNumber = count (everyBackpack _vehicle) - 1;
			private _thisbackpack = everyBackpack _vehicle select _backpackNumber;
			if (count (_x select 1) > 0) then {
				private _addMagazines = _x select 1 call BIS_fnc_consolidateArray;
				{
					_thisBackpack addMagazineCargoGlobal _x;
				} forEach _addMagazines;
			};
			if (count (_x select 2) > 0) then {
				private _addWeapons = _x select 2 call BIS_fnc_consolidateArray;
				{
					_thisBackpack addWeaponCargoGlobal _x;
				} forEach _addWeapons;
			};
			if (count (_x select 3) > 0) then {
				private _addItems = _x select 3 call BIS_fnc_consolidateArray;
				{
					_thisBackpack addItemCargoGlobal _x;
				} forEach _addItems;
			};
		} forEach _backpacks;
	};
	{
		[_vehicle, (_x select 0), (_x select 1)] call BIS_fnc_setHitPointDamage;
	} forEach _damage;
	_groupVehicles pushBack _vehicle;
} forEach _vehiclesArray;

{
	_x params ["_type","_unitKit","_position","_dir","_rank","_features","_damage","_vehicle","_vehiclePos"];
	private _unit = _newGroup createUnit [_type,_position,[],0,"NONE"];
	_unit setRank _rank;
	_unitKit params ["_weapons", "_PriKit", "_SecKit", "_PisKit", "_backpack", "_backpackitems", "_headgear", "_uniform", "_uniformItems", "_vest", "_vestItems", "_goggles", "_assignedItems"];
	private _backpackContents =  (_backpackItems) call BIS_fnc_consolidateArray;
	private _vestContents =  (_vestItems) call BIS_fnc_consolidateArray;
	private _uniformContents =  (_uniformItems) call BIS_fnc_consolidateArray;
	if (_unit isKindOf "Man") then {
	
		if ( local _unit ) then {
			removeAllAssignedItems _unit; 
			removeAllItemsWithMagazines _unit;
			{_unit removeWeapon _x;} forEach weapons _unit;
		
			if ( _uniform != "") then {
				[_unit,_uniform] call pms_tb3_fnc_SetUniform;
			};
			if (_backpack != "") then {
				[_unit,[_backpack,1]] call pms_tb3_fnc_Setbackpack;
			};
			if (_vest != "") then {
				[_unit,_vest] call pms_tb3_fnc_Setvest;
			};
			
			removeGoggles _unit;
			removeHeadGear _unit; //no you may not leave your hat on.
		};
	};

	if ((count _assignedItems) > 0) then { [_unit,_assignedItems] call pms_tb3_fnc_SetLinkedItems; };
	if (_headgear != "") then { 
		[_unit,_headgear] call pms_tb3_fnc_SetHeadgear;
	};		
	if (_goggles != "") then {
		[_unit,_goggles] call pms_tb3_fnc_SetGoggles;
	};
	
	if ((count _weapons) > 0) then { [_unit,_weapons,_priKit,_secKit,_pisKit] call pms_tb3_fnc_SetWeapons; };
	
	if ((count _backpackContents) > 0) then { [_unit,_backpackContents] call pms_tb3_fnc_setRuckContents; };
	if ((count _uniformContents) > 0) then { [_unit,_uniformContents] call pms_tb3_fnc_setUniformContents; };
	if ((count _vestContents) > 0) then { [_unit,_vestContents] call pms_tb3_fnc_setVestContents; };
	
	if (_vehicle > -1) then {
		private _NewVehicle = _groupVehicles # _vehicle;
		private _roleType = toLower (_vehiclePos # 0);
		switch (_roleType) do {
			case "driver" : { _unit moveInDriver _newVehicle };
			case "cargo" : { _unit moveInCargo _newVehicle };
			case "turret" : { _unit moveInTurret [_newVehicle, _vehiclePos # 1] };
		};
	};
	
	{
		[_unit, (_x select 0), (_x select 1)] call BIS_fnc_setHitPointDamage;
	} forEach _damage;
	
	_features params ["_target","_autoTarget","_move","_anim","_teamswitch","_fsm","_weaponaim","_aimingError","_suppression","_checkVisible","_cover","_autocombat","_path","_minedetection","_nvg","_lights"];
	
	if (!_target) then {
		_unit disableai "TARGET";
	};
	if (!_autotarget) then {
		_unit disableai "AUTOTARGET";
	};
	if (!_move) then {
		_unit disableai "MOVE";
	};
	if (!_anim) then {
		_unit disableai "ANIM";
	};
	if (!_teamswitch) then {
		_unit disableai "TEAMSWITCH";
	};
	if (!_fsm) then {
		_unit disableai "FSM";
	};
	if (!_weaponaim) then {
		_unit disableai "WEAPONAIM";
	};
	if (!_aimingError) then {
		_unit disableai "AIMINGERROR";
	};
	if (!_suppression) then {
		_unit disableai "SUPPRESSION";
	};
	if (!_checkVisible) then {
		_unit disableai "CHECKVISIBLE";
	};
	if (!_cover) then {
		_unit disableai "COVER";
	};
	if (!_autoCombat) then {
		_unit disableai "AUTOCOMBAT";
	};
	if (!_path) then {
		_unit disableai "PATH";
	};
	if (!_minedetection) then {
		_unit disableai "MINEDETECTION";
	};
	if (!_nvg) then {
		_unit disableai "NVG";
	};
	if (!_lights) then {
		_unit disableai "LIGHTS";
	};
	_unit setVehiclePosition [_position,[],0,"NONE"];
	_unit setDir _dir;
} forEach _saveUnits;

{
	_x addCuratorEditableObjects [_groupVehicles,true];
} forEach allCurators;
{
	_x addCuratorEditableObjects [units _newGroup,true];
} forEach allCurators;
