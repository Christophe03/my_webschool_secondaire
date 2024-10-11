import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_secondaire/utils/string_util.dart';
import 'package:my_webschool_secondaire/views/welcome/widgets/about.dart';

import '../../../models/news_model.dart';
import '../../../utils/constants_util.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../utils/screem_util.dart';

class NewsCard extends StatelessWidget {
  final NewsModel d;
  final heroTag;

  // Ajout de données statiques pour la news
  final List<NewsModel> staticNews = [
    NewsModel(
        categorie: "Education",
        message: "Un nouvel article sur l'importance de l'éducation...",
        sender: "John Doe",
        timestamp: DateTime.now().toString(),
        color: "#FF5733"),
    // Ajouter plus de données statiques si nécessaire
  ];

  const NewsCard({super.key, required this.d, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    int maxLine = isDeviceTablet(context) ? 11 : 4;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ]),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: hexToColor(d.color!).withOpacity(0.7)),
                  child: RichText(
                      text: TextSpan(
                    text: d.categorie!.toCapitalized(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: RichText(
                                  text: TextSpan(
                                text: d.message!,
                                style: const TextStyle(
                                  color: kColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ))),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.person,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: d.sender!,
                                  style: TextStyle(
                                      fontSize: 16, color: kColorPrimary)))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.time,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: timeAgoSinceDate(d.timestamp!),
                                  style: const TextStyle(
                                      fontSize: 13, color: kColorDark)))
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
      onTap: () => {
        showModalBottomSheet(
            context: context,
            elevation: 5,
            isScrollControlled: true,
            builder: (_) => Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: hexToColor(d.color!).withOpacity(0.7)),
                        child: RichText(
                            text: TextSpan(
                          text: d.categorie!.toCapitalized(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: RichText(
                              text: TextSpan(
                            text: d.message!,
                            style: const TextStyle(
                              color: kColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        hexToColor(d.color!).withOpacity(0.7)),
                              ),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'fermer'.tr(),
                                      style: const TextStyle(fontSize: 16))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ]),
                    ])))
      },
    );
  }
}
