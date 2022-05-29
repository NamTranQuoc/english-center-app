class Classroom {
  final String? name;
  final String? id;
  final int? maxStudent;
  final int? minStudent;
  final String? courseId;
  final String? shiftId;
  final int? startDate;
  final List<dynamic>? dow;

  Classroom({
    this.name,
    this.id,
    this.maxStudent,
    this.minStudent,
    this.courseId,
    this.shiftId,
    this.startDate,
    this.dow,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      name: json['name'],
      id: json['_id'],
      maxStudent: json['max_student'],
      minStudent: json['min_student'],
      courseId: json['course_id'],
      shiftId: json['shift_id'],
      startDate: json['start_date'],
      dow: json['dow'],
    );
  }
}
