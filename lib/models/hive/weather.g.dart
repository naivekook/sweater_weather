// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 2;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      fields[0] as int,
      fields[1] as double,
      fields[2] as double,
      fields[3] as String,
      fields[4] as String,
      fields[5] as int,
      fields[6] as int,
      fields[7] as double,
      fields[8] as int,
      fields[9] as int,
      fields[10] as int,
      fields[11] as City,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.tempFeelsLike)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.pressure)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.windSpeed)
      ..writeByte(8)
      ..write(obj.cloudiness)
      ..writeByte(9)
      ..write(obj.sunrise)
      ..writeByte(10)
      ..write(obj.sunset)
      ..writeByte(11)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
