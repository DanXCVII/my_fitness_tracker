import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_fitness_tracker/models/activity_group.dart';
import 'package:my_fitness_tracker/models/activity_light.dart';
import 'package:my_fitness_tracker/models/exercise.dart';
import 'package:my_fitness_tracker/models/heart_rate.dart';
import 'package:my_fitness_tracker/models/hive_models/hive_activity_sensor_data.dart';
import 'package:tuple/tuple.dart';

class ActivityFull extends Equatable {
  final String name;
  final String description;
  final String imagePath;
  // name, color, icon-/image-location
  final List<ActivityGroup> activityGroups;
  // name, color, icon-/image-location
  final List<Exercise> connectedExercises;
  final Tuple2<List<DateTime>, List<int>> heartRate;
  final int burnedCalories;
  final Duration duration;
  final DateTime time;
  final double distance;
  final int color;

  ActivityFull(
    this.name,
    this.description,
    this.imagePath,
    this.activityGroups,
    this.connectedExercises,
    this.heartRate,
    this.burnedCalories,
    this.duration,
    this.time,
    this.color, {
    this.distance = 0,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        imagePath,
        activityGroups,
        connectedExercises,
        heartRate,
        burnedCalories,
        duration,
        time,
        distance,
        color,
      ];

  ActivityLight getActivityLight() {
    return ActivityLight(
      name,
      description,
      imagePath,
      activityGroups,
      connectedExercises,
      burnedCalories,
      duration,
      time,
      color,
      distance: distance,
    );
  }

  HiveActivitySensorData getSensorData() {
    return HiveActivitySensorData(HeartRate(heartRate.item1, heartRate.item2));
  }
}
