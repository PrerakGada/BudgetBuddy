import 'package:budget_buddy/providers/NewsProvider.dart';
import 'package:budget_buddy/providers/StockProvider.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:budget_buddy/utils/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});
  static const String id = '/stocks';

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  List<String> ranges = [
    "1d",
    "5d",
    "1mo",
    "3mo",
    "6mo",
    "1y",
    "2y",
    "5y",
    "10y",
  ];

  int currentRange = 0;

  @override
  Widget build(BuildContext context) {
    List<News> news = Provider.of<NewsProvider>(context, listen: false).news;

    SizeConfig(context);
    return FutureBuilder(
        future: StockProvider.getStock(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "SBIN",
                        style: TextStyle(
                          fontSize: 24,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // SizedBox(
                      //   height: 40,
                      //   child: Consumer<NewsProvider>(
                      //       builder: (_, provider, __) {
                      //     return ListView.builder(
                      //       itemCount: provider.news.length,
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (context, index) => Row(
                      //         children: [
                      //           GestureDetector(
                      //             onTap: () {
                      //               setState(() {
                      //                 currentRange = index;
                      //               });
                      //             },
                      //             child: Text(
                      //               ranges[index],
                      //               style: TextStyle(
                      //                 fontSize: 16,
                      //                 color: currentRange == index
                      //                     ? Palette.white
                      //                     : Palette.greyDark,
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10),
                      //         ],
                      //       ),
                      //     );
                      //   }),
                      // ),
                      if (snapshot.hasData)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: chartCreater(snapshot.data!),
                        ),
                      if (!snapshot.hasData)
                        Column(
                          children: const [
                            SizedBox(height: 40),
                            Center(
                              child: CircularProgressIndicator(
                                  color: Palette.primary),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      if (snapshot.hasData)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: stockInfo(snapshot),
                        ),
                      const SizedBox(height: 20),
                      const Text(
                        "News",
                        style: TextStyle(
                          fontSize: 18,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        news.length,
                        (index) => NewItem(
                            title: news[index].title,
                            desc: news[index].description,
                            imageUrl: news[index].image,
                            index: index,
                            url: news[index].url),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Row stockInfo(AsyncSnapshot<Chart> snapshot) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Column(
            children: [
              StockInfoItem(
                title: "Open",
                value: double.parse(
                  snapshot.data!.open[snapshot.data!.open.length - 1]
                      .toString(),
                ),
              ),
              const SizedBox(height: 10),
              StockInfoItem(
                title: "High",
                value: double.parse(
                  snapshot.data!.high[snapshot.data!.high.length - 1]
                      .toString(),
                ),
              ),
              const SizedBox(height: 10),
              StockInfoItem(
                title: "Low",
                value: double.parse(
                  snapshot.data!.low[snapshot.data!.low.length - 1].toString(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 1,
          height: 60,
          color: Palette.white.withOpacity(0.3),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 120,
          child: Column(
            children: [
              StockInfoItem(
                title: "Close",
                value: double.parse(
                  snapshot.data!.close[snapshot.data!.close.length - 1]
                      .toString(),
                ),
              ),
              const SizedBox(height: 10),
              StockInfoItem(
                title: "RMP",
                value: double.parse(
                  snapshot.data!.regularMarketPrice.toString(),
                ),
              ),
              const SizedBox(height: 10),
              StockInfoItem(
                title: "PC",
                value: double.parse(
                  snapshot.data!.previousClose.toString(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 1,
          height: 60,
          color: Palette.white.withOpacity(0.3),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 120,
          child: Column(
            children: [
              StockInfoItem(
                title: "EOD",
                value: double.parse(
                  snapshot.data!.open[snapshot.data!.open.length - 1]
                      .toString(),
                ),
              ),
              const SizedBox(height: 10),
              StockInfoItem(
                title: "HOD",
                value: double.parse(
                  snapshot.data!.high[snapshot.data!.high.length - 1]
                      .toString(),
                ),
              ),
              const SizedBox(height: 10),
              StockInfoItem(
                title: "LOD",
                value: double.parse(
                  snapshot.data!.low[snapshot.data!.low.length - 1].toString(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget chartCreater(Chart futureStock) {
    return Container(
      width: SizeConfig.width,
      height: 200,
      decoration: BoxDecoration(
        color: Palette.greyDarker,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: candleStickCreater(
            futureStock.timestamp.reversed.toList(),
            futureStock.open.reversed.toList(),
            futureStock.close.reversed.toList(),
            futureStock.high.reversed.toList(),
            futureStock.low.reversed.toList(),
            futureStock.volume.reversed.toList()),
      ),
    );
  }

  Candlesticks candleStickCreater(
    List<dynamic> timestamp,
    List<dynamic> open,
    List<dynamic> close,
    List<dynamic> high,
    List<dynamic> low,
    List<dynamic> volume,
  ) {
    late List<double> newOpen, newClose, newHigh, newLow, newVolume;
    late List<DateTime> newTimestamp;

    double getPreviousFinite(int index, List<dynamic> list) {
      while (list[index] == null) {
        if (index == 0) break;
        index--;
      }

      if (index == 0 && list[index] == null) {
        while (list[index] == null) {
          if (index == list.length - 1) break;
          index++;
        }
      }
      return double.parse(list[index].toString());
    }

    newTimestamp = List<DateTime>.generate(timestamp.length, (index) {
      return timestamp[index] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(timestamp[index] * 1000);
    });
    newOpen = List<double>.generate(open.length, (index) {
      return open[index] == null
          ? getPreviousFinite(index, open)
          : double.parse(open[index].toString());
    });
    newClose = List<double>.generate(close.length, (index) {
      return close[index] == null
          ? getPreviousFinite(index, close)
          : double.parse(close[index].toString());
    });
    newHigh = List<double>.generate(close.length, (index) {
      return close[index] == null
          ? getPreviousFinite(index, high)
          : double.parse(close[index].toString());
    });
    newLow = List<double>.generate(close.length, (index) {
      return low[index] == null
          ? getPreviousFinite(index, low)
          : double.parse(low[index].toString());
    });
    newVolume = List<double>.generate(volume.length, (index) {
      return volume[index] == null
          ? getPreviousFinite(index, volume)
          : double.parse(volume[index].toString());
    });

    return Candlesticks(
        candles: List<Candle>.generate(
            newTimestamp.length,
            (index) => Candle(
                date: newTimestamp[index],
                high: newHigh[index],
                low: newLow[index],
                open: newOpen[index],
                close: newClose[index],
                volume: newVolume[index])));
  }
}

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.index,
    required this.url,
  });
  final String title, desc, imageUrl, url;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse(url));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Palette.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Palette.greyDark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${index + 1}h ago",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Palette.greyDark,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class StockInfoItem extends StatelessWidget {
  const StockInfoItem({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Palette.greyDark,
          ),
        ),
        Text(
          "₹ ${value.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 14,
            color: Palette.white,
          ),
        ),
      ],
    );
  }
}
