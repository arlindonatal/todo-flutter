import 'package:flutter/widgets.dart';
import 'package:todo/app/domain/entities/todo.dart';

class TodoModel extends Todo {

  TodoModel({
    @required int id,
    @required String title,
    @required String description,
    DateTime date,
    bool done = false,
  }) : super(
          id: id,
          title: title,
          description: description,
          date: date,
          done: done,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'].toString().isNotEmpty ? DateTime.parse(json['date']) : null,
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['done'] = this.done;
    return data;
  }
}
