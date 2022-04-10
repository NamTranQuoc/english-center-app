
import 'package:english_center/domain/Member.dart';
import 'package:flutter/foundation.dart';

class MemberProvider extends ChangeNotifier {
  late Member _currentMember = Member.fromJson({});

  Member get currentMember => _currentMember;

  void set(Member member) {
    _currentMember = member;

    notifyListeners();
  }
}
