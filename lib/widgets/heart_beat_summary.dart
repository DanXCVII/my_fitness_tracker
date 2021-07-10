import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeartBeatSummary extends StatelessWidget {
  final Duration durationZoneOne;
  final Duration durationZoneTwo;
  final Duration durationZoneThree;
  final Duration durationZoneFour;
  final Duration durationZoneFive;
  final Duration totalDuration;
  final double width;

  const HeartBeatSummary(
    this.durationZoneOne,
    this.durationZoneTwo,
    this.durationZoneThree,
    this.durationZoneFour,
    this.durationZoneFive,
    this.totalDuration,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxDuration = [
      durationZoneOne.inSeconds,
      durationZoneTwo.inSeconds,
      durationZoneThree.inSeconds,
      durationZoneFour.inSeconds,
      durationZoneFive.inSeconds,
    ].reduce(max);

    return Container(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            child: Column(
              children: [
                HeartBeatItem(
                  5,
                  Color(0xffE30000),
                  Color(0xffE30000),
                  durationZoneFive,
                  totalDuration,
                  width,
                  maxDuration,
                ),
                HeartBeatItem(
                  4,
                  Color(0xffFFCA0D),
                  Color(0xffFFCA0D),
                  durationZoneFour,
                  totalDuration,
                  width,
                  maxDuration,
                ),
                HeartBeatItem(
                  3,
                  Color(0xff5BFF22),
                  Color(0xff5BFF22),
                  durationZoneThree,
                  totalDuration,
                  width,
                  maxDuration,
                ),
                HeartBeatItem(
                  2,
                  Color(0xff4299FF),
                  Color(0xff4299FF),
                  durationZoneTwo,
                  totalDuration,
                  width,
                  maxDuration,
                ),
                HeartBeatItem(
                  1,
                  Color(0xffB7B7B7),
                  Color(0xffB7B7B7),
                  durationZoneOne,
                  totalDuration,
                  width,
                  maxDuration,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeartBeatItem extends StatelessWidget {
  final Color colorOne;
  final Color colorTwo;
  final int number;
  final Duration totalDuration;
  final Duration zoneDuration;
  final double width;
  final int maxDuration;

  const HeartBeatItem(
    this.number,
    this.colorOne,
    this.colorTwo,
    this.zoneDuration,
    this.totalDuration,
    this.width,
    this.maxDuration, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          child: Center(
              child: Text(
            number.toString(),
            style: TextStyle(fontSize: 20),
          )),
          color: colorOne,
        ),
        Container(
          height: 25,
          width: 1,
          color: Colors.grey,
        ),
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          tween: Tween<double>(
              begin: 10,
              end: (width - 110) *
                  (zoneDuration.inSeconds / maxDuration * 0.75)),
          builder: (_, double animatedSize, myChild) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [colorOne, colorTwo]),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                // duration: Duration(milliseconds: 200),
                height: 25,
                width: animatedSize,
              ),
              Container(
                width: 8,
              ),
              Container(
                height: 1,
                width: width - 110 - animatedSize,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Spacer(),
        Text(
          (zoneDuration.inSeconds / totalDuration.inSeconds * 100)
                  .toStringAsFixed(0) +
              "%",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
