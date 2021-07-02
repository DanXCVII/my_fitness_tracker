import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

class GroupingActivityType extends StatelessWidget {
  final List<Tuple3<String, Color, int>> activities;
  final double width;

  const GroupingActivityType(
    this.activities,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxSessions = activities.map((e) => e.item3).toList().reduce(max);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: activities
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 15,
                          width: 15,
                          color: e.item2,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: Image.asset(
                              e.item1,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 12,
                      ),
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                            begin: 10, end: width * (e.item3 / maxSessions)),
                        builder: (_, double animatedSize, myChild) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  e.item3.toString(),
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: e.item2,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              // duration: Duration(milliseconds: 200),
                              height: 16,
                              width: animatedSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  activities.last == e
                      ? Container()
                      : Container(
                          height: 12,
                        ),
                ],
              ))
          .toList(),
    );
  }
}
