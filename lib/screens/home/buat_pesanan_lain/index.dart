import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/components/maps.dart';
import 'package:anterin/constant.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/screens/home/buat_pesanan_lain/konfirmasi/index.dart';
import 'package:anterin/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class BuatPesananLainScreen extends StatefulWidget {
  const BuatPesananLainScreen({super.key});

  @override
  State<BuatPesananLainScreen> createState() => _BuatPesananLainScreenState();
}

class _BuatPesananLainScreenState extends State<BuatPesananLainScreen> {
  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();

  MapController pickupMapController = MapController();
  MapController deliveryMapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Pesanan'),
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: shadowSm,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Titik Jemput'),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 13),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Alamat',
                                  ),
                                  controller: pickupAddressController,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final locations = await locationFromAddress(
                                      pickupAddressController.text);

                                  pickupMapController.move(
                                    LatLng(
                                      locations[0].latitude,
                                      locations[0].longitude,
                                    ),
                                    18,
                                  );
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Maps(
                          controller: pickupMapController,
                          showMarker: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: shadowSm,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Titik Antar'),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 13),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Alamat',
                                  ),
                                  controller: deliveryAddressController,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final locations = await locationFromAddress(
                                      deliveryAddressController.text);

                                  deliveryMapController.move(
                                    LatLng(
                                      locations[0].latitude,
                                      locations[0].longitude,
                                    ),
                                    18,
                                  );
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Maps(
                          controller: deliveryMapController,
                          showMarker: true,
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

                    order.deliveryAddress = deliveryAddressController.text;
                    order.deliveryMapLat =
                        deliveryMapController.camera.center.latitude.toString();
                    order.deliveryMapLng = deliveryMapController
                        .camera.center.longitude
                        .toString();
                    order.pickupAddress = pickupAddressController.text;
                    order.pickupMapLat =
                        pickupMapController.camera.center.latitude.toString();
                    order.pickupMapLng =
                        pickupMapController.camera.center.longitude.toString();

                    BlocProvider.of<OrderBloc>(context).set(order);

                    Modular.to.push(
                      MaterialPageRoute(
                        builder: (context) => KonfirmasiPesananLainScreen(),
                      ),
                    );
                  },
                  child: Text('LANJUTKAN'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
