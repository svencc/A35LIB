params ["_key", "_default", "_useModule"];

_module = A35LIB_ENTITY;

if (!isNil "_useModule") then {
  _module = _useModule;
};

if (isNil {_module getVariable _key} and (!isNil "_default")
) exitWith {
  [_key, _default] call A35LIB_common_setVariable;
  _default;
};

if (isNil {_module getVariable _key} and (isNil "_default")
) exitWith {
  nil
};

if (!isNil {_module getVariable _key}) exitWith {
  _module getVariable _key;
};