// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityGroupAdapter extends TypeAdapter<ActivityGroup> {
  @override
  final int typeId = 1;

  @override
  ActivityGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityGroup(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityGroup obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
