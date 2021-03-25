import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/app/domain/entities/todo.dart';
import 'package:todo/app/domain/repositories/todo_repository.dart';
import 'package:todo/app/domain/usecases/get_todo.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  TodoRepository repository;
  GetTodo usecase;

  setUp(() {
    repository = MockTodoRepository();
    usecase = GetTodo(repository);
  });

  final todo = Todo(
    id: 1,
    title: 'Todo',
    description: 'Description',
    date: DateTime.now(),
    done: false,
  );

  test('should return an entity todo', () async {
    //arrange
    when(repository.getOne(any)).thenAnswer((_) async => Right(todo));
    //acts
    final result = await usecase(Params(id : 1));
    //asserts
    expect(result, Right(todo));
    verify(repository.getOne(1));
    verifyNoMoreInteractions(repository);
  });
}
