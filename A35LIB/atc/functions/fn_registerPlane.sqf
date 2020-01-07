params ["_newPlane", "_callsign"];

// get value
_registeredPlanes = ["A35LIB_atc_registeredPlanes", [], A35LIB_ATC_ENTITY] call A35LIB_common_getVariable;

// modify value
_newPlane setVariable ["A35LIB_atc_callsign", _callsign];

// enhance/append value
_registeredPlanes append [_newPlane];

// save value
["A35LIB_atc_registeredPlanes", _registeredPlanes, A35LIB_ATC_ENTITY] call A35LIB_common_setVariable;