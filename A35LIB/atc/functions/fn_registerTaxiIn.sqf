params ["_newTaxi", "_callsign"];

// get value
_registeredTaxis = ["atc_registered_taxis_in", []] call A35LIB_common_getVariable;

// modify value
_newTaxi setVariable ["atc_callsign", _callsign];

// enhance/append value
_registeredTaxis append [_newTaxi];

// save value
["atc_registered_taxis_in", _registeredTaxis] call A35LIB_common_setVariable;