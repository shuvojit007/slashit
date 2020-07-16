// Dart imports:
import 'dart:async';

import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    print("Auth event ${event}");
    if (event is AppStarted) {
      yield AuthenticationLoading();
//      final bool flag = await UserRepository.instance.isSignedIn();
//
//      print("Auth status ${flag}");
//      if (flag) {
//        yield AuthenticationAuthenticated();
//      } else {
//        yield AuthenticationUnauthenticated();
//      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
//      final bool flag = await UserRepository.instance.isSignedIn();
//      if (flag) {
//        yield AuthenticationAuthenticated();
//      } else {
//        yield AuthenticationUnauthenticated();
//      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      yield AuthenticationUnauthenticated();
    }
  }
}
