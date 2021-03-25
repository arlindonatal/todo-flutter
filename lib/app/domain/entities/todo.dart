import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todo extends Equatable {
  
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool done;

  Todo({
    @required this.id,
    @required this.title,
    @required this.description,
    this.date,
    this.done = false,
  });

  @override
  List<Object> get props => [id, title];

}