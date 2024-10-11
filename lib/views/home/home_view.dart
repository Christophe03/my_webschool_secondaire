import 'package:easy_localization/easy_localization.dart'; // Pour la gestion des traductions
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour les services système
import 'package:provider/provider.dart'; // Pour la gestion des états avec Provider
import 'package:my_webschool_secondaire/views/finance/finance_view.dart';
import 'package:my_webschool_secondaire/views/profil/profil_view.dart';
import 'package:my_webschool_secondaire/views/welcome/welcome_view.dart';

import '../../providers/notification_provider.dart'; // Provider pour les notifications
import '../../services/notification_service.dart'; // Service de gestion des notifications
import '../note/note_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0; // Index actuel du tab bar
  PageController _pageController =
      PageController(); // Contrôleur pour gérer les pages

  @override
  void initState() {
    super.initState();
    // Initialisation des services au lancement, sans Firebase
  }

  // Méthode pour gérer les changements de page lors du tap sur un onglet
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Animation vers la page correspondante
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Libérer le contrôleur de page lors de la fermeture
    super.dispose();
  }

  // Méthode pour gérer l'action de retour en arrière
  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      // Quitter l'application si l'utilisateur est sur la page principale
      await SystemChannels.platform
          .invokeMethod<void>('SystemNavigator.pop', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _onWillPop(), // Gérer le retour physique
      child: Scaffold(
        bottomNavigationBar:
            _bottomNavigationBar(), // Barre de navigation en bas
        body: PageView(
          controller: _pageController, // Gérer la navigation entre les pages
          allowImplicitScrolling: false, // Empêcher le défilement implicite
          physics:
              const NeverScrollableScrollPhysics(), // Désactiver le défilement manuel
          children: const <Widget>[
            WelcomeView(), // Vue d'accueil
            NoteView(), // Vue pour les notes
            FinanceView(), // Vue pour les finances
            ProfilView(), // Vue du profil utilisateur
          ],
        ),
      ),
    );
  }

  // Méthode pour créer la barre de navigation inférieure
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Type de navigation fixe
      onTap: (index) => onTabTapped(index), // Gestion des taps sur les onglets
      currentIndex: _currentIndex, // Index actuel de l'onglet sélectionné
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 25, // Taille des icônes
      selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600), // Style du texte sélectionné
      unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600), // Style du texte non sélectionné
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: const Icon(Icons.home), label: 'home'.tr() // Onglet Accueil
            ),
        BottomNavigationBarItem(
            icon: const Icon(Icons.format_list_numbered_rtl),
            label: 'notes'.tr() // Onglet Notes
            ),
        BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on),
            label: 'finances'.tr() // Onglet Finances
            ),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'profil'.tr() // Onglet Profil
            ),
      ],
    );
  }
}
