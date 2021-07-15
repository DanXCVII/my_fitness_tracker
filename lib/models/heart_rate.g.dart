// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_rate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeartRateAdapter extends TypeAdapter<HeartRate> {
  @override
  final int typeId = 4;

  @override
  HeartRate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeartRate(
      (fields[0] as List).cast<DateTime>(),
      (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, HeartRate obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.heartRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
