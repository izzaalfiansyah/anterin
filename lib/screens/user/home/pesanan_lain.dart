import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/form_group.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/screens/user/home/buat_pesanan_lain/index.dart';
import 'package:anterin/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_validator/form_validator.dart';

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

  final makeOrderForm = GlobalKey<FormState>();

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
        child: Form(
          key: makeOrderForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormGroup(
                label: Text('Order'),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan deskripsi orderan',
                  ),
                  controller: deskripsiController,
                  maxLines: 4,
                  validator: ValidationBuilder().required().build(),
                ),
              ),
              SizedBox(height: 20),
              FormGroup(
                label: Text('Tanggal pengantaran'),
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
                        FormGroup(
                          label: Text('Waktu pengantaran'),
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
                  if (makeOrderForm.currentState!.validate()) {
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

                    setState(() {
                      deskripsiController.text = '';
                      dateTime = null;
                      timeOfDay = TimeOfDay.now();
                    });

                    Modular.to.push(
                      MaterialPageRoute(
                        builder: (context) => BuatPesananLainScreen(),
                      ),
                    );
                  }
                },
                child: Text('BUAT PESANAN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
