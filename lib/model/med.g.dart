// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Med _$MedFromJson(Map<String, dynamic> json) => Med(
      id: json['id'] as int? ?? 0,
      nome: json['nome'] as String,
      o2: json['o2'] as String,
      sat: json['sat'] as String,
      temp: json['temp'] as String,
      ph: json['ph'] as String,
    );

Map<String, dynamic> _$MedToJson(Med instance) => <String, dynamic>{
      //'id': instance.id,
      'nome': instance.nome,
      'o2': instance.o2,
      'sat': instance.sat,
      'temp': instance.temp,
      'ph': instance.ph,
    };
