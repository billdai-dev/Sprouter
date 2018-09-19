import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';

class OrderDrinkBloc {
  AppRepository repository;
  final Drink _drink = Drink();

  final StreamController<Ingredient> _addIngredient = StreamController();

  Sink<Ingredient> get addIngredient => _addIngredient.sink;

  final StreamController<Ingredient> _removeIngredient = StreamController();

  Sink<Ingredient> get removeIngredient => _removeIngredient.sink;

  final StreamController<Ingredient> configIce = StreamController();

  final StreamController<Ingredient> configSugar = StreamController();

  final StreamController<Ingredient> configPearl = StreamController();

  final StreamController<Ingredient> configDrinkSize = StreamController();

  final StreamController<Ingredient> configOther = StreamController();

  final StreamController<String> _changePrice = StreamController();

  Sink<String> get changePrice => _changePrice.sink;

  final StreamController<String> _changeDrinkName = StreamController();

  Sink<String> get changeDrinkName => _changeDrinkName.sink;

  /*final StreamController<Ingredient> _changeIngredientDetail =
      StreamController();

  Sink<Ingredient> get changeIngredientDetail => _changeIngredientDetail.sink;*/

  final BehaviorSubject<Drink> _currentDrink = BehaviorSubject();

  Stream<Drink> get currentDrink => _currentDrink.stream;

  final StreamController<void> _submitOrder = StreamController();

  Sink<void> get submitOrder => _submitOrder.sink;

  OrderDrinkBloc({AppRepository repository})
      : this.repository = repository ?? AppRepository.repo {
    _addIngredient.stream
        .listen((ingredient) => _handleIngredientChange(ingredient, true));
    _removeIngredient.stream
        .listen((ingredient) => _handleIngredientChange(ingredient, false));
    _changePrice.stream.listen(_handlePriceChange);
    _changeDrinkName.stream.listen(_handleDrinkNameChange);
    _submitOrder.stream.listen(_handleOrderSubmission);
  }

  void _handleIngredientChange(Ingredient ingredient, bool isAdding) {
    List<Ingredient> currentIngredients = _drink.ingredients;
    Type ingredientType = ingredient.runtimeType;
    currentIngredients.removeWhere((indexedIngredient) {
      Type indexedIngredientType = indexedIngredient.runtimeType;
      if (ingredient is OtherIngredient) {
        return indexedIngredient is OtherIngredient &&
            indexedIngredient.ingredientName == ingredient.ingredientName;
      }
      return indexedIngredientType == ingredientType;
    });
    print(currentIngredients);
    if (isAdding) {
      currentIngredients.add(ingredient);
    }
    currentIngredients.sort((ingredientA, ingredientB) {
      int weightA = ingredientWeights.indexOf(ingredientA.runtimeType);
      int weightB = ingredientWeights.indexOf(ingredientB.runtimeType);
      return weightA - weightB;
    });
    _currentDrink.sink.add(_drink);
  }

  void _handlePriceChange(String price) {
    _drink.price = price;
    _currentDrink.sink.add(_drink);
  }

  void _handleDrinkNameChange(String drinkName) {
    _drink.name = drinkName;
    _currentDrink.sink.add(_drink);
  }

  void _handleOrderSubmission(void event) {}

  void dispose() {
    _addIngredient?.close();
    _removeIngredient?.close();
    configIce?.close();
    configSugar?.close();
    configPearl?.close();
    configDrinkSize?.close();
    configOther?.close();
    _changePrice?.close();
    _changeDrinkName?.close();
    //_changeIngredientDetail?.close();
    _currentDrink?.close();
    _submitOrder?.close();
  }
}
