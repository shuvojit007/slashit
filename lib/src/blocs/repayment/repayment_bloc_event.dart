// Package imports:
import 'package:meta/meta.dart';

@immutable
abstract class RepaymentBlocEvent {
  RepaymentBlocEvent([List props = const []]) : super();
}

class GetRepayment extends RepaymentBlocEvent {
  final int limit;
  final int offset;

  GetRepayment(this.limit, this.offset);
}

class LoadMore extends RepaymentBlocEvent {
  final int limit;
  final int offset;

  LoadMore(this.limit, this.offset);
}
