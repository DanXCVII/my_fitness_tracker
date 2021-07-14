import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:my_fitness_tracker/models/activity_group.dart';
import 'package:my_fitness_tracker/models/exercise.dart';
import 'package:tuple/tuple.dart';

class ActivityLight extends Equatable {
  final String name;
  final String description;
  final String imagePath;
  // name, color, icon-/image-location
  final List<ActivityGroup> activityGroups;
  // name, color, icon-/image-location
  final List<Exercise> connectedExercises;
  final int burnedCalories;
  final Duration duration;
  final DateTime time;
  final double distance;
  final int color;

  ActivityLight(
    this.name,
    this.description,
    this.imagePath,
    this.activityGroups,
    this.connectedExercises,
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
        burnedCalories,
        duration,
        time,
        distance,
        color,
      ];
}
