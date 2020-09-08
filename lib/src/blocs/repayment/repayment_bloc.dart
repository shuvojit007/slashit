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

  List<Result> _repayment = [];
  @override
  Stream<RepaymentBlocState> mapEventToState(
    RepaymentBlocEvent event,
  ) async* {
    if (event is GetRepayment) {
      _repayment = [];
      yield RepaymentBlocLoading();
      UpcommingPayments upcommingPayments = await UserRepository.instance
          .upCommingRepayments(event.limit, event.offset);
      List<Result> res = upcommingPayments.result;

      for (final Result result in res) {
        _repayment.add(result);
      }
      //  print("repayment ${_repayment.length}");
      yield RepaymentBlocLoaded(_repayment);
    } else if (event is LoadMore) {
      yield RepaymentBlocMoreLoading();
      UpcommingPayments upcommingPayments = await UserRepository.instance
          .upCommingRepayments(event.limit, event.offset);
      List<Result> res = upcommingPayments.result;
      for (final Result result in res) {
        _repayment.add(result);
      }
      yield RepaymentBlocMoreLoaded(_repayment);
    }
  }
}
