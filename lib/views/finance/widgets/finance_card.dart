import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_secondaire/widgets/app_name.dart';
import 'package:my_webschool_secondaire/widgets/drawer_wecome.dart';

import '../../../utils/constants_util.dart';
import '../../../utils/string_util.dart';
import '../../../models/echeance_model.dart';

class FinanceCard extends StatelessWidget {
  final double net;
  final double paye;

  const FinanceCard({super.key, required this.net, required this.paye});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: kColorPrimary,
        border: Border.all(
          color: kColorPrimaryDark,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'montant.a.payer'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kColorLight),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'montant.paye'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kColorLight),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'reste.a.payer'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kColorLight),
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: formatDoubleWithThousandSeparator(net),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: kColorLight),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " CFA",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: kColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: formatDoubleWithThousandSeparator(paye),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: kColorLight),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " CFA",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: kColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: formatDoubleWithThousandSeparator(net - paye),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: kColorAmber),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " CFA",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: kColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class FinanceView extends StatefulWidget {
  const FinanceView({super.key});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double net = 1000; // Valeur statique pour net
  double paye = 400; // Valeur statique pour paye

  @override
  void initState() {
    super.initState();
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
              school: 'situation.financiere'.tr(),
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
                onPressed: () {},
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
      }, body: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
            onRefresh: () async {
              // Vous pouvez mettre à jour les données statiques ici si nécessaire
            },
            child: SingleChildScrollView(
              key: const PageStorageKey('key1'),
              padding: const EdgeInsets.all(0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  FinanceCard(
                    net: net,
                    paye: paye,
                  ),
                  // Ajoutez d'autres widgets si nécessaire
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
