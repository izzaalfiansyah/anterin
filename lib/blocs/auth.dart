import 'package:anterin/utils/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  dynamic id;
  dynamic user;

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
        user: res.data['user'],
      ));

      return true;
    } catch (e) {
      emit(AuthState());

      return false;
    }
  }
}
