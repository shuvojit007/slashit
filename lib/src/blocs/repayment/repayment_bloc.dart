// Dart imports:
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_event.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_state.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/repository/user_repository.dart';

class RepaymentBloc extends Bloc<RepaymentBlocEvent, RepaymentBlocState> {
  @override
  RepaymentBlocState get initialState => InitialRepaymentBlocState();

  @override
  Stream<RepaymentBlocState> mapEventToState(
    RepaymentBlocEvent event,
  ) async* {
    if (event is GetRepayment) {
      yield RepaymentBlocLoading();
      UpcommingPayments upcommingPayments =
          await UserRepository.instance.upCommingRepayments();
      List<Result> res = upcommingPayments.result;
      yield RepaymentBlocLoaded(res);
    } else if (event is UpdateRepayment) {
      yield RepaymentBlocLoading();
      UpcommingPayments upcommingPayments =
          await UserRepository.instance.upCommingRepayments();
      List<Result> res = upcommingPayments.result;
      yield RepaymentBlocLoaded(res);
    }
  }
}
