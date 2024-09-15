import 'package:anterin/blocs/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

LoaderBloc loaderInstance(BuildContext context) {
  final loaderBloc = BlocProvider.of<LoaderBloc>(context);
  return loaderBloc;
}
