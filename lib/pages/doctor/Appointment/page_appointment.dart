import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sofiacare/models/patient.dart';
import 'package:sofiacare/pages/doctor/dossiers/page_doss_home.dart';
import 'package:sofiacare/pages/doctor/settings/page_doc_setting_home.dart';
import 'package:sofiacare/pages/components/utils/config.dart';
import 'package:sofiacare/services/patient_service.dart';

import '../home/page_doc_home.dart';

class AppointmentList extends StatefulWidget {
  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  // final List<Patient> patients = [
  //   Patient(name: "Ghofrane Labidi", image: "labidi.jpg"),
  //   Patient(name: "Aziz jawedi", image: "aziz.jpg"),
  //   Patient(name: "Mounira ben Hadid", image: "mounira.jpg"),
  //   Patient(name: "Hamadi Labidi", image: "hamadi.jpg"),
  //   // Add more patients as needed
  // ];

  ApiPatient apiPatient = ApiPatient();

  List<Patient> patients = [];

  bool isLoaded = true;

  getallarch() async {
    patients = await apiPatient.fetchPatients();
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getallarch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF013871),
        title: const Text('Appointment List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorHome()),
            );
          },
        ),
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppointmentCard(patient: patients[index]),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: GNav(
            gap: 8,
            activeColor: Color(0xFF013871),
            iconSize: 25,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[800]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home,
              ),
              GButton(
                icon: Icons.file_copy,
              ),
              GButton(
                icon: Icons.calendar_month,
              ),
              GButton(
                icon: Icons.settings,
              ),
            ],
            selectedIndex: 2,
            onTabChange: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorHome()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DossierHome()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentList()),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorSettings()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatefulWidget {
  final Patient patient;

  const AppointmentCard({Key? key, required this.patient}) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF013871),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'assets/images/${widget.patient.user!.image!}'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.patient.user!.name!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Patient',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              ScheduleCard(),
              Config.spaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            "Lundi, 11/02/2023",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              "14:00",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
