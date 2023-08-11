import 'dart:convert';

class FoodDTO {
  final double kcal;
  final double carb;
  final double prot;
  final double fat;
  final double fiber;
  final String name;
  final bool liquid;

  FoodDTO({
    required this.kcal,
    required this.carb,
    required this.prot,
    required this.fat,
    required this.fiber,
    required this.name,
    required this.liquid,
  });

  Map<String, dynamic> toMap() {
    return {
      'kcal': kcal,
      'carb': carb,
      'prot': prot,
      'fat': fat,
      'fiber': fiber,
      'name': name,
      'liquid': liquid,
    };
  }

  factory FoodDTO.fromMap(Map<String, dynamic> map) {
    return FoodDTO(
      kcal: map['kcal'],
      carb: map['carb'],
      prot: map['prot'],
      fat: map['fat'],
      fiber: map['fiber'],
      name: map['name'],
      liquid: map['liquid'],
    );
  }

  factory FoodDTO.fromJson(String jsonData) {
    return FoodDTO.fromMap(
      json.decode(jsonData),
    );
  }

  String toJson() => json.encode(toMap());
}
