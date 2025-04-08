import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming; //initial status
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      "doctor_name": "Richard Tan",
      "doctor_profile": "assets/doctor_2.jpg",
      "category": "Dental",
      "status": "upcoming",
    },
    {
      "doctor_name": "Max Lim",
      "doctor_profile": "assets/doctor_3.jpg",
      "category": "Cardiology",
      "status": "complete",
    },
    {
      "doctor_name": "Jane Wong",
      "doctor_profile": "assets/doctor_4.jpg",
      "category": "Respiration",
      "status": "complete",
    },
    {
      "doctor_name": "Jenny Song",
      "doctor_profile": "assets/doctor_5.jpg",
      "category": "General",
      "status": "cancel",
    },
  ];

  @override
  Widget build(BuildContext context) {
    //return filtered appointment
    List<dynamic> filteredSchedules = [];
    return Center(child: Text('Appointment Page'));
  }
}
