// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scores_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoresDataAdapter extends TypeAdapter<ScoresData> {
  @override
  ScoresData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoresData(
      username: fields[0] as String,
      score: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScoresData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
