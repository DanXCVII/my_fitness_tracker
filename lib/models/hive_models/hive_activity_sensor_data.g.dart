// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_activity_sensor_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveActivitySensorDataAdapter
    extends TypeAdapter<HiveActivitySensorData> {
  @override
  final int typeId = 5;

  @override
  HiveActivitySensorData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveActivitySensorData(
      fields[0] as HeartRate,
    );
  }

  @override
  void write(BinaryWriter writer, HiveActivitySensorData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.heartRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveActivitySensorDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
