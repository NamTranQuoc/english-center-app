class ClassroomAbsent {
  final String? id;
  final String? name;

  const ClassroomAbsent({this.id, this.name});

  factory ClassroomAbsent.fromJson(Map<String, dynamic> json) {
    return ClassroomAbsent(id: json['_id'], name: json['name']);
  }
}
