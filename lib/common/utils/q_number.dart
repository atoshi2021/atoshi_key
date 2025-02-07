int getLevel({bool? hasCaps, bool? hasLower, bool? hasNum, bool? hasSymbol}) {
  int level = 0;
  if (hasCaps ?? false) {
    level += 1;
  }
  if (hasLower ?? false) {
    level += 1;
  }
  if (hasNum ?? false) {
    level += 1;
  }
  if (hasSymbol ?? false) {
    level += 1;
  }
  return level;
}

int getNumberLevel({required String password}) {
  bool hasCaps = password.toLowerCase() != password;
  bool hasLower = password.toUpperCase() != password;
  bool hasNum = _hasNumber(password);
  bool hasSymbol = _hasSymbol(password);
  return getLevel(
      hasCaps: hasCaps,
      hasLower: hasLower,
      hasNum: hasNum,
      hasSymbol: hasSymbol);
}

bool _hasSymbol(String password) {
  RegExp exp = RegExp(r'[～！…¥（），。？"：—…~!@#$%^&*()_+=-[]}{;/://.,<>?`\|]');
  return exp.hasMatch(password);
}

bool _hasNumber(String password) {
  RegExp exp = RegExp(r'[0123456789]');
  return exp.hasMatch(password);
}
