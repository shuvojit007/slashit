// Package imports:
import 'package:meta/meta.dart';
import 'package:slashit/src/models/upcommingPayments.dart';

@immutable
abstract class RepaymentBlocState {
  RepaymentBlocState([List props = const []]) : super();
}

class InitialRepaymentBlocState extends RepaymentBlocState {}

class RepaymentBlocLoading extends RepaymentBlocState {}

class RepaymentBlocLoaded extends RepaymentBlocState {
  List<Result> res;
  RepaymentBlocLoaded(this.res) : super([res]);
}
