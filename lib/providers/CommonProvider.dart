
import 'package:flutter/cupertino.dart';

class CommandProvider extends ChangeNotifier {
  late Locale _currentLocale = const Locale('vi', '');

  Locale get currentLocale => _currentLocale;

  void set(Locale locale) {
    _currentLocale = locale;

    notifyListeners();
  }
}
