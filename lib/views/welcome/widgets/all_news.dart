import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_secondaire/models/news_model.dart';
import 'package:my_webschool_secondaire/utils/constants_util.dart';
import 'package:my_webschool_secondaire/views/welcome/widgets/news_card.dart';
import 'package:my_webschool_secondaire/widgets/app_name.dart';
import 'package:my_webschool_secondaire/widgets/loading_cards.dart';
import '../../../utils/screem_util.dart';

class AllNews extends StatefulWidget {
  const AllNews({Key? key}) : super(key: key);

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  bool fetching = true;
  List<NewsModel> news = [];

  // Utilisation de données statiques pour l'exemple
  void fetchData() async {
    setState(() {
      fetching = true;
    });

    // Simuler la récupération de données avec un délai
    await Future.delayed(const Duration(seconds: 1));

    // Données statiques
    news = [
      NewsModel(
          title: "Nouvelles mises à jour",
          description: "Découvrez les nouvelles fonctionnalités de l'app.",
          message:
              "Voici les dernières nouvelles concernant notre application."),
      NewsModel(
          title: "Mise à jour importante",
          description: "Assurez-vous de mettre à jour l'application.",
          message: "Une nouvelle mise à jour est disponible."),
    ];

    setState(() {
      fetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Charger les données statiques au démarrage
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = isDeviceTablet(context) ? 320 : 200;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kColorPrimary,
        titleSpacing: 0,
        title: AppName(
          fontSize: 19.0,
          school: "quoi.de.neuf".tr(),
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
            // Simuler une nouvelle récupération de données statiques
            fetchData();
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: news.isEmpty
                    ? fetching
                        ? Column(
                            children: [
                              SizedBox(
                                  height: h,
                                  width: w,
                                  child: const LoadingFeaturedCard()),
                              SizedBox(
                                  height: h,
                                  width: w,
                                  child: const LoadingFeaturedCard()),
                              SizedBox(
                                  height: h,
                                  width: w,
                                  child: const LoadingFeaturedCard()),
                            ],
                          )
                        : const _EmptyContent()
                    : ListView(
                        children: [
                          ...news.map((e) {
                            return SizedBox(
                              height: h,
                              width: w,
                              child: NewsCard(d: e, heroTag: 'news'),
                            );
                          })
                        ],
                      ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: kColorPrimary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5)),
      child: const Center(
        child: Text(
          "Aucun contenu trouvé",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
