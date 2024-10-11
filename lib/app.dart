import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/theme_model.dart';
import 'nav_obs.dart';
import 'providers/internet_provider.dart';
import 'providers/news_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/sign_in_provider.dart';
import 'routes/route_generator.dart';
import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Gestion de la connectivité Internet
        ChangeNotifierProvider<InternetProvider>(
            create: (context) => InternetProvider()),
        // Gestion de la connexion utilisateur
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(),
        ),
        // Gestion des notifications
        ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider()),
        // Gestion des actualités
        ChangeNotifierProvider<NewsProvider>(
            create: (context) => NewsProvider()),
      ],
      child: MaterialApp(
        // Localisation et internationalisation
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,

        // Gestion des routes
        initialRoute: Routes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [NavObs()],

        // Thème clair et sombre
        theme: ThemeModel().greenMode,
        darkTheme: ThemeModel()
            .greenMode, // Peut-être configuré avec un thème sombre séparé

        // Désactiver le bandeau de mode debug
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
