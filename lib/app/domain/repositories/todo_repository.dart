import 'package:dartz/dartz.dart';
import 'package:todo/app/core/error/failure.dart';
import 'package:todo/app/domain/entities/todo.dart';

abstract class TodoRepository {

  Future<Either<Failure, Todo>> save(Todo todo);
  Future<Either<Failure, Todo>> delete(Todo todo);
  Future<Either<Failure, Todo>> getOne(int id);
  Future<Either<Failure, List<Todo>>> getAll();

}