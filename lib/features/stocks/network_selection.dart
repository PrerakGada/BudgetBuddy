import 'package:flutter/material.dart';

import '../../themes/palette.dart';

class StockSelection extends StatefulWidget {
  static const String id = '/networkselection';
  const StockSelection({super.key});

  @override
  State<StockSelection> createState() => _StockSelectionState();
}

class _StockSelectionState extends State<StockSelection> {
  final PageController _pageController = PageController();
  late int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Divider(thickness: 1),
              Flexible(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      selectedTab = value;
                    });
                  },
                  controller: _pageController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          NetworkGenreCard(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return NetworkingScreen(
                              //           title: 'Exlpore Geeks');
                              //     },
                              //   ),
                              // );
                            },
                            // imageUrl: '',
                            heading: 'Total Investment',
                            title: '₹ 43,898.00',
                            subTitle: 'Explore Tech Geeks',
                            isWide: true,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NetworkGenreCard(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return NetworkingScreen(
                                  //           title: 'Explore New Friends');
                                  //     },
                                  //   ),
                                  // );
                                },
                                // imageUrl: 'assets/grid/second.jpg',
                                heading: '',
                                title: 'AAPL',
                                subTitle: '-1.321%',
                              ),
                              NetworkGenreCard(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return NetworkingScreen(
                                  //           title: 'Exmplore Smarties');
                                  //     },
                                  //   ),
                                  // );
                                },
                                // imageUrl: 'assets/grid/third.jpg',
                                heading: '',
                                title: 'SIBN',
                                subTitle: '+0.1673%',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NetworkGenreCard(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return NetworkingScreen(
                                  //           title: '24h Coders');
                                  //     },
                                  //   ),
                                  // );
                                },
                                // imageUrl: 'assets/grid/seventh.jpg',
                                heading: '',
                                title: 'GOOGL',
                                subTitle: '-3.443%',
                              ),
                              NetworkGenreCard(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return NetworkingScreen(
                                  //           title: 'Free Right Now');
                                  //     },
                                  //   ),
                                  // );
                                },
                                // imageUrl: 'assets/grid/fifth.jpg',
                                heading: '',
                                title: 'TSLA',
                                subTitle: '+5.32%',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          NetworkGenreCard(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return NetworkingScreen(
                              //           title: 'Loyal Personalities');
                              //     },
                              //   ),
                              // );
                            },
                            // imageUrl: 'assets/grid/fourth.jpg',
                            heading: '',
                            title: 'Loyal Personality',
                            subTitle: 'Explore Loyal Techies',
                            isWide: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NetworkGenreCard extends StatelessWidget {
  const NetworkGenreCard({
    super.key,
    // required this.imageUrl,
    required this.heading,
    required this.title,
    required this.subTitle,
    this.isWide = false,
    required this.onTap,
  });

  // final String imageUrl;
  final bool isWide;
  final String title, heading;
  final String subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width:
            isWide ? double.infinity : MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: Colors.lightBlue.withOpacity(1),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Image.asset(
            //   imageUrl,
            //   width: double.infinity,
            //   fit: BoxFit.fitWidth,
            // ),
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Color(0x50000000),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 50),
                child: Text(
                  heading,
                  style: TextStyle(
                      fontSize: isWide ? 16 : 18,
                      fontWeight: FontWeight.bold,
                      color: Palette.grey),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: isWide ? 32 : 26,
                      fontWeight: FontWeight.bold,
                      color: Palette.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  subTitle,
                  style: TextStyle(
                      fontSize: isWide ? 24 : 18,
                      fontWeight: FontWeight.bold,
                      color: Palette.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
