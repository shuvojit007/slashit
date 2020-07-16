// Dart imports:
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slashit/src/utils/validators.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.empty();

//  @override
//  Stream<LoginState> transformEvents(
//    Stream<LoginEvent> events,
//    Stream<LoginState> Function(LoginEvent event) next,
//  ) {
//    final observableStream = events as Stream<LoginEvent>;
//    final nonDebounceStream = observableStream.where((event) {
//      return (event is! EmailChanged && event is! PasswordChanged);
//    });
//    final debounceStream = observableStream.where((event) {
//      return (event is EmailChanged || event is PasswordChanged);
//    }).debounceTime(Duration(milliseconds: 300));
//    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
//  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithApplePressed) {
      yield* _mapLoginWithApplePressedToState();
    } else if (event is LoginWithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield LoginState.loading();

      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithApplePressedToState() async* {
    try {
      yield LoginState.loading();

      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    try {
      yield LoginState.loading();

      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      print("OneSignal Init ${email}");
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
