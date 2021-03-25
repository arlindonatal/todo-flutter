import 'package:todo/app/data/models/todo_model.dart';

abstract class TodoLocalDataSource {

  Future<void> cacheOne(TodoModel todo);
  Future<void> cacheAll(List<TodoModel> todos);
  Future<void> deleteCache(int id);
  Future<TodoModel> getCacheOne(int id);
  Future<List<TodoModel>> getCacheAll();

}