
class Schedule {
  final String? title;
  final String? id;
  final String? teacher;
  final String? room;
  final int? start;
  final int? end;
  final int? session;
  final String? courseId;
  final int? maxStudent;
  final bool? tookPlace;
  final String? classroomId;
  final bool? isAbsent;


  Schedule({
      this.title,
      this.id,
      this.teacher,
      this.room,
      this.start,
      this.end,
      this.session,
      this.courseId,
      this.maxStudent,
      this.tookPlace,
      this.classroomId,
      this.isAbsent});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        title: json['title'],
        id: json['id'],
        teacher: json['teacher'],
        room: json['room'],
        start: json['start'],
        end: json['end'],
        session: json['session'],
        courseId: json['course_id'],
        maxStudent: json['maxStudent'],
        tookPlace: json['took_place'],
        classroomId: json['classroom_id'],
        isAbsent: json['is_absent']);
  }
}
