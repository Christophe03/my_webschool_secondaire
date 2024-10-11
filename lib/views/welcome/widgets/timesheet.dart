import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_secondaire/models/timesheet_model.dart';
import 'package:my_webschool_secondaire/utils/constants_util.dart';
import 'package:my_webschool_secondaire/utils/string_util.dart';
import 'timesheet_card.dart';
import 'package:my_webschool_secondaire/models/timesheet_model.dart';

class TimeSheet extends StatefulWidget {
  const TimeSheet({super.key});

  @override
  State<TimeSheet> createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  List<String> tabs = ['aujourdhui', 'demain'];
  List<bool> isSelected = [true, false];
  DateTime today = DateTime.now();
  DateTime tommorow = addDays(DateTime.now(), 1);

  // Données statiques pour TimeSheetModel
  Future<List<TimeSheetModel>> fetchData() async {
    await Future.delayed(const Duration(seconds: 1)); // Simuler un délai

    List<TimeSheetModel> timeSheets = [
      TimeSheetModel(
        jour: today.weekday,
        matiere: "Mathematics",
        heure_debut: "08:00",
        heure_fin: "10:00",
        salle: "Room 204",
        nom_prof: "Doe",
        prenom_prof: "John",
        atome: "101",
      ),
      TimeSheetModel(
        jour: tommorow.weekday,
        matiere: "Physics",
        heure_debut: "10:30",
        heure_fin: "12:00",
        salle: "Room 205",
        nom_prof: "Smith",
        prenom_prof: "Jane",
        atome: "102",
      )
    ];

    return timeSheets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          borderColor: Colors.grey,
          selectedBorderColor: kColorPrimary,
          color: Colors.grey,
          selectedColor: Colors.black,
          fillColor: kColorPrimary,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                isSelected[buttonIndex] = buttonIndex == index;
              }
            });
          },
          isSelected: isSelected,
          children: tabs.map((String tab) {
            return SizedBox(
              width: 100,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: tab.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected[tabs.indexOf(tab)]
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        FutureBuilder<List<TimeSheetModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: RichText(
                  text: TextSpan(text: 'Error: ${snapshot.error}'),
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(10),
                child: isSelected[0]
                    ? TimesheetCard(
                        index: 1,
                        date: today,
                        cours: getCoursByDate(today, snapshot.data))
                    : TimesheetCard(
                        index: 2,
                        date: tommorow,
                        cours: getCoursByDate(tommorow, snapshot.data)),
              );
            }
          },
        ),
      ],
    );
  }

  List<TimeSheetModel> getCoursByDate(DateTime dt, List<TimeSheetModel>? list) {
    if (list != null) {
      return list.where((element) => element.jour == dt.weekday).toList();
    }
    return [];
  }
}

class TimeSheetModel {
  final int jour;
  final String matiere;
  final String heure_debut;
  final String heure_fin;
  final String salle;
  final String nom_prof;
  final String prenom_prof;
  final String atome;

  TimeSheetModel({
    required this.jour,
    required this.matiere,
    required this.heure_debut,
    required this.heure_fin,
    required this.salle,
    required this.nom_prof,
    required this.prenom_prof,
    required this.atome,
  });
}
