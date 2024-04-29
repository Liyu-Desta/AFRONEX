class Note {
  late String id;
  late String title;
  late String description;
  late String userId;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': description,
      'userId': userId,
    };
  }
}
