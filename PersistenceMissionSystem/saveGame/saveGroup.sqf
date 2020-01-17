params ["_group"];

private _side = side _group;
private _saveUnits = [];
private _vehicles = [];
{
	private _type = typeOf _x;
	private _weapon = weapons _x;
	private _priKit = primaryWeaponItems _x;
	private _priMag = (PrimaryWeaponMagazine _x) select 0;
	if (!isNil "_priMag") then {
		_PriKit pushBack _PriMag;
	 };
	private _secKit = secondaryWeaponItems _x;
	private _secMag = (secondaryWeaponMagazine _x) select 0;
	if (!isNil "_secMag") then {
		_secKit pushBack _secMag;
	};
	private _pisKit = handgunItems _x;
	private _pisMag = (handgunMagazine _x) select 0;
	if (!isNil "_pisMag") then {
		_pisKit pushBack _pisMag;
	};
	private _backpack = backpack _x;
	private _backPackItems = backpackItems _x;
	private _headgear = headgear _x;
	private _uniform = uniform _x;
	private _uniformItems = uniformItems _x;
	private _vest = vest _x;
	private _vestItems = vestItems _x;
	private _goggles = goggles _x;
	private _assignedItems = assignedItems _x;
	private _unitKit = [_weapon, _PriKit, _SecKit, _PisKit, _backpack, _backpackitems, _headgear, _uniform, _uniformItems, _vest, _vestItems, _goggles, _assignedItems];
		
	private _position = getPosATL _x;
	private _dir = getDir _x;
	
	private _rank = rank _x;
	
	private _target = _x checkAiFeature "TARGET";
	private _autoTarget = _x checkAiFeature "AUTOTARGET";
	private _move = _x checkAiFeature "MOVE";
	private _anim = _x checkAiFeature "ANIM";
	private _teamswitch = _x checkAiFeature "TEAMSWITCH";
	private _fsm = _x checkAiFeature "FSM";
	private _weaponAim = _x checkAiFeature "WEAPONAIM";
	private _aimingError = _x checkAiFeature "AIMINGERROR";
	private _suppression = _x checkAiFeature "SUPPRESSION";
	private _checkVisible = _x checkAiFeature "CHECKVISIBLE";
	private _cover = _x checkAiFeature "COVER";
	private _autocombat = _x checkAiFeature "AUTOCOMBAT";
	private _path = _x checkAiFeature "PATH";
	private _mineDetection = _x checkAiFeature "MINEDETECTION";
	private _nvg = _x checkAiFeature "NVG";
	private _lights = _x checkAiFeature "LIGHTS";
	
	private _features = [_target,_autoTarget,_move,_anim,_teamswitch,_fsm,_weaponaim,_aimingError,_suppression,_checkVisible,_cover,_autocombat,_path,_minedetection,_nvg,_lights];
		
	private _damageArray = getAllHitPointsDamage _x;
	private _damage = [];
	{
		private _thisDamage = [_x, ((_damageArray select 2) select _forEachIndex)];
		_damage pushBack _thisDamage;
	} forEach (_damageArray select 0);
	private _vehicle = -1;
	private _vehiclePos = assignedVehicleRole _x;
	if (vehicle _x != _x) then {
		_vehicles pushBackUnique vehicle _x;
		_vehicle = (count _vehicles)-1;
	};
	
	private _unitArray = [_type,_unitKit,_position,_dir,_rank,_features,_damage,_vehicle,_vehiclePos];
	_saveUnits pushBack _unitArray;
} forEach units _group;

private _vehiclesArray = [];
{
	private _vehicleType = typeOf _x;
	private _position = getPos _x;
	private _direction = getDir _x;
	private _fuel = fuel _x;
	private _backpacks = [];
	{		
		private _backpackItems = itemCargo _x;
		private _backpackWeapons = weaponCargo _x;
		private _backpackMagazines = magazineCargo _x;
		private _backpackDescription = typeOf _x;
		_backpacks = _backpacks + [[_backpackDescription, _backpackMagazines, _backpackWeapons, _backpackItems]];
	} forEach everyBackpack _x;
	private _magazines = magazineCargo _x;
	private _weapons = weaponCargo _x;
	private _items = itemCargo _x;
	private _damageArray = getAllHitPointsDamage _x;
	private _damage = [];
	{
		private _thisDamage = [_x, ((_damageArray select 2) select _forEachIndex)];
			_damage pushBack _thisDamage;
	} forEach (_damageArray select 0);
	private _vehicleArray = [_vehicleType, _position, _direction, _fuel,_magazines, _weapons, _items, _backpacks, _damage];
	_vehiclesArray pushBack _vehicleArray;
} forEach _vehicles;

private _groupArray = [_side,_saveUnits,_vehiclesArray];
pms_groups pushBack _groupArray;