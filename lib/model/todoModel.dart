class TodoModel {
  int? id;
  String? title;
  bool? completed;

  TodoModel({this.title, this.completed = false,required this.id});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['todo'];
    completed = json['completed'];
  }
}