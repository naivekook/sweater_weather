// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_by_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherByDayAdapter extends TypeAdapter<WeatherByDay> {
  @override
  final int typeId = 5;

  @override
  WeatherByDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherByDay(
      fields[0] as int,
      fields[1] as double,
      fields[2] as double,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherByDay obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.tempDay)
      ..writeByte(2)
      ..write(obj.tempNight)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherByDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
