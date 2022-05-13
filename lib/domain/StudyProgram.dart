
class StudyProgram {
  final String? name;
  final String? id;
  final String? status;
  final String? description;
  final int? createDate;
  final int? numberOfCourse;


  StudyProgram({
    this.name,
    this.id,
    this.status,
    this.description,
    this.createDate,
    this.numberOfCourse,
  });

  factory StudyProgram.fromJson(Map<String, dynamic> json) {
    return StudyProgram(
        name: json['name'],
        id: json['_id'],
        status: json['status'],
        description: json['description'],
        createDate: json['create_date'],
        numberOfCourse: json['number_of_course'],
    );
  }
}
