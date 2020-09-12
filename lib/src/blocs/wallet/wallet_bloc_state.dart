// Package imports:
import 'package:meta/meta.dart';

@immutable
abstract class WalletBlocState {
  WalletBlocState([List props = const []]) : super();
}

class InitialWalletBlocState extends WalletBlocState {}

class WalletBlocLoading extends WalletBlocState {}

class WalletBlocLoaded extends WalletBlocState {
  num gem;
  WalletBlocLoaded(this.gem) : super([gem]);
}
