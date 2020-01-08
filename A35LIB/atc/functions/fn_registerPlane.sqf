params ["_newPlane", "_callsign"];

// get value
_registeredPlanes = ["A35LIB_atc_registeredPlanes", []] call A35LIB_common_getVariableInDatastore;

// modify value
_newPlane setVariable ["A35LIB_atc_callsign", _callsign];

// enhance/append value
_registeredPlanes append [_newPlane];

// save value
["A35LIB_atc_registeredPlanes", _registeredPlanes] call A35LIB_common_setVariableInDatastore;