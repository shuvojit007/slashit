// Package imports:
import 'package:meta/meta.dart';

@immutable
abstract class WalletBlocEvent {
  WalletBlocEvent([List props = const []]) : super();
}

class GetWallet extends WalletBlocEvent {}

class UpdateWallet extends WalletBlocEvent {
  UpdateWallet();
}
