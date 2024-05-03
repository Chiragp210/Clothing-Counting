// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cloths.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClothsAdapter extends TypeAdapter<Cloths> {
  @override
  final int typeId = 1;

  @override
  Cloths read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cloths(
      date: fields[0] as DateTime?,
      pants: fields[1] as int?,
      shirts: fields[2] as int?,
      tshirts: fields[3] as int?,
      shorts: fields[4] as int?,
      towel: fields[5] as int?,
      tracks: fields[6] as int?,
      covers: fields[7] as int?,
      total: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Cloths obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.pants)
      ..writeByte(2)
      ..write(obj.shirts)
      ..writeByte(3)
      ..write(obj.tshirts)
      ..writeByte(4)
      ..write(obj.shorts)
      ..writeByte(5)
      ..write(obj.towel)
      ..writeByte(6)
      ..write(obj.tracks)
      ..writeByte(7)
      ..write(obj.covers)
      ..writeByte(8)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
