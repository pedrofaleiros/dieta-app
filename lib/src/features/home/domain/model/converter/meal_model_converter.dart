import 'dart:convert';

import 'package:macros_app/src/features/home/domain/model/converter/converter_interface.dart';
import 'package:mobx/mobx.dart';

import '../item_model.dart';
import '../meal_model.dart';

class MealModelConverter implements IConverter<MealModel> {
  @override
  Map<String, dynamic> toMap(MealModel meal) {
    return {
      'id': meal.id,
      'name': meal.name,
      'hour': meal.hour,
      'minutes': meal.minutes,
      'items': meal.items.map((item) => item.toMap()).toList(),
    };
  }

  @override
  MealModel fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      name: map['name'],
      hour: map['hour'],
      minutes: map['minutes'],
      items: map['items'] == null
          ? ObservableList<ItemModel>()
          : (map['items'] as List)
              .map((itemMap) => ItemModel.fromMap(itemMap))
              .toList()
              .asObservable(),
    );
  }

  @override
  String toJson(MealModel meal) => json.encode(toMap(meal));

  @override
  MealModel fromJson(String jsonData) {
    return fromMap(
      json.decode(jsonData),
    );
  }

  @override
  List<MealModel> getList(List<dynamic> data) {
    final responseList = <MealModel>[];

    for (var i = 0; i < data.length; i++) {
      MealModel meal = fromMap(data[i]);
      responseList.add(meal);
    }

    return responseList;
  }
}
