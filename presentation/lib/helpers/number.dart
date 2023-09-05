parseNumber(dynamic value) {
  if (value == '') return 0;
  if (value.runtimeType == String) return int.parse(value);
  return value as int;
}
