// Dart imports:
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_event.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_state.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/utils/prefmanager.dart';

class WalletBloc extends Bloc<WalletBlocEvent, WalletBlocState> {
  @override
  WalletBlocState get initialState => InitialWalletBlocState();

  @override
  Stream<WalletBlocState> mapEventToState(
    WalletBlocEvent event,
  ) async* {
    if (event is GetWallet) {
      yield WalletBlocLoading();
      yield WalletBlocLoaded(locator<PrefManager>().availableBalance);
    } else if (event is UpdateWallet) {
      yield WalletBlocLoading();
      yield WalletBlocLoaded(locator<PrefManager>().availableBalance);
    }
  }
}
