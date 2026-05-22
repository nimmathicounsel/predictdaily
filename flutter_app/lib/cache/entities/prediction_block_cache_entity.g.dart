// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_block_cache_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PredictionBlockCacheEntityAdapter
    extends TypeAdapter<PredictionBlockCacheEntity> {
  @override
  final int typeId = 1;

  @override
  PredictionBlockCacheEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PredictionBlockCacheEntity(
      cacheKey: fields[0] as String,
      janmaStar: fields[1] as int,
      date: fields[2] as DateTime,
      starIndices: (fields[3] as List).cast<int>(),
      sunriseTime: fields[4] as DateTime,
      dayStarEndTime: fields[5] as DateTime,
      grahas: (fields[6] as List).cast<int>(),
      cachedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PredictionBlockCacheEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cacheKey)
      ..writeByte(1)
      ..write(obj.janmaStar)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.starIndices)
      ..writeByte(4)
      ..write(obj.sunriseTime)
      ..writeByte(5)
      ..write(obj.dayStarEndTime)
      ..writeByte(6)
      ..write(obj.grahas)
      ..writeByte(7)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredictionBlockCacheEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
