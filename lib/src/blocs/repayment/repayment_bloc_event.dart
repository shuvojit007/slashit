// Package imports:
import 'package:meta/meta.dart';

@immutable
abstract class RepaymentBlocEvent {
  RepaymentBlocEvent([List props = const []]) : super();
}

class GetRepayment extends RepaymentBlocEvent {}

class UpdateRepayment extends RepaymentBlocEvent {
  UpdateRepayment();
}
