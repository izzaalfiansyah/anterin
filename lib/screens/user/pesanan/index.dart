import 'package:anterin/blocs/loader.dart';
import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/components/loading.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/constants/order_status.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/utils/dates.dart';
import 'package:anterin/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  String selectedStatus = 'pending';
  OrderBloc orderBloc = OrderBloc();
  List<Order> orders = [];

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  getOrders() async {
    await loaderInstance(context).on();
    final items = await orderBloc.getList();

    setState(() {
      orders = items;
    });
    await loaderInstance(context).off();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Saya'),
        leading: SizedBox(),
        leadingWidth: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: orderStatus.map(
                  (status) {
                    final index = orderStatus.indexOf(status);
                    return Row(
                      children: [
                        SizedBox(width: index == 0 ? 0 : 24),
                        status.label == selectedStatus
                            ? Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                width: 150,
                                alignment: Alignment.center,
                                child: Text(
                                  status.text.toUpperCase(),
                                  style: TextStyle(
                                    color: cPrimary,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedStatus = status.label;
                                  });
                                },
                                child: Text(
                                  status.text.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: index == orderStatus.length - 1 ? 0 : 24,
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<LoaderBloc, bool>(
        builder: (context, state) {
          if (state) {
            return Loading();
          }

          if (orders.isEmpty) {
            return Center(
              child: Text('Anda belum membuat orderan.'),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: List.generate(orders.length, (index) {
                  final order = orders[index];

                  return Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: shadowSm,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${formatDate(order.schedule!)} ${formatTime(TimeOfDay.fromDateTime(order.schedule!))}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodySmall,
                                children: [
                                  TextSpan(text: 'Jarak tempuh: '),
                                  TextSpan(
                                    text: '${order.distance}m',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Hr(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(order.description),
                        SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: Text('Lihat Detail'.toUpperCase()),
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         print(order.courier);
                        //       },
                        //       child: Text('Hubungi Kurir'.toUpperCase()),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
