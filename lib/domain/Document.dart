class DocumentDomain {
  final String? name;
  final String? id;
  final String? type;
  final String? path;
  final List<dynamic>? courses;

  DocumentDomain({
    this.name,
    this.id,
    this.type,
    this.path,
    this.courses,
  });

  factory DocumentDomain.fromJson(Map<String, dynamic> json) {
    return DocumentDomain(
      name: json['name'],
      id: json['_id'],
      type: json['type'],
      path: json['path'],
      courses: json['course_ids'],
    );
  }
}