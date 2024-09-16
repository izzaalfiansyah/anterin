import 'package:flutter/material.dart';

const gmt = 7;

String formatDate(DateTime dateTime) {
  dateTime = dateTime.add(Duration(hours: gmt));

  final bulan = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  return "${dateTime.day} ${bulan[dateTime.month].substring(0, 3)} ${dateTime.year}";
}

String formatDateTime(DateTime dateTime) {
  return "${formatDate(dateTime)} ${formatTime(TimeOfDay.fromDateTime(dateTime.add(Duration(hours: gmt))))}";
}

String formatTime(TimeOfDay timeOfDay) {
  String hour = '0';
  String minute = '0';

  if (timeOfDay.hour < 10) {
    hour += timeOfDay.hour.toString();
  } else {
    hour = timeOfDay.hour.toString();
  }

  if (timeOfDay.minute < 10) {
    minute += timeOfDay.minute.toString();
  } else {
    minute = timeOfDay.minute.toString();
  }

  return "$hour:$minute";
}
