// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodStorageAdapter extends TypeAdapter<BloodStorage> {
  @override
  final int typeId = 1;

  @override
  BloodStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodStorage(
      token: fields[0] as String,
      phoneNumber: fields[1] as String,
      requestID: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BloodStorage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.requestID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
