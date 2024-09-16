import 'package:anterin/blocs/order.dart';
import 'package:anterin/components/form_group.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/constants/order_status.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/utils/dates.dart';
import 'package:anterin/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_validator/form_validator.dart';

class StatusPengiriman extends StatefulWidget {
  const StatusPengiriman({
    super.key,
    required this.order,
    required this.orderBloc,
    required this.refresh,
  });

  final Order order;
  final OrderBloc orderBloc;
  final Function refresh;

  @override
  State<StatusPengiriman> createState() => _StatusPengirimanState();
}

class _StatusPengirimanState extends State<StatusPengiriman> {
  int currentStatusIndex = 0;

  setCurrentStatusIndex() {
    if (mounted) {
      setState(() {
        currentStatusIndex = orderStatus.indexOf(
          orderStatus.firstWhere(
            (status) => status.label == widget.order.status,
          ),
        );
      });
    }
  }

  cancelOrder() async {
    final reasonController = TextEditingController();
    final cancelFormKey = GlobalKey<FormState>();

    updateStatus({
      required String status,
      required String message,
      String? reason,
    }) async {
      final res = await widget.orderBloc.updateStatus(
        widget.order.id,
        status: status,
        reason: reason,
      );

      if (!res.isError) {
        showNotification(context, message: message);
      } else {
        showNotification(context, message: res.message, error: true);
      }

      await widget.refresh();
      Modular.to.pop();

      setCurrentStatusIndex();
    }

    showConfirmModal(
      context,
      child: Form(
        key: cancelFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            FormGroup(
              label: Text('Anda yakin ingin membatalkan pesanan?'),
              child: TextFormField(
                controller: reasonController,
                decoration: InputDecoration(hintText: 'Berikan alasanmu...'),
                maxLines: 3,
                validator: ValidationBuilder().required().build(),
              ),
            ),
          ],
        ),
      ),
      onConfirmed: () async {
        if (cancelFormKey.currentState!.validate()) {
          await updateStatus(
            status: 'canceled',
            message: 'Orderan berhasil dibatalkan',
            reason: reasonController.text,
          );
        }
      },
    );
  }

  @override
  void initState() {
    setCurrentStatusIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: shadowSm,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status Pengiriman'),
          SizedBox(height: 30),
          Stepper(
            physics: NeverScrollableScrollPhysics(),
            type: StepperType.vertical,
            controlsBuilder: (context, details) {
              return Row();
            },
            currentStep: currentStatusIndex,
            steps: orderStatus.map<Step>((status) {
              final index = orderStatus.indexOf(status);

              final isActive = currentStatusIndex >= index;

              String dateFormatted = formatDateTime(widget.order.updatedAt!);

              String text = '';
              String? actionText;
              Function action = () {};

              if (status.label == 'pending') {
                dateFormatted = formatDateTime(widget.order.createdAt!);
                text = "Pesanan berhasil dibuat";
                actionText = 'Batalkan';
                action = cancelOrder;
              }

              if (status.label == 'canceled') {
                text =
                    "Pesanan dibatalkan oleh ${widget.order.cancelByCourier ? 'kurir' : 'anda'}";
              }

              return Step(
                title: Text(status.text),
                content: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$text\n$dateFormatted",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                        textAlign: TextAlign.left,
                      ),
                      actionText == null
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextButton(
                                onPressed: () {
                                  action();
                                },
                                style: TextButton.styleFrom(
                                  fixedSize: Size.fromWidth(size.width),
                                  minimumSize: Size.fromHeight(0),
                                  side: BorderSide(
                                      color: cPrimary.withOpacity(.6)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Text(
                                  actionText.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: cPrimary,
                                      ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                isActive: currentStatusIndex >= index,
                stepStyle: StepStyle(
                  color: isActive ? cPrimary : Colors.grey.shade300,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
