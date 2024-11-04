class Tip {
  int id;
  String? text;
  String? author;
  List<int> upvotes;
  List<String> downvotes;

  Tip({
    required this.id,
    this.text,
    this.author,
    this.upvotes = const [],
    this.downvotes = const [],
  });

  factory Tip.fromJson(Map<String, dynamic> json) => Tip(
      id: json['id'],
      text: json['text'] as String?,
      author: json['author'] as String?,
      upvotes: List<int>.from(json['upvotes'] ?? []),
      downvotes: List<String>.from(json['downvotes'] ?? []));

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'author': author,
        'upvotes': upvotes,
        'downvotes': downvotes,
      };
}
