params ["_runwayId","_callsign","_objectsInTrigger"];

// @INFO: SUPPORT Helos -> filter by type "Helicopter" or parent "Air"
// @TODO -> add state of AIR unit (taxi-out; taxi-in; in-air; patrol; show-force; attack-run; ...)

{
	if ( (_x isKindOf "Plane") and (!isNil {_x getVariable "A35LIB_atc_planeInstanceFrom"}) ) then {
		hint "prepare";
		_taxi = _x getVariable "A35LIB_atc_currentTaxi";

		// @TODO vielleicht hier den atc informieren, so das er steuert wann es los geht!
		// @TODO REFACTOR to new function, which gets called by ATC
		sleep 30;

		_taxi enableSimulation false;

		_x allowDamage false;
		_x enableSimulation false;

		detach _x;

		_taxi setVehiclePosition[[0,0,0],[],0,"NONE"];
		deleteVehicle _taxi;

		hint "start";

		_x enableSimulation true;
		_x allowDamage true;
	};
} forEach (_objectsInTrigger);