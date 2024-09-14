import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/components/maps.dart';
import 'package:anterin/constant.dart';
import 'package:anterin/models/order.dart';
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
  @override
  void initState() {
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
                          num.parse(state!.pickupMapLat).toDouble(),
                          num.parse(state.pickupMapLng).toDouble(),
                        ),
                        to: LatLng(
                          num.parse(state.deliveryMapLat).toDouble(),
                          num.parse(state.deliveryMapLng).toDouble(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Jarak:'),
                          Text(
                            '676.3 m',
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
                          'Rp. 15.000',
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
                          'Rp. 2.000',
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
                          'Rp. 17.000',
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
              Padding(
                padding: EdgeInsets.all(20),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: cPrimary,
                  ),
                  onPressed: () {
                    final order = BlocProvider.of<OrderBloc>(context).state!;

                    print(order.toJSON());
                  },
                  child: Text('KONFIRMASI'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
