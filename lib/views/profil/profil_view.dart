import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/constants_util.dart';
import '../../widgets/page_title.dart';
import 'widgets/actions_profil.dart';
import 'widgets/header_profil.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  // Données statiques pour remplacer Firebase
  final String staticUserId = '12345'; // ID utilisateur statique
  final String staticUserName = 'John Doe'; // Nom d'utilisateur statique

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Utilisation de données statiques au lieu de Hive
    var userid = staticUserId; // Utilisateur ID statique
    var userName = staticUserName; // Nom d'utilisateur statique

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          fontSize: 19.0,
          title: 'mon_profil'.tr(),
        ),
        backgroundColor: kColorPrimary,
        foregroundColor: kColorLight,
        centerTitle: true,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderProfil(
            uid: userid,
            title: userName,
            onTap: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const ActionsProfil(),
            ),
          )
        ],
      ),
    );
  }
}
