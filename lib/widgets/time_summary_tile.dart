import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tuple/tuple.dart';

class TimeSummaryTile extends StatelessWidget {
  final double width;
  final DateTime time;
  final Duration duration;

  const TimeSummaryTile(
    this.width,
    this.time,
    this.duration, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 145,
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment(-1, -1),
              child: Text(
                "Time",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Align(
              alignment: Alignment(1, -1),
              child: DurationClock(time, duration),
            ),
            Align(
              alignment: Alignment(-1, 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    duration.inHours.toString() +
                        ":" +
                        (duration.inMinutes % 60).toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                  Container(width: 4),
                  Text("h")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationClock extends StatelessWidget {
  final DateTime time;
  final Duration duration;

  const DurationClock(
    this.time,
    this.duration, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: TimeClipper(time, duration),
          child: Container(
            height: 100,
            width: 100,
            color: Color(0xff74E4D0),
          ),
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 5,
              color: Colors.grey,
            ),
          ),
          child: Center(
            child: Transform.rotate(
              angle: (2 * pi) * (time.minute / 60),
              child: ClockStick(70, 3),
            ),
          ),
        ),
        Container(
          height: 100,
          width: 100,
          child: Center(
            child: Transform.rotate(
              angle: (2 * pi) * ((time.hour * 60 + time.minute) / (12 * 60)),
              child: ClockStick(40, 3),
            ),
          ),
        ),
      ],
    );
  }
}

class ClockStick extends StatelessWidget {
  final double size;
  final double width;

  const ClockStick(
    this.size,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: size / 2 + 5,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: size / 2 - 5,
        )
      ],
    );
  }
}

class TimeClipper extends CustomClipper<Path> {
  DateTime time;
  Duration duration;

  TimeClipper(this.time, this.duration);

  @override
  Path getClip(Size size) {
    double angleStartTime =
        ((time.hour * 60 + time.minute) / (12 * 60)) * (2 * pi);
    double angleEndTime =
        ((time.hour * 60 + time.minute + duration.inMinutes) / (12 * 60)) *
            (2 * pi);

    print(angleStartTime);
    print(angleEndTime);

    double xCoordStart = size.width / 2 * sin(angleStartTime);
    double yCoordStart = size.width / 2 * cos(angleStartTime);

    double xCoordEnd = size.width / 2 * sin(angleEndTime);
    double yCoordEnd = size.width / 2 * cos(angleEndTime);

    print(yCoordEnd - yCoordStart);

    final path = Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(xCoordStart + size.width / 2, -yCoordStart + size.width / 2)
      ..arcToPoint(
          Offset(xCoordEnd + size.width / 2, -yCoordEnd + size.width / 2),
          radius: Radius.circular(size.width / 2))
      ..lineTo(size.width / 2, size.width / 2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TimeClipper oldClipper) => true;
}
