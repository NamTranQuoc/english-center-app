
import 'package:english_center/domain/Member.dart';
import 'package:english_center/domain/Schedule.dart';
import 'package:flutter/foundation.dart';

class ScheduleProvider extends ChangeNotifier {
  late Map<String, List<Schedule>> _schedules = <String, List<Schedule>>{};

  Map<String, List<Schedule>> get schedules => _schedules;

  void set(Map<String, List<Schedule>> schedule) {
    _schedules = schedule;

    notifyListeners();
  }

  void putIfAbsent(key, value) {
    _schedules.putIfAbsent(key, () => value);
  }
}
