import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 2)
class Exercise extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int color;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  final List<String> exercises;

  Exercise(
    this.name,
    this.color,
    this.imagePath,
    this.exercises,
  );

  @override
  List<Object?> get props => [
        name,
        color,
        imagePath,
        exercises,
      ];
}
