import 'package:anterin/components/form_group.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/constants/order_status.dart';
import 'package:anterin/models/order.dart';
import 'package:anterin/utils/dates.dart';
import 'package:anterin/utils/dialog.dart';
import 'package:flutter/material.dart';

class StatusPengiriman extends StatefulWidget {
  const StatusPengiriman({
    super.key,
    required this.order,
    required this.refresh,
  });

  final Order order;
  final Function refresh;

  @override
  State<StatusPengiriman> createState() => _StatusPengirimanState();
}

class _StatusPengirimanState extends State<StatusPengiriman> {
  cancelOrder() async {
    showConfirmModal(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          FormGroup(
            label: Text('Anda yakin ingin membatalkan pesanan?'),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Berikan alasanmu...'),
              maxLines: 3,
            ),
          ),
        ],
      ),
      onConfirmed: () {
        print('yakin batal boss');
      },
    );
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
            steps: orderStatus.map<Step>((status) {
              final index = orderStatus.indexOf(status);
              final currentStatusIndex = orderStatus.indexOf(
                orderStatus.firstWhere(
                  (status) => status.label == widget.order.status,
                ),
              );

              final isActive = currentStatusIndex >= index;
              final dateFormatted =
                  "${formatDate(widget.order.schedule!)} ${formatTime(TimeOfDay.fromDateTime(widget.order.schedule!))}";

              String text = '';
              String? actionText;
              Function action = () {};

              if (status.label == 'pending') {
                text = "Pesanan berhasil dibuat";
                actionText = 'Batalkan';
                action = cancelOrder;
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
