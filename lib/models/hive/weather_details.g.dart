// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherDetailsAdapter extends TypeAdapter<WeatherDetails> {
  @override
  final int typeId = 3;

  @override
  WeatherDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherDetails(
      (fields[0] as List)?.cast<WeatherByHour>(),
      (fields[1] as List)?.cast<WeatherByDay>(),
      fields[2] as int,
      fields[3] as int,
      fields[4] as City,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.weatherByHour)
      ..writeByte(1)
      ..write(obj.weatherByDay)
      ..writeByte(2)
      ..write(obj.uvi)
      ..writeByte(3)
      ..write(obj.windDegree)
      ..writeByte(4)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
