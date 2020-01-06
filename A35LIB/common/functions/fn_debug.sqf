params ["_message"];

if (!isNil "A35LIB_DEBUG") exitWith {
  hint str _message;
  //[[{hint str _message}],"BIS_fnc_Spawn",true] call BIS_fnc_MP;
  nil;
};