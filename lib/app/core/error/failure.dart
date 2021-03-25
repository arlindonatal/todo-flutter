import 'package:equatable/equatable.dart';

class Failure extends Equatable{

  final List<dynamic> properties;
  Failure([this.properties = const<dynamic>[]]);

  @override
  List<Object> get props => [...properties];

}

class ServerFailure extends Failure {
  ServerFailure([String properties = '']) : super([properties]);
}

class CacheFailure extends Failure {
  CacheFailure([String properties = '']) : super([properties]);  
}