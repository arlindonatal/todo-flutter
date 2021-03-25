import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/app/core/error/failure.dart';
import 'package:todo/app/core/usecases/usecase.dart';
import 'package:todo/app/domain/entities/todo.dart';
import 'package:todo/app/domain/repositories/todo_repository.dart';

class GetTodo implements UseCase<Todo, Params> {

  final TodoRepository repository;

  GetTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params params) async {
    return await repository.getOne(params.id);
  }
}

class Params extends Equatable {
  final int id;
  Params({@required this.id});
  @override
  List<Object> get props => [id];
}