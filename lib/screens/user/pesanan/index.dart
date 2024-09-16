import 'package:anterin/blocs/loader.dart';
import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:anterin/components/loading.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/constants/order_status.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/screens/user/pesanan/detail/index.dart';
import 'package:anterin/utils/dates.dart';
import 'package:anterin/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    final items = await orderBloc.getList(
      status: selectedStatus,
    );

    setState(() {
      orders = items.data;
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
                                  getOrders();
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
              child: Text('Pesanan belum tersedia.'),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: List.generate(orders.length, (index) {
                  final order = orders[index];

                  return GestureDetector(
                    onTap: () {
                      Modular.to.push(
                        MaterialPageRoute(
                          builder: (context) => PesananDetailScreen(
                            orderId: order.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowSm,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: cPrimary,
                            size: 14,
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: "${order.description} ",
                                      ),
                                      TextSpan(
                                        text: ' (${order.distance}m)',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${formatDate(order.schedule!)} ${formatTime(TimeOfDay.fromDateTime(order.schedule!))}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
