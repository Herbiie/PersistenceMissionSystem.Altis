params ["_unit"];

private _playerID = getPlayerUID _unit;
// Remove Old Save
private _idNumber = pms_playerIDs find _playerID;
pms_playerIDs deleteAt _idNumber;
private _playerNumber = 0;
private _a = 0;
{
	if (_playerID in _x) then {
		_playerNumber = _a;
	};
	_a = _a + 1;
} forEach pms_players;
pms_players deleteAt _playerNumber;



// Add New Save
	private _weapon = weapons _unit;
	private _priKit = primaryWeaponItems _unit;
	private _priMag = (PrimaryWeaponMagazine _unit) select 0;
	if (!isNil "_priMag") then {
		_PriKit pushBack _PriMag;
	 };
	private _secKit = secondaryWeaponItems _unit;
	private _secMag = (secondaryWeaponMagazine _unit) select 0;
	if (!isNil "_secMag") then {
		_secKit pushBack _secMag;
	};
	private _pisKit = handgunItems _unit;
	private _pisMag = (handgunMagazine _unit) select 0;
	if (!isNil "_pisMag") then {
		_pisKit pushBack _pisMag;
	};
	private _backpack = backpack _unit;
	private _backPackItems = backpackItems _unit;
	private _headgear = headgear _unit;
	private _uniform = uniform _unit;
	private _uniformItems = uniformItems _unit;
	private _vest = vest _unit;
	private _vestItems = vestItems _unit;
	private _goggles = goggles _unit;
	private _assignedItems = assignedItems _unit;
	private _position = getPosATL _unit;
	private _dir = getDir _unit;
	private _playerKit = [_weapon, _PriKit, _SecKit, _PisKit, _backpack, _backpackitems, _headgear, _uniform, _uniformItems, _vest, _vestItems, _goggles, _assignedItems];
	
	private _damageArray = getAllHitPointsDamage _unit;
	private _damage = [];
	{
		private _thisDamage = [_x, ((_damageArray select 2) select _forEachIndex)];
		_damage pushBack _thisDamage;
	} forEach (_damageArray select 0);
		
	sleep 1;
	pms_players pushBack [_playerID, _dir, _position, _playerKit,_damage];
	pms_playerIDs pushBack _playerID;