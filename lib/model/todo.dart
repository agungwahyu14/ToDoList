import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Excercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Gorceries', isDone: true),
      ToDo(id: '03', todoText: 'Morning Excercise'),
      ToDo(id: '04', todoText: 'Check Email'),
      ToDo(id: '05', todoText: 'Morning Cofee'),
      ToDo(id: '06', todoText: 'Team Meeting'),
      ToDo(id: '07', todoText: 'Working at 9am to 5pm'),
      ToDo(id: '09', todoText: 'Collage Class'),
      ToDo(id: '10', todoText: 'Have Dinner with My Mom'),
    ];
  }
}
