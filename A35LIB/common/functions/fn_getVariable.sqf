params ["_key", "_default"];

if (isNil {A35LIB_ENTITY getVariable _key} and (!isNil "_default")
) exitWith {
  [_key, _default] call A35LIB_common_setVariable;
  _default;
};

if (isNil {A35LIB_ENTITY getVariable _key} and (isNil "_default")
) exitWith {
  nil
};

if (!isNil {A35LIB_ENTITY getVariable _key}) exitWith {
  A35LIB_ENTITY getVariable _key;
};