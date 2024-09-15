import 'package:anterin/blocs/loader.dart';
import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/components/maps.dart';
import 'package:anterin/constant.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/models/payment.dart';
import 'package:anterin/utils/dialog.dart';
import 'package:anterin/utils/loader.dart';
import 'package:anterin/utils/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class KonfirmasiPesananLainScreen extends StatefulWidget {
  const KonfirmasiPesananLainScreen({super.key});

  @override
  State<KonfirmasiPesananLainScreen> createState() =>
      _BuatPesananLainScreenState();
}

class _BuatPesananLainScreenState extends State<KonfirmasiPesananLainScreen> {
  double distance = 0;
  double adminFee = 1000;
  double shippingCost = 0;
  double total = 0;

  @override
  void initState() {
    setState(() {
      total = adminFee + shippingCost;
    });

    loaderInstance(context).on();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pesanan'),
      ),
      body: BlocBuilder<OrderBloc, Order?>(
        builder: (context, state) {
          return ListView(
            children: [
              Container(
                // padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: shadowSm,
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Maps(
                      size: size.height * 1 / 2,
                      center: LatLng(-8.160916921864638, 113.72277131655589),
                      route: MapRoute(
                        from: LatLng(
                          state!.pickupMapLat.toDouble(),
                          state.pickupMapLng.toDouble(),
                        ),
                        to: LatLng(
                          state.deliveryMapLat.toDouble(),
                          state.deliveryMapLng.toDouble(),
                        ),
                      ),
                      onRouteFound: (route) {
                        setState(() {
                          distance = route.distance.toDouble();
                          shippingCost = getOngkir(distance);
                          total = shippingCost + adminFee;
                        });
                        loaderInstance(context).off();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Jarak Tempuh:'),
                          Text(
                            '${distance.toStringAsFixed(1)} m',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: shadowSm,
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ongkos Kirim:'),
                        Text(
                          'Rp. ${shippingCost.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Biaya Admin:'),
                        Text(
                          'Rp. ${adminFee.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Hr(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Biaya:',
                          style: TextStyle(
                            color: cPrimary,
                          ),
                        ),
                        Text(
                          'Rp. ${total.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<LoaderBloc, bool>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: cPrimary,
                      ),
                      onPressed: state
                          ? null
                          : () async {
                              loaderInstance(context).on();
                              final order =
                                  BlocProvider.of<OrderBloc>(context).state!;

                              Payment payment = Payment(
                                amount: 0,
                                shippingCost: shippingCost,
                                adminFee: adminFee,
                              );

                              final res =
                                  await BlocProvider.of<OrderBloc>(context)
                                      .store(order, payment);

                              showNotification(
                                context,
                                message: res.message,
                                error: res.isError,
                              );

                              loaderInstance(context).off();
                            },
                      child: Text(state ? 'MEMUAT' : 'KONFIRMASI'),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
