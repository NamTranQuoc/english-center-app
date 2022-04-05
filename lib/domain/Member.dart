
class Member {
  final String? id;
  final String? name;
  final String? avatar;

  const Member({this.id, this.name, this.avatar});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
