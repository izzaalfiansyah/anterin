import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/screens/home/pesanan_lain.dart';
import 'package:anterin/constant.dart';
import 'package:anterin/types/kategori_layanan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bannerImages = [
    'https://cbn-web-assets.s3.ap-southeast-3.amazonaws.com/mbanner_digital_ent_bb465859fa.webp',
    'https://cbn-web-assets.s3.ap-southeast-3.amazonaws.com/mbanner_lampung_7eccf5ecd4.webp',
    'https://cbn-web-assets.s3.ap-southeast-3.amazonaws.com/mbanner_jul24_8a59735aad.webp'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anterin'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: SizedBox(),
        leadingWidth: 0,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/saya');
            },
            icon: Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 5),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(bannerImages.length, (index) {
                final bannerImage = bannerImages[index];

                return Container(
                  margin: EdgeInsets.only(left: 10),
                  width: size.width * 9.3 / 10,
                  decoration: BoxDecoration(
                    color: cPrimary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: shadowSm,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(bannerImage),
                      width: double.infinity,
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowSm,
            ),
            child: Text(
              'Buat Pesanan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.3,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(kategoriLayanans.length, (index) {
              final kategoriLayanan = kategoriLayanans[index];

              return InkWell(
                onTap: () {
                  Modular.to.pushNamed(kategoriLayanan.path);
                },
                focusColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: shadowSm,
                    // border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          kategoriLayanan.icon,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 13),
                      Text(
                        kategoriLayanan.nama,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Hr(
                    color: Colors.grey.shade300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'LAINNYA',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Hr(
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
          PesananLain(),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
