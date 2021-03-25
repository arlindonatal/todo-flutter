import 'package:flutter/widgets.dart';
import 'package:todo/app/core/error/exceptions.dart';
import 'package:todo/app/core/network/network_info.dart';
import 'package:todo/app/data/datasources/todo_local_data_source.dart';
import 'package:todo/app/data/datasources/todo_remote_data_source.dart';
import 'package:todo/app/domain/entities/todo.dart';
import 'package:todo/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Todo>> getOne(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTodo = await remoteDataSource.getOne(id);
        localDataSource.cacheOne(remoteTodo);
        return Right(remoteTodo);
      } on ServerException {
        return Left(ServerFailure());
      }    
    } else {
      try {
        final localTodo = await localDataSource.getCacheOne(id);
        return Right(localTodo);
      } on CacheException {
        return Left(CacheFailure());
      }      
    }    
  }

  @override
  Future<Either<Failure, List<Todo>>> getAll() {
    return null;
  }

  @override
  Future<Either<Failure, Todo>> delete(Todo todo) {
    return null;
  }

  @override
  Future<Either<Failure, Todo>> save(Todo todo) {
    return null;
  }
}
