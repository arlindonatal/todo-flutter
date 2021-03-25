import 'package:dartz/dartz.dart';
import 'package:todo/app/core/error/failure.dart';
import 'package:todo/app/core/usecases/usecase.dart';
import 'package:todo/app/domain/entities/todo.dart';
import 'package:todo/app/domain/repositories/todo_repository.dart';

class GetAllTodo implements UseCase<List<Todo>, NoParams> {

  final TodoRepository repository;

  GetAllTodo(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getAll();
  }
}