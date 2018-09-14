import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/app_repository.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';

class OrderDrinkBloc {
  AppRepository repository;
  final Drink _drink = Drink();

  /*final Ice _iceConfig = Ice();
  final Sugar _sugarConfig = Sugar();
  final Pearl _pearlConfig = Pearl();
  final OtherIngredient _otherConfig = OtherIngredient();*/

  final StreamController<Ingredient> _addIngredient = StreamController();

  Sink<Ingredient> get addIngredient => _addIngredient.sink;

  final StreamController<IceLevel> _configIce = StreamController();

  Sink<IceLevel> get configIce => _configIce.sink;

  final StreamController<SugarLevel> _configSugar = StreamController();

  Sink<SugarLevel> get configSugar => _configSugar.sink;

  final StreamController<PearlType> _configPearl = StreamController();

  Sink<PearlType> get configPearl => _configPearl.sink;

  final StreamController<String> _configOther = StreamController();

  Sink<String> get configOther => _configOther.sink;

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
    _addIngredient.stream.listen(_handleIngredientAddition);
    _changePrice.stream.listen(_handlePriceChange);
    _changeDrinkName.stream.listen(_handleDrinkNameChange);
    _submitOrder.stream.listen(_handleOrderSubmission);
  }

  void _handleIngredientAddition(Ingredient ingredient) {
    List<Ingredient> currentIngredients = _drink.ingredients;
    Type ingredientType = ingredient.runtimeType;
    currentIngredients.removeWhere((ingredient) {
      Type type = ingredient.runtimeType;
      return type != OtherIngredient && type == ingredientType;
    });
    currentIngredients.add(ingredient);
    _currentDrink.sink.add(_drink);
  }

  void dispose() {
    _addIngredient?.close();
    _configIce?.close();
    _configSugar?.close();
    _configPearl?.close();
    _configOther?.close();
    _changePrice?.close();
    _changeDrinkName?.close();
    //_changeIngredientDetail?.close();
    _currentDrink?.close();
    _submitOrder?.close();
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
}
