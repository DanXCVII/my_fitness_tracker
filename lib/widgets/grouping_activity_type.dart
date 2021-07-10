import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

class GroupingActivityType extends StatelessWidget {
  final Map<Tuple3<String, Color, String>, int> activities;
  final double width;

  const GroupingActivityType(
    this.activities,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxSessions =
        activities.keys.map((e) => activities[e] ?? 0).toList().reduce(max);

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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: activities.keys
              .map((e) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 27,
                              width: 27,
                              color: e.item2,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: Image.asset(
                                  e.item3,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                            tween: Tween<double>(
                              begin: 10,
                              end:
                                  (width - 79) * (activities[e]! / maxSessions),
                            ),
                            builder: (_, double animatedSize, myChild) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          )),
                                      // duration: Duration(milliseconds: 200),
                                      height: 27,
                                      width: animatedSize,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          activities[e].toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            e.item2,
                                            e.item2.withAlpha(150)
                                          ]),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          )),
                                      // duration: Duration(milliseconds: 200),
                                      height: 27,
                                      width: animatedSize,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      activities.keys.last == e
                          ? Container()
                          : Container(
                              height: 12,
                            ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
