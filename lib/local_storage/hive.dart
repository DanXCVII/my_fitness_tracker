import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:my_fitness_tracker/models/activity.dart';
import 'package:my_fitness_tracker/models/activity_group.dart';
import 'package:my_fitness_tracker/models/activity_light.dart';
import 'package:my_fitness_tracker/models/exercise.dart';
import 'package:my_fitness_tracker/models/heart_rate.dart';
import 'package:my_fitness_tracker/models/hive_models/hive_activity.dart';
import 'package:my_fitness_tracker/models/hive_models/hive_activity_sensor_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

class BoxNames {
  static final activities = "activities";
  static final exercises = "exercises";
  static final activityGroups = "acitivityGroups";
  static final sensorData = "sensorData";
}

Future<void> initHive(bool firstTime) async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(HeartRateAdapter());
  Hive.registerAdapter(HiveActivitySensorDataAdapter());
  Hive.registerAdapter(ActivityGroupAdapter());
  Hive.registerAdapter(HiveActivityAdapter());
  Hive.registerAdapter(ExerciseAdapter());

  await Future.wait([
    Hive.openLazyBox<HiveActivitySensorData>(BoxNames.sensorData),
    Hive.openBox<ActivityGroup>(BoxNames.activityGroups),
    Hive.openBox<Exercise>(BoxNames.exercises),
    Hive.openBox<HiveActivity>(BoxNames.activities),
  ]);

  // initializing with the must have values
  if (firstTime) {}
}

class HiveProvider {
  static final HiveProvider _singleton = HiveProvider._internal(
    Hive.lazyBox<HiveActivitySensorData>(BoxNames.sensorData),
    Hive.box<ActivityGroup>(BoxNames.activityGroups),
    Hive.box<Exercise>(BoxNames.exercises),
    Hive.box<HiveActivity>(BoxNames.activities),
  );

  LazyBox<HiveActivitySensorData> lazyBoxSensorData;
  Box<ActivityGroup> boxActivityGroups;
  Box<Exercise> boxExercises;
  Box<HiveActivity> boxActivities;

  factory HiveProvider() {
    return _singleton;
  }

  HiveProvider._internal(
    this.lazyBoxSensorData,
    this.boxActivityGroups,
    this.boxExercises,
    this.boxActivities,
  );

  Future<void> reopenBoxes() async {
    await lazyBoxSensorData.close();
    await boxActivityGroups.close();
    await boxExercises.close();
    await boxActivities.close();

    lazyBoxSensorData =
        await Hive.openLazyBox<HiveActivitySensorData>(BoxNames.sensorData);
    boxActivityGroups =
        await Hive.openBox<ActivityGroup>(BoxNames.activityGroups);
    boxExercises = await Hive.openBox<Exercise>(BoxNames.exercises);
    boxActivities = await Hive.openBox<HiveActivity>(BoxNames.activities);
  }

  Future<List<Tuple2<ActivityLight, bool>>> importActivities(
      List<ActivityFull> activities) async {
    List<Tuple2<ActivityLight, bool>> imports = [];
    for (ActivityFull a in activities) {
      bool added = await saveActivity(a);
      if (added) {
        imports.add(Tuple2(a.getActivityLight(), true));
      } else {
        imports.add(Tuple2(a.getActivityLight(), false));
      }
    }
    return imports;
  }

  Future<bool> saveActivity(ActivityFull activity) async {
    String activityKey = _getActivitiyKey(activity.name, activity.time);
    if (!lazyBoxSensorData.containsKey(activityKey)) {
      await lazyBoxSensorData.put(activityKey, activity.getSensorData());

      List<String> activityGroupKeys = [];
      for (ActivityGroup g in activity.activityGroups) {
        String groupKey = _getHiveKey(g.name);
        activityGroupKeys.add(groupKey);
        if (!boxActivityGroups.keys.contains(groupKey)) {
          await boxActivityGroups.put(groupKey, g);
        }
      }

      List<String> exerciseKeys = [];
      for (Exercise e in activity.connectedExercises) {
        String exerciseKey = _getHiveKey(e.name);
        exerciseKeys.add(exerciseKey);
        if (!boxExercises.keys.contains(exerciseKey)) {
          boxExercises.put(exerciseKey, e);
        }
      }

      HiveActivity newHiveActivity = HiveActivity(
        activity.name,
        activity.description,
        activity.imagePath,
        activityGroupKeys,
        exerciseKeys,
        activity.burnedCalories,
        activity.duration,
        activity.time.toIso8601String(),
        activity.color,
      );
      await boxActivities.put(activityKey, newHiveActivity);
      return true;
    } else {
      return false;
    }
  }

  Future<ActivityLight?> getActivityLight(
      {String? name, DateTime? time, String? hiveKey}) async {
    String activityKey;
    if (hiveKey != null) {
      activityKey = hiveKey;
    } else if (name != null && time != null) {
      activityKey = _getActivitiyKey(name, time);
    } else {
      activityKey = "";
    }

    HiveActivity? hiveActivity = boxActivities.get(activityKey);
    if (hiveActivity != null) {
      List<Exercise> activityExercises = [];
      for (String e in hiveActivity.exerciseKeys) {
        Exercise? exercise = boxExercises.get(e);
        if (exercise != null) {
          activityExercises.add(exercise);
        }
      }

      List<ActivityGroup> activityGroups = [];
      for (String g in hiveActivity.activityGroupKeys) {
        ActivityGroup? activityGroup = boxActivityGroups.get(g);
        if (activityGroup != null) {
          activityGroups.add(activityGroup);
        }
      }

      return ActivityLight(
          hiveActivity.name,
          hiveActivity.description,
          hiveActivity.imagePath,
          activityGroups,
          activityExercises,
          hiveActivity.burnedCalories,
          hiveActivity.duration,
          DateTime.parse(hiveActivity.time),
          hiveActivity.color);
    }
    return null;
  }

  Future<ActivityFull?> getActivity(
      {String? name, DateTime? time, String? hiveKey}) async {
    String activityKey;
    if (hiveKey != null) {
      activityKey = hiveKey;
    } else if (name != null && time != null) {
      activityKey = _getActivitiyKey(name, time);
    } else {
      activityKey = "";
    }

    ActivityLight? activityLight =
        await getActivityLight(name: name, time: time, hiveKey: hiveKey);
    if (activityLight != null) {
      HiveActivitySensorData? hs = await lazyBoxSensorData.get(activityKey);

      if (hs != null) {
        return ActivityFull(
            activityLight.name,
            activityLight.description,
            activityLight.imagePath,
            activityLight.activityGroups,
            activityLight.connectedExercises,
            Tuple2<List<DateTime>, List<int>>(
                hs.heartRate.time, hs.heartRate.heartRate),
            activityLight.burnedCalories,
            activityLight.duration,
            activityLight.time,
            activityLight.color);
      }
    }
    return null;
  }

  Future<List<ActivityLight>> getLastFewActivities(int amount) async {
    List<Tuple2<DateTime, String>> activityDates = boxActivities.keys
        .map<String>((e) => e)
        .map((e) =>
            Tuple2(DateTime.parse(e.substring(e.lastIndexOf("#") + 1)), e))
        .toList();

    List<ActivityLight> activities = [];
    activityDates.sort((eOne, eTwo) => eOne.item1.isAfter(eTwo.item1) ? 1 : -1);
    for (int i = 0; i < amount; i++) {
      ActivityLight? a =
          await getActivityLight(hiveKey: activityDates[i].item2);
      if (a != null) {
        activities.add(a);
      }
    }

    return activities;
  }

  ////////////// hive internal related //////////////
  String _getHiveKey(String name) {
    if (name.contains(RegExp(r"[^\x00-\x7F]+"))) {
      List<int> bytes = utf8.encode(name).toList();
      for (int i = 0; i < bytes.length; i++) {
        if (bytes[i] > 127) {
          bytes.insert(i + 1, bytes[i] - 127);
          bytes[i] = 127;
        }
      }

      return String.fromCharCodes(bytes);
    }
    return name;
  }

  String _getActivitiyKey(String activityName, DateTime time) {
    return _getHiveKey(activityName) + "#" + time.toIso8601String();
  }
}
