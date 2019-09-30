import 'package:flutter/widgets.dart';

class ThemeProvide with ChangeNotifier {
  Color _themeColor;

  ThemeProvide();

  Color get themeColor => _themeColor;

  void changeThemeColor(Color themeColor) {
    this._themeColor = themeColor;
    notifyListeners();
  }
}
