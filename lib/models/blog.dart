class BlogModel {
  final int id;
  final String title;
  final String text;
  final String date;

  BlogModel({
    required this.id,
    required this.title,
    required this.text,
    required this.date
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      date: json['date'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'date':date
    };
  }
}
