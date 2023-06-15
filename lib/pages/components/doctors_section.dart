import 'package:flutter/material.dart';
import 'package:sofiacare/pages/components/tools/colors.dart';

import '../patient/profile/page_doc_profile.dart';

class DoctorSection extends StatefulWidget {
  @override
  _DoctorSectionState createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  List<bool> isFavoriteList = List.generate(4, (_) => false);

  List<String> doctorNames = [
    "Dr. Lilia Jemai",
    "Dr. Siwar Hajri",
    "Dr. Bassem Mkadmi",
    "Dr. Ichrak ben Rhouma",
  ];

  List<String> doctorImages = [
    "assets/images/lilia.jpg",
    "assets/images/siwar.jpg",
    "assets/images/bassemmk.jpg",
    "assets/images/ichrak.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 300,
                width: 200,
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F8FF),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: sdColor,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorProfile(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.asset(
                              doctorImages[index],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F8FF),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: sdColor,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavoriteList[index] = !isFavoriteList[index];
                                });
                              },
                              child: Center(
                                child: Icon(
                                  isFavoriteList[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavoriteList[index] ? Colors.amber : pColor,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorNames[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: pColor,
                            ),
                          ),
                          Text(
                            "chirurgien",
                            style: TextStyle(
                              fontSize: 18,
                              color: bColor.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "4.9",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: bColor.withOpacity(0.6),
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
            ],
          );
        },
      ),
    );
  }
}
