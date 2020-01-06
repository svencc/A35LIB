params ["_runwayId","_callsign","_plane"];

if(!(_plane type "Plane")) exitWith {
	nil;
};

_taxi = _plane getVariable "A35LIB_atc_currentTaxi"; // <<< fehler

hint _taxi;

sleep 10;
_taxi enableSimulation false;
_plane allowDamage false;
_plane  enableSimulation false;

detach _plane;

_taxi setVehiclePosition[[0,0,0],[],0,"NONE"];
deleteVehicle _taxi;

hint "start";

_plane enableSimulation true;
_plane allowDamage true;

