import 'package:flutter/material.dart';
import 'package:my_webschool_secondaire/models/timesheet_model.dart';
import 'package:my_webschool_secondaire/utils/constants_util.dart';
import 'package:my_webschool_secondaire/utils/string_util.dart';

import 'timesheet.dart';
import 'timesheet_card_item.dart';

class TimesheetCard extends StatelessWidget {
  final int index;
  final DateTime date;

  // Static list of TimeSheetModel for demonstration purposes
  final List<TimeSheetModel> cours = [
    TimeSheetModel(
      matiere: "Mathematics",
      atome: "101",
      prenom_prof: "John",
      nom_prof: "Doe",
      heure_debut: "08:00",
      heure_fin: "10:00",
      salle: "Room 204",
    ),
    TimeSheetModel(
      matiere: "Physics",
      atome: "102",
      prenom_prof: "Jane",
      nom_prof: "Smith",
      heure_debut: "10:30",
      heure_fin: "12:00",
      salle: "Room 205",
    )
  ];

  String? jour;

  TimesheetCard({
    super.key,
    required this.index,
    required this.date,
    this.jour,
    required List<dynamic> cours,
  });

  @override
  Widget build(BuildContext context) {
    if (jour != null) {
      return Material(
        child: cours.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: kColorPrimary),
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                          text: jour ?? '',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Container(
                    padding: const EdgeInsets.only(
                        left: 0, top: 20, bottom: 20, right: 0),
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Aucun cours prévu.',
                              style:
                                  TextStyle(color: kColorDark, fontSize: 22))),
                    ),
                  ))
                ],
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: kColorPrimary),
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: jour ?? ' ',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ...cours.map((TimeSheetModel tab) {
                    return TimesheetCardItem(cour: tab);
                  }).toList(),
                ],
              ),
      );
    } else {
      if (cours.isEmpty) {
        return Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(
                    text: jour ??
                        formatDateTime(date, 'EEEE dd MMMM yyyy', context)
                            .toCapitalized(),
                    style: const TextStyle(color: kColorDark, fontSize: 20))),
            const SizedBox(
              height: 5,
            ),
            Center(
                child: Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0),
              child: const Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Aucun cours prévu.',
                        style: TextStyle(color: kColorDark, fontSize: 22))),
              ),
            ))
          ],
        );
      } else {
        return Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(
                    text: jour ??
                        formatDateTime(date, 'EEEE dd MMMM yyyy', context)
                            .toCapitalized(),
                    style: const TextStyle(color: kColorDark, fontSize: 20))),
            const SizedBox(
              height: 5,
            ),
            ...cours.map((TimeSheetModel tab) {
              return TimesheetCardItem(cour: tab);
            }).toList(),
          ],
        );
      }
    }
  }
}
