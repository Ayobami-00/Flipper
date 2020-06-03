// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDataAdapter extends TypeAdapter<CardData> {
  @override
  CardData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardData(
      index: fields[0] as int,
      stay_flipped_open: fields[1] as bool,
      do_animation: fields[2] as bool,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.stay_flipped_open)
      ..writeByte(2)
      ..write(obj.do_animation)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
