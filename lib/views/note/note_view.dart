import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_secondaire/models/note_model.dart';
import 'package:my_webschool_secondaire/utils/string_util.dart';

import '../../utils/constants_util.dart';
import '../../widgets/app_name.dart';
import '../../widgets/drawer_wecome.dart';
import 'widgets/note_card.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> tabs = ['1', '2'];
  List<bool> isSelected = [true, false];
  double buttonWidth = 0.0;
  DateTime? updateAt;

  @override
  void initState() {
    super.initState();
  }

  // Remplacer la méthode fetchData pour utiliser des données statiques
  Future<List<NoteModel>> fetchData() async {
    final userHive = Hive.box(hivedb);
    await Future.delayed(const Duration(seconds: 1)); // Simule un délai
    List<NoteModel> notes = [];

    // Ajoutez ici vos données statiques au lieu de les récupérer depuis Firestore
    List<dynamic> staticData = [
      {
        "semestre": 1,
        "matiere": "Mathématiques",
        "credit": 3,
        "moyenne": 15.0,
        "base": 20,
        "notes": [12, 15, 16]
      },
      {
        "semestre": 1,
        "matiere": "Physique",
        "credit": 3,
        "moyenne": 14.5,
        "base": 20,
        "notes": [10, 13, 15]
      },
      {
        "semestre": 2,
        "matiere": "Chimie",
        "credit": 3,
        "moyenne": 16.0,
        "base": 20,
        "notes": [14, 16, 18]
      },
    ];

    // Traiter les données statiques et les convertir en modèles de notes
    for (var jsonMap in staticData) {
      notes.add(NoteModel(
        semestre: jsonMap['semestre'],
        matiere: jsonMap['matiere'],
        credit: jsonMap['credit'],
        moyenne: jsonMap['moyenne'].toDouble(),
        moyennebase: jsonMap['base'],
        notes: jsonMap['notes'],
      ));
    }

    // Simuler une mise à jour de la date
    updateAt = DateTime.now();

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: AppName(
                fontSize: 19.0,
                school: 'releves.de.notes'.tr(),
              ),
              backgroundColor: kColorPrimary,
              titleSpacing: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: kColorLight,
                  size: 25,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              elevation: 1,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.help,
                    color: kColorLight,
                    size: 25,
                  ),
                  onPressed: () => updateAt != null ? showInfo() : (null),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return RefreshIndicator(
              onRefresh: () async {
                // Logique de rafraîchissement, si nécessaire
              },
              child: SingleChildScrollView(
                key: const PageStorageKey('key1'),
                padding: const EdgeInsets.all(0),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ToggleButtons(
                      constraints: BoxConstraints.expand(
                        width: (MediaQuery.of(context).size.width - 3) / 2,
                      ),
                      borderColor: Colors.grey,
                      selectedBorderColor: kColorPrimary,
                      color: Colors.grey,
                      selectedColor: Colors.white,
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
                        return Center(
                          child: RichText(
                            text: TextSpan(
                              text: '${'semestre'.tr()} $tab',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: isSelected[tabs.indexOf(tab)]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<List<NoteModel>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Error: ${snapshot.error}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: RichText(
                              text: const TextSpan(
                                text: 'No data available.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return isSelected[0]
                              ? NoteCard(
                                  snapshot: snapshot.data!
                                      .where((note) => note.semestre == 1)
                                      .toList())
                              : NoteCard(
                                  snapshot: snapshot.data!
                                      .where((note) => note.semestre == 2)
                                      .toList());
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showInfo() async {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'infos'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: kColorDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'info.note.text2'.tr(
                  context: context,
                  namedArgs: {
                    'date': formatTimestamp(updateAt!, "dd MMMM yyyy à HH:mm"),
                  },
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: kColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'info.note.text3'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: kColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'info.note.text4'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: kColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'info.note.text5'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: kColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('info.note.back'.tr()),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

formatTimestamp(DateTime dateTime, String s) {}
