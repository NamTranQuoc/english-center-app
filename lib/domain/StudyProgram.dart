
class StudyProgram {
  final String? name;
  final String? id;
  final String? status;
  final String? description;
  final int? createDate;


  StudyProgram({
    this.name,
    this.id,
    this.status,
    this.description,
    this.createDate,
  });

  factory StudyProgram.fromJson(Map<String, dynamic> json) {
    return StudyProgram(
        name: json['name'],
        id: json['_id'],
        status: json['status'],
        description: json['description'],
        createDate: json['create_date'],
    );
  }
}
