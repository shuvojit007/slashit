// Package imports:
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
