class StudyProgram {
  final String? name;
  final String? id;
  final String? status;
  final String? description;
  final int? createDate;
  final int? numberOfCourse;
  final String? image;

  StudyProgram(
      {this.name,
      this.id,
      this.status,
      this.description,
      this.createDate,
      this.numberOfCourse,
      this.image});

  factory StudyProgram.fromJson(Map<String, dynamic> json) {
    return StudyProgram(
      name: json['name'],
      id: json['_id'],
      status: json['status'],
      description: json['description'],
      createDate: json['create_date'],
      numberOfCourse: json['number_of_course'],
      image: json['image'],
    );
  }
}
