
class Response {
  final int? code;
  final String? message;
  final dynamic payload;

  const Response({this.code, this.message, this.payload});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      code: json['code'],
      message: json['message'],
      payload: json['payload'],
    );
  }
}
