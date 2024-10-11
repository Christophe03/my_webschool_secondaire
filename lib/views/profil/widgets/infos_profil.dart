import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_name.dart';
import '../../../utils/constants_util.dart';

class InfosProfilPopup extends StatefulWidget {
  const InfosProfilPopup({super.key});

  @override
  _InfosProfilPopupState createState() => _InfosProfilPopupState();
}

class _InfosProfilPopupState extends State<InfosProfilPopup> {
  // Define static user data
  final String nom = "Diarra";
  final String prenom = "Toumany";
  final String sexe = "Masculin";
  final String lieu_naiss = "Kati";
  final String email = "tchristophe@sitaninfo.com";
  final String tel1 = "+223 70 42 46 51";
  final String tel2 = "+223 96 85 52 82";
  final String ville = "Bamako";
  final String adresse = "Avenue Moussa Tavele";
  final String date_naiss = "17/03/1998";
  final String etablissement = "Institut Universitaire de Gestion";
  final String annee_acc = "2023";
  final String formation = "Bachelor en Marketing et Communication";
  final String code = "123456";
  final String niveau = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppName(
          fontSize: 19.0,
          school: 'vos.informations'.tr(),
        ),
        backgroundColor: kColorPrimary,
        foregroundColor: kColorLight,
        iconTheme: const IconThemeData(color: kColorLight),
      ),
      body: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Repeating Row Widgets for displaying user data
            _buildInfoRow('matricule', code),
            const SizedBox(height: 20),
            _buildInfoRow('prenom', prenom),
            const SizedBox(height: 20),
            _buildInfoRow('nom', nom),
            const SizedBox(height: 20),
            _buildInfoRow('sexe', sexe),
            const SizedBox(height: 20),
            _buildInfoRow('date.naissance', date_naiss),
            const SizedBox(height: 20),
            _buildInfoRow('lieu.naissance', lieu_naiss),
            const SizedBox(height: 20),
            _buildInfoRow('telephone1', tel1),
            const SizedBox(height: 20),
            _buildInfoRow('telephone2', tel2),
            const SizedBox(height: 20),
            _buildInfoRow('email', email),
            const SizedBox(height: 20),
            _buildInfoRow('ville', ville),
            const SizedBox(height: 20),
            _buildInfoRow('adresse', adresse),
            const SizedBox(height: 20),
            Divider(height: 3, color: Colors.grey[400]),
            Container(
              decoration: const BoxDecoration(
                color: kColorPrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  _buildNiveauAndFormation(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String labelKey, String value) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: labelKey.tr(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: kColorDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              text: value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: kColorPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNiveauAndFormation() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: niveau,
            style: const TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 14,
              color: kColorLight,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              const TextSpan(
                text: ' ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: kColorPrimaryDark,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: niveau == '1' ? 'iere'.tr() : 'ieme'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: kColorLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(
                text: ' ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: kColorPrimaryDark,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'annee'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: kColorLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: formation,
            style: const TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 14,
              color: kColorLight,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: annee_acc,
            style: const TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 14,
              color: kColorLight,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: etablissement,
            style: const TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 14,
              color: kColorLight,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
