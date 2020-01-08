params ["_runwayId","_callsign","_objectsInTrigger"];

// @INFO: SUPPORT Helos -> filter by type "Helicopter" or parent "Air"
// @TODO -> add state of AIR unit (taxi-out; taxi-in; in-air; patrol; show-force; attack-run; ...)
{
	if ( (_x isKindOf "Plane") ) then {
		if ( !isNil {_x getVariable "A35LIB_atc_planeInstanceFrom"} ) then {
			[_runwayId, _callsign, _x] call A35LIB_atc_prepareTakeoffPlane;
		};
	};
} forEach (_objectsInTrigger);