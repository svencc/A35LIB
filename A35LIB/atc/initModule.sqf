// ----------------------------------------------------------------------------
// PLANES
// ----------------------------------------------------------------------------
// Find planes
_allPlanes = entities "Plane";
_atcManagedPlanes = [_allPlanes, {!isNil{_x getVariable "A3LIB_atc_jet"}}] call BIS_fnc_conditionalSelect;

// Register planes
{[_x, _x getVariable "A3LIB_atc_jet"] call A35LIB_atc_registerPlane;} foreach(_atcManagedPlanes);



// ----------------------------------------------------------------------------
// TAXIS
// ----------------------------------------------------------------------------
// Find taxis
_allUgvs = entities "B_UGV_01_F";
_atcManagedTaxiOutPlatforms = [_allUgvs, {!isNil{_x getVariable "A3LIB_atc_taxi-out"}}] call BIS_fnc_conditionalSelect;
_atcManagedTaxiInPlatforms = [_allUgvs, {!isNil{_x getVariable "A3LIB_atc_taxi-in"}}] call BIS_fnc_conditionalSelect;

// Register taxis
{[_x, _x getVariable "A3LIB_atc_taxi-out"] call A35LIB_atc_registerPlane;} foreach(_atcManagedTaxiOutPlatforms);
{[_x, _x getVariable "A3LIB_atc_taxi-in"] call A35LIB_atc_registerPlane;} foreach(_atcManagedTaxiInPlatforms);