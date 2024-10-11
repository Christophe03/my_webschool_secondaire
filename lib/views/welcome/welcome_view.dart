import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_secondaire/utils/constants_util.dart';
import 'package:my_webschool_secondaire/views/login/login_view.dart';
import 'package:my_webschool_secondaire/views/welcome/widgets/all_news.dart';
import 'package:my_webschool_secondaire/views/welcome/widgets/all_timesheet.dart';
import 'package:my_webschool_secondaire/widgets/drawer_wecome.dart';

import '../../services/notification_service.dart';
import '../../widgets/app_name.dart';
import '../notifications/notifications_view.dart';
import 'widgets/news.dart';
import 'widgets/timesheet.dart';
import 'widgets/titre_welcome.dart';
import 'widgets/user_name.dart';

import '../../../utils/next_screen.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  ScrollController? controller;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    // Votre logique de défilement, si nécessaire
  }

  @override
  Widget build(BuildContext context) {
    final userHive = Hive.box(hivedb);
    var userName = userHive.get('lastname') ?? '';
    var strName = userHive.get('sname') ?? '';

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: kColorPrimary,
              titleSpacing: 0,
              title: AppName(
                fontSize: 19.0,
                school: strName,
              ),
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
                    Icons.notifications,
                    color: kColorLight,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsView(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 5),
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
                key: const PageStorageKey('key0'),
                padding: const EdgeInsets.all(0),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    UserName(name: userName),
                    Visibility(
                      visible: true,
                      child: TitreWelcome(
                        title: 'quoi.de.neuf',
                        onPressed: () => nextScreen(context, const AllNews()),
                      ),
                    ),
                    // Remplacer la classe News par une version statique
                    const News(),
                    Visibility(
                      visible: true,
                      child: TitreWelcome(
                        title: 'emploi.du.temps',
                        onPressed: () {
                          nextScreen(context, const AllTimesheet());
                        },
                      ),
                    ),
                    // Remplacer la classe TimeSheet par une version statique
                    const TimeSheet(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
