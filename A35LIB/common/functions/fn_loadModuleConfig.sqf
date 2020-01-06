params ["_module"];

call compile preprocessFileLineNumbers (A35LIB_PATH+(str _module)+"\config.sqf");