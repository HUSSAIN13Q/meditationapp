class Exercise {
  final int id;
  final String title;
  final String file;
  final bool finished;

  Exercise(
      {required this.id,
      required this.title,
      required this.file,
      required this.finished});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      title: json['title'],
      file: json['file'],
      finished: json['finished'],
    );
  }
}
