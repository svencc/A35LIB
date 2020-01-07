params ["_runwayId","_callsign","_plane"];
hint "drin";
_taxi = _plane getVariable "A35LIB_atc_currentTaxi";

sleep CONF_A35LIB_ATC_ENGINE_FLIGHTPREPARATION_DEFAULT_TIME;

_taxi enableSimulation false;

_plane allowDamage false;
_plane enableSimulation false;

detach _plane;

_taxi setVehiclePosition[[0,0,0],[],0,"NONE"];
deleteVehicle _taxi;

_plane enableSimulation true;
_plane allowDamage true;

hint "durch";