import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants_util.dart';
import '../../../utils/screem_util.dart';
import '../../../widgets/loading_cards.dart';
import 'news_card.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<News> {
  int listIndex = 0;

  // Static list of news data (replacing dynamic Firebase data)
  final List<Map<String, String>> staticData = [
    {
      'categorie': 'Technology',
      'message': 'Latest advancements in AI technology...',
      'sender': 'John Doe',
      'timestamp': '2024-10-11',
      'color': '#FF5733'
    },
    {
      'categorie': 'Health',
      'message': 'New health trends to watch in 2024...',
      'sender': 'Jane Smith',
      'timestamp': '2024-10-10',
      'color': '#33C4FF'
    },
    {
      'categorie': 'Education',
      'message': 'Top educational resources for remote learning...',
      'sender': 'Alice Johnson',
      'timestamp': '2024-10-09',
      'color': '#FF33B5'
    }
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = isDeviceTablet(context) ? 320 : 200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: h,
          width: w,
          child: PageView.builder(
            controller: PageController(initialPage: 0),
            scrollDirection: Axis.horizontal,
            itemCount: staticData.isEmpty ? 1 : staticData.length,
            onPageChanged: (index) {
              setState(() {
                listIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              if (staticData.isEmpty) {
                return const _EmptyContent();
              } else {
                // Passing static data to NewsCard widget
              }
            },
          ),
        ),
        const SizedBox(height: 5),
        Center(
          child: DotsIndicator(
            dotsCount: staticData.isEmpty ? 1 : staticData.length,
            position: listIndex,
            decorator: DotsDecorator(
              color: Colors.black26,
              activeColor: Theme.of(context).primaryColorDark,
              spacing: const EdgeInsets.only(left: 6),
              size: const Size.square(5.0),
              activeSize: const Size(20.0, 4.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
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
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: const Text(
          "Aucun contenu trouvé",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
