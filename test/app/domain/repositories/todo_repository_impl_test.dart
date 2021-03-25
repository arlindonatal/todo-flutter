
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/app/core/error/exceptions.dart';
import 'package:todo/app/core/error/failure.dart';
import 'package:todo/app/core/network/network_info.dart';
import 'package:todo/app/data/datasources/todo_local_data_source.dart';
import 'package:todo/app/data/datasources/todo_remote_data_source.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/app/data/repositories/todo_repository_impl.dart';
import 'package:todo/app/domain/entities/todo.dart';

class MockRemoteDataSource extends Mock implements TodoRemoteDataSource {}

class MockLocalDataSource extends Mock implements TodoLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {

  TodoRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TodoRepositoryImpl(
      remoteDataSource : mockRemoteDataSource,
      localDataSource : mockLocalDataSource,
      networkInfo : mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body){
    group('device is online', (){
        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });   

        body(); 
    });
  }

  void runTestsOffline(Function body){
    group('device is offline', (){
        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });   

        body(); 
    });
  }  

  group('getTodo', (){

    final idTodo = 1;
    final todoModel = TodoModel(id: idTodo, title: 'Title', description: 'Description');
    final Todo todo = todoModel;

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getOne(idTodo);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline((){

      test('should return remote data when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getOne(any)).thenAnswer((_) async => todoModel);
        //act
        final result = await repository.getOne(idTodo);
        //assert
        verify(mockRemoteDataSource.getOne(idTodo));
        expect(result, equals(Right(todo)));
      });

      test('should cache data locally when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.getOne(any)).thenAnswer((_) async => todoModel);
        //act
        await repository.getOne(idTodo);
        //assert
        verify(mockRemoteDataSource.getOne(idTodo));
        verify(mockLocalDataSource.cacheOne(todoModel));
      });   

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        //arrange
        when(mockRemoteDataSource.getOne(any)).thenThrow(ServerException());
        //act
        final result = await repository.getOne(idTodo);
        //assert
        verify(mockRemoteDataSource.getOne(idTodo));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });         
          
    });

    runTestsOffline((){

      test('should return last locally data when cached data is present', () async {
        //arrange
        when(mockLocalDataSource.getCacheOne(idTodo)).thenAnswer((_) async => todoModel);
        //act
        final result = await repository.getOne(idTodo);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCacheOne(idTodo));
        expect(result, equals(Right(todoModel)));
      });

      test('should return CacheFailure failure when there is no cache data present', () async {
        //arrange
        when(mockLocalDataSource.getCacheOne(any)).thenThrow(CacheException());
        //act
        final result = await repository.getOne(idTodo);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCacheOne(idTodo));
        expect(result, equals(Left(CacheFailure())));
      });      
    });

  });

}

