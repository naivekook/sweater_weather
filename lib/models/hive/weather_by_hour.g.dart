// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_by_hour.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherByHourAdapter extends TypeAdapter<WeatherByHour> {
  @override
  final int typeId = 4;

  @override
  WeatherByHour read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherByHour(
      fields[0] as int,
      fields[1] as double,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherByHour obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherByHourAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
