params ["_module"];

call compile preprocessFileLineNumbers (A35LIB_PATH+(str _module)+"\config.sqf");
call compile preprocessFileLineNumbers (A35LIB_PATH+(str _module)+"\config_user.sqf");