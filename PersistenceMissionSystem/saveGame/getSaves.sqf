
private _saveGames = profileNameSpace getVariable ["pms_saveGames",[]];
missionNameSpace setVariable ["pms_currentSaveGames",_saveGames,true];
missionNameSpace setVariable ["pms_currentSaveGamesLoaded",true,true];