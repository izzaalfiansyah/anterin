import 'package:anterin/constant.dart';
import 'package:flutter/material.dart';

class MakanMinumScreen extends StatefulWidget {
  const MakanMinumScreen({super.key});

  @override
  State<MakanMinumScreen> createState() => _MakanMinumScreenState();
}

class _MakanMinumScreenState extends State<MakanMinumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makan & Minum'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Ketik nama warung atau menu',
              ),
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: shadowSm,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        image: NetworkImage(
                            'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'),
                        width: 130,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Toko',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Jl. KH. Hasyim Asyari No 58, Desa Karangrejo, Kec. Gumukmas',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            InkWell(
                              focusColor: Colors.transparent,
                              onTap: () {
                                //
                              },
                              child: Text(
                                'SELENGKAPNYA',
                                style: TextStyle(
                                  color: cPrimary,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
