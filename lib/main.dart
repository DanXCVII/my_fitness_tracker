import 'package:flutter/material.dart';
import 'package:my_fitness_tracker/models/activity.dart';
import 'package:my_fitness_tracker/widgets/activity_session_tile.dart';
import 'package:my_fitness_tracker/widgets/grouping_activity_type.dart';
import 'package:my_fitness_tracker/widgets/heart_beat_summary.dart';
import 'package:my_fitness_tracker/widgets/overview_tile.dart';
import 'package:tuple/tuple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double sidePadding = 12;
const double textPadding = 22;

const double headerSize = 20;

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xff1B1A22),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          // width: 220,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(sidePadding, 16, sidePadding, 0),
                child: GeneralInfo("Max Mustermann", 84, 1.93, 24),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(textPadding, sidePadding, 0, 0),
                child: Text(
                  "Weekly Summary",
                  style: TextStyle(fontSize: headerSize),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(sidePadding, sidePadding, 0, 0),
                child: WeeklySummary(8000, 11, Duration(hours: 10, minutes: 00),
                    143, MediaQuery.of(context).size.width - 16),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(textPadding, sidePadding, 0, 0),
                child: Text(
                  "All Activities",
                  style: TextStyle(fontSize: headerSize),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(sidePadding, 8, sidePadding, 0),
                child: HeartBeatSummary(
                  Duration(seconds: 300),
                  Duration(seconds: 500),
                  Duration(seconds: 800),
                  Duration(seconds: 600),
                  Duration(seconds: 200),
                  Duration(seconds: 2400),
                  // change to device width
                  MediaQuery.of(context).size.width - 24,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(textPadding, sidePadding, 0, 0),
                child: Text(
                  "Grouping",
                  style: TextStyle(fontSize: headerSize),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(sidePadding, 8, sidePadding, 0),
                child: GroupingActivityType(
                  {
                    Tuple3<String, Color, String>(
                      "strength",
                      Colors.blue,
                      "images/fire.png",
                    ): 4,
                    Tuple3<String, Color, String>(
                      "cardio",
                      Colors.red,
                      "images/fire.png",
                    ): 7
                  },
                  MediaQuery.of(context).size.width - 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(textPadding, 8, 0, 0),
                child: Text(
                  "Past Workouts",
                  style: TextStyle(fontSize: headerSize),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(sidePadding, 8, sidePadding, 0),
                child: ActivitySessionTile(
                    Activity(
                      "Strength Workout",
                      "legs, back",
                      "images/strength_icon.png",
                      [
                        Tuple3<String, Color, String>(
                            "strength", Colors.blue, "images/strength_icon.png")
                      ],
                      [
                        Tuple3<String, Color, String>("legs, back, workout 1",
                            Colors.blue, "images/strength_icon.png")
                      ],
                      1057,
                      Duration(seconds: 9572),
                      DateTime(2022, 2, 2),
                      0xff25BDFF,
                    ),
                    MediaQuery.of(context).size.width-(sidePadding*2)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralInfo extends StatelessWidget {
  final String name;
  final int weight;
  final double height;
  final int age;

  const GeneralInfo(
    this.name,
    this.weight,
    this.height,
    this.age, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(name, style: TextStyle(fontSize: 26))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              GeneralInfoItem(weight.toString(), "kg", "Weight"),
              Spacer(),
              Container(height: 25, width: 1, color: Colors.grey),
              Spacer(),
              GeneralInfoItem(height.toString(), "m", "Height"),
              Spacer(),
              Container(height: 25, width: 1, color: Colors.grey),
              Spacer(),
              GeneralInfoItem(age.toString(), "y. o.", "Age"),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class GeneralInfoItem extends StatelessWidget {
  final String value;
  final String unit;
  final String desc;

  const GeneralInfoItem(
    this.value,
    this.unit,
    this.desc, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, bottom: 3.0),
              child: Text(
                unit,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        Container(
          height: 6,
        ),
        Text(
          desc,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class WeeklySummary extends StatelessWidget {
  final int burnedCalories;
  final int amntSessions;
  final Duration activeTime;
  final int avgHeartRate;
  final double width;

  const WeeklySummary(
    this.burnedCalories,
    this.amntSessions,
    this.activeTime,
    this.avgHeartRate,
    this.width, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          Container(
              width: width / 2 - 10,
              child: OverviewTile(
                seperateNumber(burnedCalories),
                "kcal",
                "images/fire.png",
              )),
          Container(width: 12),
          Container(
              width: width / 2 - 10,
              child: OverviewTile(
                amntSessions.toString(),
                "sessions",
                "images/count.png",
              )),
        ],
      ),
      Container(height: 12),
      Row(
        children: [
          Container(
            width: width / 2 - 10,
            child: OverviewTile(
              activeTime.inHours.toString() +
                  ":" +
                  (activeTime.inMinutes % 60 == 0
                          ? "00"
                          : activeTime.inMinutes % 60)
                      .toString(),
              "h",
              "images/clock.png",
            ),
          ),
          Container(width: 12),
          Container(
            width: width / 2 - 10,
            child: OverviewTile(
              avgHeartRate.toString(),
              "avg. bpm",
              "images/heart_rate.png",
            ),
          ),
        ],
      )
    ]);
  }

  // add dot to seperate number above 1000
  String seperateNumber(int number) {
    String newNumber = number.toString();
    if (number >= 1000) {
      int thousandIdx = number.toString().length - 3;
      newNumber = number.toString().substring(0, thousandIdx) +
          "." +
          number.toString().substring(thousandIdx);
    }

    return newNumber;
  }
}
