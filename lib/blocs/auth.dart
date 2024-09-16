import 'package:anterin/models/user.dart';
import 'package:anterin/constants/api_response.dart';
import 'package:anterin/utils/device.dart';
import 'package:anterin/utils/http.dart';
import 'package:anterin/utils/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthState {
  dynamic id;
  User? user;

  AuthState({
    this.id,
    this.user,
  });
}

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState());

  Future<bool> get() async {
    try {
      final http = await httpInstance();
      final res = await http.get('/profile');

      emit(AuthState(
        id: res.data['id'],
        user: User.fromJSON(res.data),
      ));

      return true;
    } catch (e) {
      emit(AuthState());

      return false;
    }
  }

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final http = await httpInstance();

      final deviceName = await getDeviceName();

      final res = await http.post('/login', data: {
        'email': email,
        'password': password,
        'device_name': deviceName,
      });

      await AuthToken.set(res.data);

      await get();

      Modular.to.navigate('/home');

      return ApiResponse(message: 'Berhasil login');
    } on DioException catch (e) {
      return ApiResponse(message: e.response!.data['message'], isError: true);
    } catch (e) {
      emit(AuthState());
      return ApiResponse(message: 'Terjadi kesalahan', isError: true);
    }
  }

  Future<ApiResponse> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final http = await httpInstance();

      final res = await http.post('/register', data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      Modular.to.pop();

      return ApiResponse(message: res.data['message']);
    } on DioException catch (e) {
      return ApiResponse(message: e.response!.data['message'], isError: true);
    } catch (e) {
      return ApiResponse(message: 'Terjadi kesalahan', isError: true);
    }
  }

  logout() async {
    try {
      final http = await httpInstance();

      await http.post('/logout');
      await AuthToken.remove();

      emit(AuthState());

      Modular.to.navigate('/login');
    } catch (e) {
      // print(e);
    }
  }
}
