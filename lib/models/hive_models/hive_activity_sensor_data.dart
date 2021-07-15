import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:my_fitness_tracker/models/heart_rate.dart';
import 'package:tuple/tuple.dart';

part 'hive_activity_sensor_data.g.dart';

@HiveType(typeId: 5)
class HiveActivitySensorData extends Equatable {
  @HiveField(0)
  final HeartRate heartRate;

  HiveActivitySensorData(this.heartRate);

  @override
  List<Object?> get props => [heartRate];
}
