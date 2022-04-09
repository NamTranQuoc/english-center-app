
import 'package:flutter/foundation.dart';
import 'package:week3/domain/Member.dart';

class MemberProvider extends ChangeNotifier {
  late Member _currentMember;

  Member get currentMember => _currentMember;

  void set(Member member) {
    _currentMember = member;

    notifyListeners();
  }
}
