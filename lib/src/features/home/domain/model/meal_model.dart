import 'dart:convert';

import 'package:macros_app/src/features/home/domain/model/item_model.dart';

import 'package:mobx/mobx.dart';
part 'meal_model.g.dart';

class MealModel = _MealModelBase with _$MealModel;

abstract class _MealModelBase with Store {
  @observable
  String id;

  @observable
  String name;

  @observable
  int hour;

  @observable
  int minutes;

  @observable
  ObservableList<ItemModel> items;

  _MealModelBase({
    required this.id,
    required this.name,
    required this.hour,
    required this.minutes,
    required this.items,
  });

  @action
  void addItem(ItemModel item) {
    items.add(item);
  }

  @action
  void updateItem(String id, double amount) {
    // items.add(item);
    for (var element in items) {
      if (element.id == id) {
        element = element.copyWith(
          amount: amount,
        );
        return;
      }
    }
  }
}

class MealModelConverter {
  Map<String, dynamic> toMap(MealModel meal) {
    return {
      'id': meal.id,
      'name': meal.name,
      'hour': meal.hour,
      'minutes': meal.minutes,
      'items': meal.items.map((item) => item.toMap()).toList(),
    };
  }

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

  String toJson(MealModel meal) => json.encode(toMap(meal));

  MealModel fromJson(String jsonData) {
    return fromMap(
      json.decode(jsonData),
    );
  }
}
