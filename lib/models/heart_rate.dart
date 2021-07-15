import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'heart_rate.g.dart';

@HiveType(typeId: 4)
class HeartRate extends Equatable {
  @HiveField(0)
  final List<DateTime> time;
  @HiveField(1)
  final List<int> heartRate;

  HeartRate(this.time, this.heartRate);

  @override
  List<Object?> get props => [time, heartRate];
}
