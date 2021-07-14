import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_fitness_tracker/models/activity_group.dart';
import 'package:my_fitness_tracker/models/activity_light.dart';
import 'package:my_fitness_tracker/models/exercise.dart';
import 'package:tuple/tuple.dart';

part 'activity.g.dart';

@HiveType(typeId: 4)
class Activity extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  // name, color, icon-/image-location
  @HiveField(4)
  final List<ActivityGroup> activityGroups;
  // name, color, icon-/image-location
  @HiveField(5)
  final List<Exercise> connectedExercises;
  @HiveField(6)
  final Tuple2<List<DateTime>, List<int>> heartRate;
  @HiveField(7)
  final int burnedCalories;
  @HiveField(8)
  final Duration duration;
  @HiveField(9)
  final DateTime time;
  @HiveField(10)
  final double distance;
  @HiveField(11)
  final int color;

  Activity(
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
}
