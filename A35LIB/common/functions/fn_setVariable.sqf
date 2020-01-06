params ["_key", "_value", "_useModule"];

_module = A35LIB_ENTITY;

if (!isNil "_useModule") then {
  _module = _useModule;
};

_module setVariable [_key, _value];