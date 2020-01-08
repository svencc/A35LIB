params ["_newTaxi", "_callsign"];

// get value
_registeredTaxis = ["A35LIB_atc_registered_taxis_in", []] call A35LIB_common_getVariableInDatastore;

// modify value
_newTaxi setVariable ["A35LIB_atc_callsign", _callsign];

// enhance/append value
_registeredTaxis append [_newTaxi];

// save value
["A35LIB_atc_registered_taxis_in", _registeredTaxis] call A35LIB_common_setVariableInDatastore;