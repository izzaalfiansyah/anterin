import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/components/maps.dart';
import 'package:anterin/constant.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/utils/dates.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pesanan'),
      ),
      body: BlocBuilder<OrderBloc, Order?>(
        builder: (context, state) {
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: shadowSm,
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Deskripsi Orderan:',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(state!.description),
                    SizedBox(height: 20),
                    Hr(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.schedule != null
                          ? [
                              Text(
                                'Tanggal Pengantaran:',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text(formatDate(state.schedule!)),
                              SizedBox(height: 20),
                              Hr(
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Jam Pengantaran:',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text(formatTime(
                                  TimeOfDay.fromDateTime(state.schedule!))),
                            ]
                          : [
                              Text(
                                'Waktu Pengantaran:',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text('Sekarang'),
                            ],
                    ),
                    SizedBox(height: 20),
                    Hr(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Alamat Titik Jemput:',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(state.pickupAddress),
                    SizedBox(height: 20),
                    Hr(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Alamat Titik Antar:',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(state.deliveryAddress),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rute pengantaran:'),
                    SizedBox(height: 10),
                    Maps(
                        center: LatLng(-8.312402557917546, 113.40530296713514)),
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
                        Text('Total Biaya:'),
                        Text(
                          'Rp. 17.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
