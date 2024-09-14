import 'package:flutter/material.dart';

class KategoriLayanan {
  final String nama;
  final IconData icon;
  final String path;

  KategoriLayanan({required this.nama, required this.icon, required this.path});
}

final List<KategoriLayanan> kategoriLayanans = [
  KategoriLayanan(
    nama: 'Percetakan',
    icon: Icons.print,
    path: '/percetakan',
  ),
  KategoriLayanan(
    nama: 'Makan Minum',
    icon: Icons.food_bank,
    path: '/makan_minum',
  ),
  // KategoriLayanan(
  //   nama: 'Belanja',
  //   icon: Icons.shopping_bag,
  //   path: '/belanja',
  // ),
  // KategoriLayanan(
  //   nama: 'Antar Barang',
  //   icon: Icons.compare_arrows,
  //   path: '/antar_barang',
  // ),
  // KategoriLayanan(
  //   nama: 'Laundry',
  //   icon: Icons.local_laundry_service,
  //   path: '/laundry',
  // ),
];
