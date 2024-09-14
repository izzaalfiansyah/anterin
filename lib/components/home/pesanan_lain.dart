import 'package:anterin/blocs/order.dart';
import 'package:anterin/constant.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/screens/home/buat_pesanan_lain/index.dart';
import 'package:anterin/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PesananLain extends StatefulWidget {
  const PesananLain({
    super.key,
  });

  @override
  State<PesananLain> createState() => _PesananLainState();
}

class _PesananLainState extends State<PesananLain> {
  TextEditingController deskripsiController = TextEditingController();
  DateTime? dateTime;
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: shadowSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order'),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan deskripsi orderan',
                ),
                controller: deskripsiController,
                maxLines: 4,
              ),
            ),
            SizedBox(height: 20),
            Text('Tanggal pengantaran'),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      dateTime != null ? formatDate(dateTime!) : 'Sekarang',
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month + 2,
                      DateTime.now().day,
                    ),
                    initialDate: dateTime ?? DateTime.now(),
                  );

                  setState(() {
                    dateTime = date;
                  });
                },
              ),
            ),
            dateTime != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('Waktu pengantaran'),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: formatTime(timeOfDay),
                          ),
                          readOnly: true,
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: timeOfDay,
                            );

                            if (time != null) {
                              setState(() {
                                timeOfDay = time;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 30),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: cPrimary,
                  fixedSize: Size.fromWidth(size.width),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () {
                DateTime? schedule;

                if (dateTime != null) {
                  schedule = DateTime(
                    dateTime!.year,
                    dateTime!.month,
                    dateTime!.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                  );
                }

                BlocProvider.of<OrderBloc>(context).set(Order(
                  description: deskripsiController.text,
                  pickupAddress: '',
                  pickupMapLat: 0,
                  pickupMapLng: 0,
                  deliveryAddress: '',
                  deliveryMapLat: 0,
                  deliveryMapLng: 0,
                  schedule: schedule,
                ));

                Modular.to.push(
                  MaterialPageRoute(
                    builder: (context) => BuatPesananLainScreen(),
                  ),
                );
              },
              child: Text('BUAT PESANAN'),
            ),
          ],
        ),
      ),
    );
  }
}
