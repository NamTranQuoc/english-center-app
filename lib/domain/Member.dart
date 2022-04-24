class Member {
  final String? id;
  final String? name;
  final String? avatar;
  final String? email;
  final String? phoneNumber;
  final String? note;
  final String? currentScore;
  final String? inScore;
  final String? nickName;
  final String? gender;
  final String? type;
  final int? dob;

  const Member(
      {this.id,
      this.name,
      this.avatar,
      this.email,
      this.phoneNumber,
      this.currentScore,
      this.inScore,
      this.nickName,
      this.note,
      this.gender,
      this.dob,
      this.type});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json['_id'],
        name: json['name'],
        avatar: json['avatar'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        note: json['note'],
        currentScore: json['input_score.total'],
        inScore: json['current_score.total'],
        nickName: json['nick_name'],
        gender: json['gender'],
        dob: json['dob'],
        type: json['type']);
  }
}
