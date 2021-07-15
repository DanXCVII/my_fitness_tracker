import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_fitness_tracker/models/activity_group.dart';
import 'package:my_fitness_tracker/models/activity_light.dart';
import 'package:my_fitness_tracker/models/exercise.dart';
import 'package:tuple/tuple.dart';

part 'hive_activity.g.dart';

@HiveType(typeId: 4)
class HiveActivity extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  // name, color, icon-/image-location
  @HiveField(4)
  final List<String> activityGroupKeys;
  // name, color, icon-/image-location
  @HiveField(5)
  final List<String> exerciseKeys;
  @HiveField(7)
  final int burnedCalories;
  @HiveField(8)
  final Duration duration;
  @HiveField(9)
  final String time;
  @HiveField(10)
  final double distance;
  @HiveField(11)
  final int color;

  HiveActivity(
    this.name,
    this.description,
    this.imagePath,
    this.activityGroupKeys,
    this.exerciseKeys,
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
        activityGroupKeys,
        exerciseKeys,
        burnedCalories,
        duration,
        time,
        distance,
        color,
      ];
}
