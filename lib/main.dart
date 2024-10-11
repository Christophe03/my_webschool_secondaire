import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_secondaire/app.dart';
import 'package:path_provider/path_provider.dart';

import 'utils/constants_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Configuration de Hive pour le stockage local
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // await Hive.openBox(hivedb);
  // await Hive.openBox(notificationTag);

  // Personnalisation de l'apparence de la barre de statut
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // Démarrage de l'application avec EasyLocalization pour la gestion des langues
  runApp(EasyLocalization(
    supportedLocales: const [Locale('fr'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('fr'),
    startLocale: const Locale('fr'),
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
}
