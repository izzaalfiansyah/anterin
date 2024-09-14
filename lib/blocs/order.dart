import 'package:anterin/models/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Cubit<Order?> {
  OrderBloc() : super(null);

  set(Order order) {
    emit(order);
  }
}
