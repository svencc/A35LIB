params ["_message"];

if (!isNil "A35LIB_DEBUG") exitWith {
  hint str _message;
  nil;
};