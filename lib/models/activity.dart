import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Activity extends Equatable {
  final String name;
  final String description;
  final String imagePath;
  // name, color, icon-/image-location
  final List<Tuple3<String, Color, String>> activityGroups;
  // name, color, icon-/image-location
  final List<Tuple3<String, Color, String>> connectedExercises;
  final int burnedCalories;
  final Duration duration;
  final DateTime time;
  final double distance;
  final int color;

  Activity(
    this.name,
    this.description,
    this.imagePath,
    this.activityGroups,
    this.connectedExercises,
    this.burnedCalories,
    this.duration,
    this.time, this.color, {
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
