import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/usecase/foods_usecase.dart';
import 'package:mobx/mobx.dart';
part 'foods_viewmodel.g.dart';

class FoodsViewmodel = _FoodsViewmodelBase with _$FoodsViewmodel;

abstract class _FoodsViewmodelBase with Store {
  final _usecase = FoodsUsecase();

  String? _userToken;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<FoodModel> foods = <FoodModel>[].asObservable();

  @action
  Future<void> getFoods() async {
    isLoading = true;

    try {
      final response = await _usecase.getFoods(_userToken);

      foods.clear();

      for (var element in response) {
        foods.add(element);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> searchFoods(String name) async {
    isLoading = true;
    // await Future.delayed(Duration(milliseconds: 300));

    try {
      final response = await _usecase.searchFoods(_userToken, name);

      foods.clear();

      for (var element in response) {
        foods.add(element);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> setUserToken() async {
    if (_userToken != null) {
      return;
    }

    try {
      final token = await _usecase.getToken();

      _userToken = token;
    } catch (e) {
      print(e.toString());
    }
  }
}
