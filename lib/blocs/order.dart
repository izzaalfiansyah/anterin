import 'package:anterin/constants/list_pagination.dart';
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

  Future<ListPagination<Order>> getList({
    String status = 'pending',
    int page = 1,
  }) async {
    try {
      final http = await httpInstance();
      final res = await http.get('/order', queryParameters: {
        'status': status,
        'page': page,
      });

      final orders = List.from(res.data['data']).map<Order>((item) {
        return Order.fromJSON(item);
      }).toList();

      return ListPagination<Order>(
        currentPage: res.data['current_page'],
        data: orders,
        perPage: res.data['per_page'],
        total: res.data['total'],
        to: res.data['to'],
      );
    } catch (e) {
      return ListPagination(
        data: [],
      );
    }
  }

  Future<Order?> getOne(dynamic id) async {
    try {
      final http = await httpInstance();
      final res = await http.get('/order/$id');

      final order = Order.fromJSON(res.data);

      return order;
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse> updateStatus(
    dynamic id, {
    required String status,
    bool cancelByCourier = false,
    String? reason,
  }) async {
    try {
      final http = await httpInstance();
      final res = await http.put('/order/$id/status', data: {
        'status': status,
        'cancel_by_courier': cancelByCourier,
        'reason': reason,
      });

      return ApiResponse(message: res.data['message']);
    } on DioException catch (e) {
      return ApiResponse(message: e.response!.data['message'], isError: true);
    } catch (e) {
      return ApiResponse(message: 'Terjadi kesalahan', isError: true);
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
