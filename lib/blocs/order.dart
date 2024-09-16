import 'package:anterin/models/order.dart';
import 'package:anterin/models/payment.dart';
import 'package:anterin/constants/api_response.dart';
import 'package:anterin/utils/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderBloc extends Cubit<Order?> {
  OrderBloc() : super(null);

  set(Order order) {
    emit(order);
  }

  Future<List<Order>> getList() async {
    try {
      final http = await httpInstance();
      final res = await http.get('/order');

      return List.from(res.data['data']).map<Order>((item) {
        return Order.fromJSON(item);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<ApiResponse> store(Order order, Payment payment) async {
    try {
      Map<String, dynamic> data = order.toJSON();
      data.addAll(payment.toJSON());

      final http = await httpInstance();
      final res = await http.post('/order', data: data);

      Modular.to.popUntil((route) => route.isFirst);
      Modular.to.pushNamed('/pesanan');

      return ApiResponse(message: res.data['message']);
    } on DioException catch (e) {
      return ApiResponse(message: e.response!.data['message'], isError: true);
    } catch (e) {
      return ApiResponse(message: 'Terjadi kesalahan', isError: true);
    }
  }
}
