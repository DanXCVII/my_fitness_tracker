import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_fitness_tracker/models/activity.dart';
import 'package:my_fitness_tracker/utility.dart';
import 'package:tuple/tuple.dart';

class ActivitySessionTile extends StatelessWidget {
  final ActivityFull activity;
  final double width;

  const ActivitySessionTile(
    this.activity,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(activity.color)),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Image.asset("images/fire.png"),
                ) //Image.asset(activity.imagePath),
                ),
            Container(width: 10),
            Container(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width - 100,
                    child: Row(
                      children: [
                        Text(
                          activity.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          getWeekday(activity.time.day),
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    activity.description,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Spacer(),
                  Wrap(
                    children: []
                      ..addAll((List<Tuple3<String, Color, String>>.from(
                              activity.activityGroups)
                            ..addAll(activity.connectedExercises))
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: e.item2,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: Image.asset("images/fire.png",
                                      fit: BoxFit.contain),
                                ), //Image.asset(e.item3, fit: BoxFit.contain),
                              ),
                            ),
                          )
                          .toList())
                      ..add(
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Image.asset("images/fire.png"),
                                ),
                              ),
                              Text(activity.burnedCalories.toString()),
                              Container(width: 8)
                            ],
                          ),
                        ),
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
