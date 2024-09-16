import 'package:anterin/blocs/loader.dart';
import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/components/loading.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/screens/user/pesanan/detail/status_pengiriman.dart';
import 'package:anterin/utils/dates.dart';
import 'package:anterin/utils/distance.dart';
import 'package:anterin/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PesananDetailScreen extends StatefulWidget {
  const PesananDetailScreen({super.key, required this.orderId});

  final dynamic orderId;

  @override
  State<PesananDetailScreen> createState() => PesananDetailScreenState();
}

class PesananDetailScreenState extends State<PesananDetailScreen> {
  OrderBloc orderBloc = OrderBloc();
  Order? order;

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  getOrder() async {
    await loaderInstance(context).on();

    final data = await orderBloc.getOne(widget.orderId);

    setState(() {
      order = data;
    });

    await loaderInstance(context).off();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<LoaderBloc, bool>(
        builder: (context, state) {
          if (state) {
            return Loading();
          }

          if (order == null) {
            return Center(
              child: Text('Terjadi kesalahan'),
            );
          }

          return ListView(
            padding: EdgeInsets.all(10),
            children: [
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowSm,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Jadwal orderan',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          Text(
                            formatDateTime(order!.schedule!),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Hr(color: Colors.grey.shade100),
                    ),
                    detailTile(
                      title: 'Deskripsi Orderan',
                      subtitle: order!.description,
                    ),
                    SizedBox(height: 24),
                    detailTile(
                      title: 'Alamat Penjemputan',
                      subtitle:
                          "${order!.pickupAddress}, ${order!.pickupMapAddress}",
                    ),
                    SizedBox(height: 24),
                    detailTile(
                      title: 'Alamat Pengantaran',
                      subtitle:
                          "${order!.deliveryAddress}, ${order!.deliveryMapAddress}",
                    ),
                    SizedBox(height: 24),
                    detailTile(
                      title: 'Jarak Tempuh',
                      subtitle: '${formatDistance(order!.distance)}',
                      subtitleColor: Colors.deepOrange,
                    ),
                  ],
                ),
              ),
              StatusPengiriman(
                order: order!,
                orderBloc: orderBloc,
                refresh: getOrder,
              ),
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowSm,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ongkos Kirim:'),
                        Text(
                          'Rp. ${order!.payment!.shippingCost.toInt()}',
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
                          'Rp. ${order!.payment!.adminFee.toInt()}',
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
                          'Rp. ${order!.payment!.total.toInt()}',
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
            ],
          );
        },
      ),
    );
  }

  Column detailTile({
    required String title,
    required String subtitle,
    Color? subtitleColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey,
              ),
        ),
        SizedBox(height: 2.5),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: subtitleColor,
              ),
        ),
      ],
    );
  }
}
