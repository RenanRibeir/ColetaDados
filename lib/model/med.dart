import 'package:json_annotation/json_annotation.dart';
part 'med.g.dart';

@JsonSerializable()
class Med {
  int id;
  String nome;
  String o2;
  String sat;
  String temp;
  String ph;

  Med({
    this.id = 0,
    required this.nome,
    required this.o2,
    required this.sat,
    required this.temp,
    required this.ph,
  });

  @override
  String toString() {
    return "Med{id: $id, nome: $nome, o2: $o2, sat: $sat, temp: $temp, ph: $ph}";
  }

  factory Med.fromJson(Map<String, dynamic> json) => _$MedFromJson(json);
  Map<String, dynamic> toJson() => _$MedToJson(this);
}
