// Package imports:
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGooglePressed';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginWithFacebookPressed extends LoginEvent {
  @override
  String toString() => 'LoginWithFacebookPressed';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginWithApplePressed extends LoginEvent {
  @override
  String toString() => 'LoginWithApplePressed';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}




class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
