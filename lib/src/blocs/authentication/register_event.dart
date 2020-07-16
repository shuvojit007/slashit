// Package imports:
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super();
}

 class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String name;

  Submitted({@required this.email, @required this.password,@required this.name,})
      : super([email, password,name]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

 class RegisterWithGooglePressed extends RegisterEvent {
  @override
  String toString() => 'RegisterWithGooglePressed';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

 class RegisterWithApplePressed extends RegisterEvent {
  @override
  String toString() => 'RegisterWithApplePressed';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

 class RegisterWithFaceBookPressed extends RegisterEvent {
  @override
  String toString() => 'RegisterWithFaceBookPressed';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
