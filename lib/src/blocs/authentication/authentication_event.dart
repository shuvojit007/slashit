// Package imports:
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoggedIn extends AuthenticationEvent {

  @override
  String toString() => 'LoggedIn ';
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
