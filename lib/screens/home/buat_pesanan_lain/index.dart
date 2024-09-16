import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/form_group.dart';
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

  late Order order;

  @override
  void initState() {
    order = BlocProvider.of<OrderBloc>(context).state!;

    placemarkFromCoordinates(
            mapsDefaultCenter.latitude, mapsDefaultCenter.longitude)
        .then((placemarks) {
      final placemark = placemarks[0];
      final address =
          '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}';

      setState(() {
        order.pickupMapAddress = address;
        order.deliveryMapAddress = address;
      });
    });
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
                    ),
                    SizedBox(height: 10),
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
                              ),
                              SizedBox(height: 10),
                              Text(formatDate(state.schedule!)),
                              SizedBox(height: 20),
                              Hr(
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Jam Pengantaran:',
                              ),
                              SizedBox(height: 10),
                              Text(formatTime(
                                  TimeOfDay.fromDateTime(state.schedule!))),
                            ]
                          : [
                              Text(
                                'Waktu Pengantaran:',
                              ),
                              SizedBox(height: 10),
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
                        // FormGroup(
                        //   label: Text('Titik Jemput'),
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //       border: InputBorder.none,
                        //       hintText: 'Alamat',
                        //       suffixIcon: IconButton(
                        //         onPressed: () async {
                        //           try {
                        //             final locations = await locationFromAddress(
                        //                 pickupAddressController.text);

                        //             pickupMapController.move(
                        //               LatLng(
                        //                 locations[0].latitude,
                        //                 locations[0].longitude,
                        //               ),
                        //               18,
                        //             );
                        //           } catch (e) {
                        //             showNotification(context,
                        //                 message: 'Lokasi tidak ditemukan');
                        //           }
                        //         },
                        //         icon: Icon(
                        //           Icons.search,
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //     ),
                        //     controller: pickupAddressController,
                        //   ),
                        // ),
                        Text('Titik Jemput:'),
                        SizedBox(height: 10),
                        Maps(
                          controller: pickupMapController,
                          showMarker: true,
                          onPositionChanged: (event, point) async {
                            final placemarks = await placemarkFromCoordinates(
                                point.latitude, point.longitude);
                            final placemark = placemarks[0];

                            setState(() {
                              order.pickupMapAddress =
                                  '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}';
                            });
                          },
                          // getCurrentPosition: true,
                        ),
                        order.pickupMapAddress != null
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Text(order.pickupMapAddress!),
                              )
                            : SizedBox(),
                        SizedBox(height: 20),
                        FormGroup(
                          label: Text('Alamat Lengkap:'),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Masukkan Alamat',
                            ),
                            controller: pickupAddressController,
                          ),
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
                        Maps(
                          controller: deliveryMapController,
                          showMarker: true,
                          onPositionChanged: (event, point) async {
                            final placemarks = await placemarkFromCoordinates(
                                point.latitude, point.longitude);
                            final placemark = placemarks[0];

                            setState(() {
                              order.deliveryMapAddress =
                                  '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}';
                            });
                          },
                          // getCurrentPosition: true,
                        ),
                        order.deliveryMapAddress != null
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Text(order.deliveryMapAddress!),
                              )
                            : SizedBox(),
                        SizedBox(height: 20),
                        FormGroup(
                          label: Text('Alamat Lengkap:'),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Masukkan Alamat',
                            ),
                            controller: deliveryAddressController,
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
                    setState(() {
                      order.deliveryAddress = deliveryAddressController.text;
                      order.deliveryMapLat =
                          deliveryMapController.camera.center.latitude;
                      order.deliveryMapLng =
                          deliveryMapController.camera.center.longitude;
                      order.pickupAddress = pickupAddressController.text;
                      order.pickupMapLat =
                          pickupMapController.camera.center.latitude;
                      order.pickupMapLng =
                          pickupMapController.camera.center.longitude;
                    });

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
