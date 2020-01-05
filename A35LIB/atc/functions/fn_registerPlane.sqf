params ["_newPlane", "_callsign"];

// get value
_registeredPlanes = ["atc_registeredPlanes", []] call A35LIB_common_getVariable;

// modify value
_newPlane setVariable ["A35LIB_atc_callsign", _callsign];

// append value
_registeredPlanes append [_newPlane];
// save value
["atc_registeredPlanes", _registeredPlanes] call A35LIB_common_setVariable;