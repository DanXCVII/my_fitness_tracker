// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final int typeId = 4;

  @override
  Activity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<ActivityGroup>(),
      (fields[5] as List).cast<Exercise>(),
      fields[6] as Tuple2<List<DateTime>, List<int>>,
      fields[7] as int,
      fields[8] as Duration,
      fields[9] as DateTime,
      fields[11] as int,
      distance: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.activityGroups)
      ..writeByte(5)
      ..write(obj.connectedExercises)
      ..writeByte(6)
      ..write(obj.heartRate)
      ..writeByte(7)
      ..write(obj.burnedCalories)
      ..writeByte(8)
      ..write(obj.duration)
      ..writeByte(9)
      ..write(obj.time)
      ..writeByte(10)
      ..write(obj.distance)
      ..writeByte(11)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
