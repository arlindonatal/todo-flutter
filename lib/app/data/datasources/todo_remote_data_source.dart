import 'package:todo/app/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {

  Future<TodoModel> save(TodoModel todo);
  Future<void> delete(int id);
  Future<TodoModel> getOne(int id);
  Future<List<TodoModel>> getAll();  

}