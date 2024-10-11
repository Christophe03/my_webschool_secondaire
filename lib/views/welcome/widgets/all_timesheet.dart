import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_webschool_secondaire/models/timesheet_model.dart';
import 'package:my_webschool_secondaire/utils/constants_util.dart';
import 'package:my_webschool_secondaire/utils/string_util.dart';
import 'package:my_webschool_secondaire/views/welcome/widgets/timesheet_card.dart';
import 'package:my_webschool_secondaire/widgets/app_name.dart';
import 'package:my_webschool_secondaire/models/timesheet_model.dart';

import 'timesheet.dart';

class AllTimesheet extends StatefulWidget {
  const AllTimesheet({Key? key}) : super(key: key);

  @override
  _AllTimesheetState createState() => _AllTimesheetState();
}

class _AllTimesheetState extends State<AllTimesheet> {
  bool fetching = true;
  List<TimeSheetModel> timesheets = [];
  final List<Map<String, dynamic>> listJour = [
    {'name': 'Lundi', 'index': 1},
    {'name': 'Mardi', 'index': 2},
    {'name': 'Mercredi', 'index': 3},
    {'name': 'Jeudi', 'index': 4},
    {'name': 'Vendredi', 'index': 5},
    {'name': 'Samedi', 'index': 6},
    {'name': 'Dimanche', 'index': 7},
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      fetching = true;
    });

    // Simulated static data for timesheets
    timesheets = [
      TimeSheetModel(
          jour: 1,
          matiere: 'Mathématiques',
          heure_debut: '08:00',
          heure_fin: '09:30',
          salle: 'Salle A',
          nom_prof: 'Prof X',
          prenom_prof: 'John',
          atome: 'A1'),
      TimeSheetModel(
          jour: 2,
          matiere: 'Physique',
          heure_debut: '10:00',
          heure_fin: '11:30',
          salle: 'Salle B',
          nom_prof: 'Prof Y',
          prenom_prof: 'Doe',
          atome: 'A2'),
      // Add more static timesheets as needed
    ];

    await Future.delayed(const Duration(seconds: 1)); // Simulated delay
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kColorPrimary,
        titleSpacing: 0,
        title: AppName(
          fontSize: 19.0,
          school: "emploi.du.temps".tr(),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kColorLight,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Builder(builder: (BuildContext context) {
        return RefreshIndicator(
            onRefresh: () async {
              fetchData();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: fetching
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                              ])
                        : timesheets.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Center(
                                      child: Icon(Icons.folder_off_outlined,
                                          size: 100),
                                    ),
                                    Center(
                                      child: Text(
                                        "l.emploie.du.temps.est.vide".tr(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    )
                                  ])
                            : ListView(
                                children: [
                                  ...listJour.map((e) {
                                    return TimesheetCard(
                                      index: 0,
                                      date: DateTime.now(),
                                      cours: getCoursByDate(e['index']),
                                      jour:
                                          e['name'].toString().toCapitalized(),
                                    );
                                  })
                                ],
                              ))
              ],
            ));
      }),
    );
  }

  List<TimeSheetModel> getCoursByDate(int dt) {
    return timesheets.where((element) => element.jour == dt).toList();
  }
}
