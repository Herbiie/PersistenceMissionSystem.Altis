params ["_veh"];
private _vehicleType = typeOf _veh;
private _position = getPos _veh;
private _direction = getDir _veh;
private _fuel = fuel _veh;
private _backpacks = [];
{		
	private _backpackItems = itemCargo _x;
	private _backpackWeapons = weaponCargo _x;
	private _backpackMagazines = magazineCargo _x;
	private _backpackDescription = typeOf _x;
	_backpacks = _backpacks + [[_backpackDescription, _backpackMagazines, _backpackWeapons, _backpackItems]];
} forEach everyBackpack _veh;
private _magazines = magazineCargo _veh;
private _weapons = weaponCargo _veh;
private _items = itemCargo _veh;
private _damageArray = getAllHitPointsDamage _veh;
private _damage = [];
{
	private _thisDamage = [_x, ((_damageArray select 2) select _forEachIndex)];
		_damage pushBack _thisDamage;
} forEach (_damageArray select 0);
private _vehicleArray = [_vehicleType, _position, _direction, _fuel,_magazines, _weapons, _items, _backpacks, _damage];
pms_vehicles pushBack _vehicleArray;