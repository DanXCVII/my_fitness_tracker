// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveActivityAdapter extends TypeAdapter<HiveActivity> {
  @override
  final int typeId = 4;

  @override
  HiveActivity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveActivity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<String>(),
      (fields[5] as List).cast<String>(),
      fields[7] as int,
      fields[8] as Duration,
      fields[9] as String,
      fields[11] as int,
      distance: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HiveActivity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.activityGroupKeys)
      ..writeByte(5)
      ..write(obj.exerciseKeys)
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
      other is HiveActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
