import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/constants/order_status.dart';
import 'package:anterin/utils/dates.dart';
import 'package:flutter/material.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  String selectedStatus = 'pending';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: List.generate(12, (index) {
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
                          "${formatDate(DateTime.now())} ${formatTime(TimeOfDay.now())}",
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
                                text: '100m',
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
                    Text(
                        'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Esse iure sed harum nam unde ex ipsum labore maiores eos illum excepturi, doloremque officia saepe voluptatibus, neque rerum. Dolore, sit quidem.'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Lihat Detail'.toUpperCase()),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Hubungi Kurir'.toUpperCase()),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
