import 'package:anterin/models/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PesananState {
  Order? order;

  PesananState({
    this.order,
  });
}

class PesananEvent {}

class PesananSetOrder extends PesananEvent {
  final Order order;

  PesananSetOrder({required this.order});
}

class PesananBloc extends Bloc<PesananEvent, PesananState> {
  PesananBloc() : super(PesananState()) {
    on<PesananEvent>((event, emit) {});

    on<PesananSetOrder>((event, emit) {
      emit(PesananState(
        order: event.order,
      ));
    });
  }
}
