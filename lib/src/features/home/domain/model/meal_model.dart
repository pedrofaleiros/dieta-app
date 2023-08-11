import 'dart:convert';

import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';

class MealModel {
  final String id;
  final String name;
  final int hour;
  final int minutes;
  final List<ItemModel> items;

  MealModel({
    required this.id,
    required this.name,
    required this.hour,
    required this.minutes,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hour': hour,
      'minutes': minutes,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      name: map['name'],
      hour: map['hour'],
      minutes: map['minutes'],
      items: map['items'] == null
          ? []
          : (map['items'] as List)
              .map((itemMap) => ItemModel.fromMap(itemMap))
              .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String jsonData) {
    return MealModel.fromMap(
      json.decode(jsonData),
    );
  }
}
