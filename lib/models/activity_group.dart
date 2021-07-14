import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'activity_group.g.dart';

@HiveType(typeId: 1)
class ActivityGroup extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int color;
  @HiveField(2)
  final String imagePath;

  ActivityGroup(
    this.name,
    this.color,
    this.imagePath,
  );

  @override
  List<Object?> get props => [
        name,
        color,
        imagePath,
      ];
}
