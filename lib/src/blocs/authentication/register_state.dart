// Package imports:
import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;



  RegisterState({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }



  @override
  String toString() {
    return '''RegisterState {
    
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
