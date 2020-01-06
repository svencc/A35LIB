params ["_callsign"];

if (isNil{_callsign}) exitWith {
  ["1578256676: _callsign is empty"] call A35LIB_common_debug;
  false;
};


// ----------------------------------------------------------------------------
// PREPARE
// ----------------------------------------------------------------------------

// Find all registed taxis
_registeredTaxis = ["atc_registered_taxis_out", []] call A35LIB_common_getVariable;
// Find taxi with given callsign
_taxis = [_registeredTaxis, {(_x getVariable "atc_callsign") == _callsign;}] call BIS_fnc_conditionalSelect;

if (count _taxis != 1) exitWith {
  ["1578256721: taxis found ("+(str count _taxis)+")"] call A35LIB_common_debug;
  false;
};

_taxiTemplate = _taxis select 0;



// Find all registed planes
_registeredPlanes = ["atc_registeredPlanes", []] call A35LIB_common_getVariable;
// Find taxi with given callsign
_planeTemplates = [_registeredPlanes, {(_x getVariable "atc_callsign") == _callsign;}] call BIS_fnc_conditionalSelect;

if (count _planeTemplates != 1) exitWith {
  ["1578257578: planes found ("+(str count _taxis)+")"] call A35LIB_common_debug;
  false;
};

_planeTemplate = _planeTemplates select 0;
_planeTemplate_taxi_speed = _planeTemplate getVariable ["A35LIB_atc_jet_taxi_speed", 5];
_planeTemplate_taxi_offset = _planeTemplate getVariable ["A35LIB_atc_jet_taxi_offset", [0,0,0.6]];



// ----------------------------------------------------------------------------
// CREATE INSTANCES
// ----------------------------------------------------------------------------

// Create plane instance using template
_planeInstance = createVehicle [typeOf _planeTemplate,position _planeTemplate,[],0,"CAN_COLLIDE"];
[
	_planeInstance,
	["Green",1], 
	true
] call BIS_fnc_initVehicle;

_planeInstance setDir (getDir _planeTemplate);

// Set Dynamic Loadout
private _pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonMissile_1Rnd_BombCluster_03_F","PylonWeapon_300Rnd_20mm_shells","PylonMissile_1Rnd_BombCluster_03_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_1Rnd_Missile_AA_04_F"];
private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _planeInstance >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
{ _planeInstance removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _planeInstance;
{ _planeInstance setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;

// Disable Simulation for plane
_planeInstance allowDamage false;
_planeTemplate enableSimulation false; // enableSimulationGlobal in MP!




// Link instances into plane
_taxiInstance = createVehicle [typeOf _taxiTemplate,position _planeTemplate,[],0,"CAN_COLLIDE"];
[
	_taxiInstance,
	["Indep",1], 
	true
] call BIS_fnc_initVehicle;
_taxiInstance setDir (getDir _planeTemplate);

createVehicleCrew  _taxiInstance; // set a drev to vehicle, to enable ability to drive!

// Make the taxi invisible and still responsive. 
// Due to that, we have to get rid of the textures of the taxi vehicle.
// Downside to this approach; The shadow is still visible; But I don´t know any other possibility!!!
{
  _taxiInstance setObjectTexture [_forEachIndex,""];   
} forEach(getObjectTextures _taxiInstance); 

_planeInstance attachTo [_taxiInstance,_planeTemplate_taxi_offset]; // @TODO Offset configurable!
_taxiInstance limitSpeed _planeTemplate_taxi_speed;
_taxiInstance disableAI "AUTOCOMBAT";
_taxiInstance disableAI "SUPPRESSION";
_taxiInstance disableAI "CHECKVISIBLE";
_taxiInstance disableAI "COVER";
_taxiInstance disableAI "LIGHTS";
_taxiInstance disableAI "AUTOTARGET";
hint str A35LIB_ATC_OFFICER;
A35LIB_ATC_OFFICER action ["lightOff", _taxiInstance];



// @TODO - REFACTOR
// Connect every instance inside the plane!
_planeInstance setVariable ["A35LIB_atc_plane_template", _planeTemplate];
_planeInstance setVariable ["A35LIB_atc_currentTaxi", _taxiInstance];
_planeInstance setVariable ["A35LIB_atc_currentTaxi_template", _taxiTemplate];




// ----------------------------------------------------------------------------
// SPAWN PILOT
// ----------------------------------------------------------------------------



// @TODO Find marker NEXT to plane!
// @TODO _nextPilotSpawnMaker has to be max 10! BIS_fnc_sortBy only support max 10 entries!!! So check before!!!!

_pilotSpawnMakers = ["A35LIB_atc_pilotSpawnMarkers",[], A35LIB_ATC_ENTITY] call A35LIB_common_getVariable;
if (count _pilotSpawnMakers > 10) exitWith {
  ["1578306604: A35LIB_atc_pilotsSpawnMarker max 10 entries! Found: "+str(count _pilotSpawnMakers)] call A35LIB_common_debug;
  false;
};

if (count _pilotSpawnMakers < 1) exitWith {
  ["1578306604: A35LIB_atc_pilotsSpawnMarker min 1 entrie! Found: "+str(count _pilotSpawnMakers)] call A35LIB_common_debug;
  false;
};

_nextPilotSpawnMaker = ([_pilotSpawnMakers, [_planeTemplate], {(getMarkerPos _x ) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy) select 0;



// Spawn pilot and let mount him the the plane
_grp = createGroup independent; // @TODO make SIDE configurable
_newPilot = _grp createUnit [typeof (driver _planeTemplate), getMarkerPos _nextPilotSpawnMaker, [_nextPilotSpawnMaker],0,"NONE"];

_newPilot assignAsDriver _planeInstance;
[_newPilot] orderGetIn true;



// ----------------------------------------------------------------------------
// PILOT MOUNT PLANE EVENTHANDLER
// ----------------------------------------------------------------------------

_planeInstance addEventHandler ["GetIn", {
	params ["_plane", "_role", "_unit", "_turret"];
  [_plane, _role, _unit, _turret] spawn getInHandlerScheduled;
}];


getInHandlerScheduled = {
  	params ["_plane", "_role", "_unit", "_turret"];
  
  // @TODO - REFACTOR
  // @TODO - Check Variables!!!!
  _taxiInstance = _plane getVariable "A35LIB_atc_currentTaxi";
  _taxiTemplate = _plane getVariable "A35LIB_atc_currentTaxi_template";

  // Spinning Engines Up
  sleep 10;   // @Todo: Configurable Time Range


  // @TODO: REFACTOR
  // Taxi start follow path
  _taxiInstance setDriveOnPath ((waypoints (group driver _taxiTemplate)) apply {
    waypointPosition _x;
  });
  { _x setWaypointCompletionRadius 1;
  } forEach (waypoints (group driver _taxiInstance));
};


// Und dann kommt der Pilot BIS_fnc_getRespawnPositions
// Und dann gehts Los auf die Runway
// Dort gibts noch einen stopped
// Dann start 

// Dann brauchen wir noch diverse Routen die das Flugzeug dann einnimmt.


// Der ATC muss einen Flugplan haben für Patroullienflüge

// Dann müssen die Flieger auch wieder reinkommen und TAXI-IN machen

// WICHTIGES THEMA - AUFRÄUMEN? Umgang mit kaputten Flugzeugen?
// Registry service aufräumen




// Unterstütze 2 Runways?
// Also 2 Out/In Routen