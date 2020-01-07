params ["_newTaxi", "_callsign"];

// get value
_registeredTaxis = ["A35LIB_atc_registered_taxis_out", [], A35LIB_ATC_ENTITY] call A35LIB_common_getVariable;

// modify value
_newTaxi setVariable ["A35LIB_atc_callsign", _callsign];

// enhance/append value
_registeredTaxis append [_newTaxi];

// save value
["A35LIB_atc_registered_taxis_out", _registeredTaxis, A35LIB_ATC_ENTITY] call A35LIB_common_setVariable;