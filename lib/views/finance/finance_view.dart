import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_secondaire/utils/string_util.dart';
import 'package:my_webschool_secondaire/widgets/circle_avatar.dart';
import '../../models/echeance_model.dart';
import '../../utils/constants_util.dart';
import '../../widgets/app_name.dart';
import '../../widgets/drawer_wecome.dart';
import 'widgets/finance_card.dart';
import 'widgets/finance_list.dart';

class FinanceView extends StatefulWidget {
  const FinanceView({super.key});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double net = 0;
  double paye = 0;
  DateTime? updateAt;

  @override
  void initState() {
    super.initState();
  }

  // Replace dynamic fetching with static data
  Future<List<EcheanceModel>> fetchData() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay

    // Sample static data
    List<EcheanceModel> echeances = [
      EcheanceModel(
          id: 1,
          ordre: 01,
          recu: "001",
          date: "2023-10-01",
          date_reglement: "2023-10-01",
          net: 100.0,
          montant_paye: 100.0,
          est_solde: "true"),
      EcheanceModel(
          id: 2,
          ordre: 02,
          recu: "002",
          date: "2023-10-05",
          date_reglement: null,
          net: 50.0,
          montant_paye: 0.0,
          est_solde: "false"),
      // Add more static entries as needed
    ];

    // Calculate net and paye values
    net = echeances.fold(
        0, (previousValue, element) => previousValue + (element.net ?? 0));
    paye = echeances.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.montant_paye ?? 0));

    return echeances;
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
                onPressed: () => updateAt != null ? showInfo() : null,
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
              // Perform refresh logic if needed
            },
            child: SingleChildScrollView(
              key: const PageStorageKey('key1'),
              padding: const EdgeInsets.all(0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder<List<EcheanceModel>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                                padding: EdgeInsets.only(top: 10),
                                child: CircularProgressIndicator()),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No data available.'),
                          );
                        } else {
                          return Column(
                            children: [
                              FinanceCard(
                                net: net,
                                paye: paye,
                              ),
                              FinanceList(snapshot: snapshot.data!),
                            ],
                          );
                        }
                      }),
                ],
              ),
            ),
          );
        },
      )),
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
                right: 15),
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
                      fontWeight: FontWeight.w600),
                ))),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                    text: TextSpan(
                  text: 'info.echeance.text2'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                const SizedBox(
                  height: 10,
                ),
                // Additional info display logic...
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('fermer'.tr()),
                ),
              ],
            )));
  }
}
