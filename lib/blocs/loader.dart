import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderBloc extends Cubit<bool> {
  LoaderBloc() : super(false);

  on() async {
    emit(true);
  }

  off() async {
    emit(false);
  }
}
