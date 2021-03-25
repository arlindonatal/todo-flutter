import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/app/domain/entities/todo.dart';

import '../../fixtures/fixture_reader.dart';

main() {

  final todoModel = TodoModel(id: 1, title: 'Todo test', description: 'Description');

  test('should be a subclass of Todo entity', () async {
    expect(todoModel, isA<Todo>());
  });

  group('fromJson', (){
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('todo.json'));
      //act
      final result = TodoModel.fromJson(jsonMap);
      //assert
      expect(result, todoModel);
    });
  });

  group('toJson', (){
    test('should return a JSON map containing the proper date', () async {
      
      final result = todoModel.toJson();

      final expectedMap = {
        "id": 1,
        "title": "Todo test",
        "description": "Description",
        "date": null,
        "done": false 
      };

      expect(result, expectedMap);

    });
  });
  
}