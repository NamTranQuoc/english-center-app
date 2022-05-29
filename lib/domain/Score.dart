class Score {
  Score({this.date, this.total, this.read, this.listen});

  final int? date;
  final double? total;
  final double? read;
  final double? listen;

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      date: json['date'],
      total: json["score"]['total'],
      read: json["score"]['read'],
      listen: json["score"]['listen'],
    );
  }
}
