// ----------------------------------------------------------------------------
// BOOTSTRAP HELPER
// ----------------------------------------------------------------------------
A35LIB_fnc_findLib = {
	_allLogics = entities "Logic";
	_A35LIB = [_allLogics, {!isNil{_x getVariable "A35LIB"}}] call BIS_fnc_conditionalSelect;
	if (count _A35LIB > 0) exitWith {
		_A35LIB select 0;
	};
};

A35LIB_fnc_findModules = {
	_allLogics = entities "Logic";
	_A35LIBmodules = [_allLogics, {!isNil{_x getVariable "A35LIB_module"}}] call BIS_fnc_conditionalSelect;
	_A35LIBmodules;
};

A35LIB_fnc_findModule = {
	params ["_moduleName"];
	_allModules = call A35LIB_fnc_findModules;
	_module = [_allModules, { (_x getVariable "A35LIB_module") == _moduleName}] call BIS_fnc_conditionalSelect;
	if (!isNil "_module" and count _module == 1 ) exitWith {
		_module select 0;
	};
};

A35LIB_fnc_compile = {
	// REGISTER MODULE FUNCTIONS
	{ call compile preprocessFileLineNumbers (A35LIB_PATH+(str _x)+"\registerFunctions.sqf");
	} forEach (A35LIB_MODULES);
	// INIT MODULES
	{ call compile preprocessFileLineNumbers (A35LIB_PATH+(str _x)+"\initModule.sqf");
	} forEach (A35LIB_MODULES);
};

A35LIB_fnc_resetData = {
	{A35LIB_ENTITY setVariable [str _x, nil]} forEach (allVariables A35LIB_ENTITY);
};
// ----------------------------------------------------------------------------





// CONSTANTS
A35LIB_DEBUG = true; // @TODO: Put this into config!
A35LIB_PATH; // Is set outside of A35LIB on mission/server level (init.sqf or serverInit.sqf)
A35LIB_ENTITY = call A35LIB_fnc_findLib;
A35LIB_MODULES = call A35LIB_fnc_findModules;

// RESET DATA
//call A35LIB_fnc_resetData;

// COMPILE A35LIB
call A35LIB_fnc_compile;




// @TODO: just add common module here in script, so you dont need to setup in editor!
// @TODO: Add config system