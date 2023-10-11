// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassWordModelAdapter extends TypeAdapter<PassWordModel> {
  @override
  final int typeId = 0;

  @override
  PassWordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PassWordModel(
      password: fields[0] as String?,
      complexity: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PassWordModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.complexity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassWordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
