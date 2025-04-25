class TodoModel {
  final int? id;
  final String title;
  final bool completed;

  TodoModel({this.id, required this.title, this.completed = false});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    if (id != null) map['id'] = id;

    map['title'] = title;
    map['completed'] = completed;

    return map;
  }
}
