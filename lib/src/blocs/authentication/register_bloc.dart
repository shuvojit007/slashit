// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password, event.name);
    }

    else if (event is RegisterWithFaceBookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    }

    else if (event is RegisterWithApplePressed) {
      yield* _mapLoginWithApplePressedToState();
    }

    else if (event is RegisterWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
    String name,
  ) async* {
    yield RegisterState.loading();
    try {


      yield RegisterState.success();
    } catch (_) {
      print("Register Error");
      yield RegisterState.failure();
    }
  }

  Stream<RegisterState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield RegisterState.loading();

      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
  Stream<RegisterState> _mapLoginWithApplePressedToState() async* {
    try {
      yield RegisterState.loading();

      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }

  Stream<RegisterState> _mapLoginWithFacebookPressedToState() async* {
    try {
      yield RegisterState.loading();

      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
