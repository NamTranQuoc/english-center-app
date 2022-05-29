class Course {
  final String? name;
  final String? id;
  final int? tuition;
  final int? numberOfShift;
  final String? description;
  final String? categoryCourseId;
  final int? createDate;
  final int? inputScore;
  final int? outputScore;
  final String? status;
  final int? numberOfClass;

  Course({
    this.name,
    this.id,
    this.tuition,
    this.numberOfShift,
    this.description,
    this.categoryCourseId,
    this.createDate,
    this.inputScore,
    this.outputScore,
    this.status,
    this.numberOfClass,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      id: json['_id'],
      tuition: json['tuition'],
      numberOfShift: json['number_of_shift'],
      description: json['description'],
      categoryCourseId: json['category_course_id'],
      createDate: json['create_date'],
      inputScore: json['input_score'],
      outputScore: json['output_score'],
      status: json['status'],
      numberOfClass: json['number_of_class'],
    );
  }
}
