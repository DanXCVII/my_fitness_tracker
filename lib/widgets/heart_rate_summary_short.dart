import 'package:flutter/material.dart';
import 'package:my_fitness_tracker/main.dart';

class HeartRateSummaryShort extends StatelessWidget {
  final int minRate;
  final int avgRate;
  final int maxRate;
  final double width;

  const HeartRateSummaryShort(
    this.minRate,
    this.avgRate,
    this.maxRate,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Color(0xff1D1D1D),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 1,
            spreadRadius: 0.5,
            color: Colors.black26,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: Image.asset("images/heart_rate.png"),
                ),
                Container(width: 15),
                Text(
                  "Heart Rate",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Container(height: 15),
            Container(
              height: 112,
              child: Stack(
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [200, 150, 100, 50]
                          .map<Widget>(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                width: width - 30,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 2,
                                      width: width - 64,
                                      color: Colors.grey,
                                    ),
                                    Container(width: e > 50 ? 5 : 12),
                                    Text(e.toString())
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList()),
                ]..addAll(
                    [0, 1, 2].map((e) {
                      int currentRate;
                      if (e == 0) {
                        currentRate = minRate;
                      } else if (e == 1) {
                        currentRate = avgRate;
                      } else {
                        currentRate = maxRate;
                      }
                      double height = currentRate / 200 * 112 - 8;
                      height = height < 0 ? 5 : height;

                      return Align(
                        alignment: Alignment(-0.8 + e * 0.6, 1),
                        child: Container(
                          width: 13,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
                  ),
              ),
            ),
            Container(height: 4),
            Row(
              children: [minRate, avgRate, maxRate]
                  .map<Widget>(
                    (e) => Padding(
                      padding: EdgeInsets.only(
                          right: e != maxRate ? (width - 16 * 2) / 16 : 4.5),
                      child: Column(
                        children: [
                          Text(
                            e.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            e == minRate
                                ? "min"
                                : e == avgRate
                                    ? "avg"
                                    : "max",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()
                    ..insert(0, Container(width: 11))
                    ..add(Text("bpm")),
            ),
          ],
        ),
      ),
    );
  }
}
