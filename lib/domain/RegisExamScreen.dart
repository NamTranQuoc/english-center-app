class RegisExam {
  final String? id;
  final int? startTime;
  final int? endTime;
  final String? code;
  final int? maxQuantity;
  final int? minQuantity;

  RegisExam(
      {this.id,
      this.startTime,
      this.endTime,
      this.code,
      this.maxQuantity,
      this.minQuantity});

  factory RegisExam.fromJson(Map<String, dynamic> json) {
    return RegisExam(
      id: json['_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      code: json['code'],
      maxQuantity: json['max_quantity'],
      minQuantity: json['min_quantity'],
    );
  }
}
