import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/app/core/usecases/usecase.dart';
import 'package:todo/app/domain/entities/todo.dart';
import 'package:todo/app/domain/repositories/todo_repository.dart';
import 'package:todo/app/domain/usecases/get_all_todo.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  TodoRepository repository;
  GetAllTodo usecase;

  setUp(() {
    repository = MockTodoRepository();
    usecase = GetAllTodo(repository);
  });

  final todos = [
    Todo(
    id: 1,
    title: 'Todo 1',
    description: 'Description',
    date: DateTime.now(),
    done: false,
  ), 
  Todo(
    id: 2,
    title: 'Todo 1',
    description: 'Description',
    date: DateTime.now(),
    done: true,
  )];

  test('should return all todos', () async {
    //arrange
    when(repository.getAll()).thenAnswer((_) async => Right(todos));
    //acts
    final result = await usecase(NoParams());
    //asserts
    expect(result, Right(todos)); 
    verify(repository.getAll());
    verifyNoMoreInteractions(repository);
  });
}
