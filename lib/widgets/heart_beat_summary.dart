import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeartBeatSummary extends StatelessWidget {
  final Duration durationZoneOne;
  final Duration durationZoneTwo;
  final Duration durationZoneThree;
  final Duration durationZoneFour;
  final Duration durationZoneFive;
  final Duration totalDuration;

  const HeartBeatSummary(
    this.durationZoneOne,
    this.durationZoneTwo,
    this.durationZoneThree,
    this.durationZoneFour,
    this.durationZoneFive,
    this.totalDuration, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeartBeatItem(5, Color(0xffE30000), Color(0xffE30000),
              durationZoneFive, totalDuration, 200),
          HeartBeatItem(4, Color(0xffFFCA0D), Color(0xffFFCA0D),
              durationZoneFour, totalDuration, 200),
          HeartBeatItem(3, Color(0xff5BFF22), Color(0xff5BFF22),
              durationZoneThree, totalDuration, 200),
          HeartBeatItem(2, Color(0xff4299FF), Color(0xff4299FF),
              durationZoneTwo, totalDuration, 200),
          HeartBeatItem(1, Color(0xffB7B7B7), Color(0xffB7B7B7),
              durationZoneOne, totalDuration, 200),
        ],
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

  const HeartBeatItem(
    this.number,
    this.colorOne,
    this.colorTwo,
    this.zoneDuration,
    this.totalDuration,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          child: Center(
              child: Text(
            number.toString(),
            style: TextStyle(fontSize: 12),
          )),
          color: colorOne,
        ),
        Container(
          height: 16,
          width: 1,
          color: Colors.grey,
        ),
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          tween: Tween<double>(
              begin: 10,
              end: width * (zoneDuration.inSeconds / totalDuration.inSeconds)),
          builder: (_, double animatedSize, myChild) => Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [colorOne, colorTwo]),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            // duration: Duration(milliseconds: 200),
            height: 16,
            width: animatedSize,
          ),
        ),
        Spacer(),
        Text(
          (zoneDuration.inSeconds / totalDuration.inSeconds * 100)
                  .toStringAsFixed(0) +
              "%",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
