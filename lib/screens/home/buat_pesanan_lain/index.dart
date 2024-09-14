import 'package:anterin/blocs/order.dart';
import 'package:anterin/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuatPesananLainScreen extends StatefulWidget {
  const BuatPesananLainScreen({super.key});

  @override
  State<BuatPesananLainScreen> createState() => _BuatPesananLainScreenState();
}

class _BuatPesananLainScreenState extends State<BuatPesananLainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Pesanan'),
      ),
      body: BlocBuilder<OrderBloc, Order?>(
        builder: (context, state) {
          return Center(
            child: Text('Buat pesanan page'),
          );
        },
      ),
    );
  }
}
