class Drink {
  String name;
  String price;
  List<Ingredient> ingredients = [];

  String get completeDrinkName {
    StringBuffer ingredientString = StringBuffer("");
    ingredients?.forEach((ingredient) =>
        ingredientString.write(" / ${getIngredientMapping(ingredient)}"));
    String _price = price == null ? "" : " / \$$price";
    return "${name ?? ""}${ingredientString.toString()}$_price";
  }

  Drink();

  Drink.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    map.forEach((key, value) {
      if (value == null) {
        return;
      }
      switch (key) {
        case "name":
          this.name = value;
          break;
        case "price":
          this.price = value.toString();
          break;
        case "ice":
          for (var level in IceLevel.values) {
            if (level.toString().contains(value.toString())) {
              ingredients.add(Ice(level: level));
              break;
            }
          }
          break;
        case "sugar":
          for (var level in SugarLevel.values) {
            if (level.toString().contains(value.toString())) {
              ingredients.add(Sugar(level: level));
              break;
            }
          }
          break;
        case "pearl":
          for (var type in PearlType.values) {
            if (type.toString().contains(value.toString())) {
              ingredients.add(Pearl(type: type));
              break;
            }
          }
          break;
        case "coconut":
          if ("Y" == value) {
            ingredients.add(CoconutJelly());
          }
          break;
        case "cup_size":
          for (var cup in Cup.values) {
            if (cup.toString().contains(value.toString())) {
              ingredients.add(DrinkSize(cup: cup));
              break;
            }
          }
          break;
        case "other_ingredient":
          ingredients.addAll(value.toString().split(",").map(
              (ingredient) => OtherIngredient(ingredientName: ingredient)));
          break;
      }
    });
  }

  Map<String, String> toMap() {
    Map<String, String> map = Map();
    StringBuffer otherIngredients = StringBuffer();
    map.putIfAbsent("name", () => name);
    map.putIfAbsent("price", () => price);
    for (var ingredient in ingredients) {
      switch (ingredient.runtimeType) {
        case Ice:
          String ice = (ingredient as Ice).level.toString().split(".")[1];
          map.putIfAbsent("ice", () => ice);
          break;
        case Sugar:
          String sugar = (ingredient as Sugar).level.toString().split(".")[1];
          map.putIfAbsent("sugar", () => sugar);
          break;
        case Pearl:
          String pearl = (ingredient as Pearl).type.toString().split(".")[1];
          map.putIfAbsent("pearl", () => pearl);
          break;
        case CoconutJelly:
          map.putIfAbsent("coconut", () => "Y");
          break;
        case DrinkSize:
          String cup = (ingredient as DrinkSize).cup.toString().split(".")[1];
          map.putIfAbsent("cup_size", () => cup);
          break;
        case OtherIngredient:
          String otherIngredient =
              (ingredient as OtherIngredient).ingredientName;
          otherIngredients.write(otherIngredients.isEmpty
              ? "$otherIngredient"
              : ",$otherIngredient");
          break;
      }
    }
    if (otherIngredients.isNotEmpty) {
      map.putIfAbsent("other_ingredient", () => otherIngredients.toString());
    }
    return map;
  }
}

const List<Type> ingredientWeights = [
  Sugar,
  Ice,
  DrinkSize,
  Pearl,
  CoconutJelly,
  OtherIngredient
];

class Ingredient {}

class Ice extends Ingredient {
  Ice({this.level = IceLevel.no});

  IceLevel level;
}

class Sugar extends Ingredient {
  Sugar({this.level = SugarLevel.low});

  SugarLevel level;
}

class Pearl extends Ingredient {
  Pearl({this.type = PearlType.black});

  PearlType type;
}

class CoconutJelly extends Ingredient {}

class DrinkSize extends Ingredient {
  Cup cup;

  DrinkSize({this.cup = Cup.medium});
}

class OtherIngredient extends Ingredient {
  OtherIngredient({this.ingredientName = "其他"});

  String ingredientName;
}

enum IceLevel { warm, no, low, less, normal }

enum SugarLevel { no, low, half, less, standard }

enum PearlType { black, white }

enum Cup { medium, large }

String getIngredientMapping(Ingredient ingredient) {
  String name;
  switch (ingredient.runtimeType) {
    case Ice:
      IceLevel level = (ingredient as Ice).level;
      switch (level) {
        case IceLevel.warm:
          name = "溫";
          break;
        case IceLevel.no:
          name = "去冰";
          break;
        case IceLevel.low:
          name = "微冰";
          break;
        case IceLevel.less:
          name = "少冰";
          break;
        case IceLevel.normal:
          name = "正常";
          break;
      }
      break;
    case Sugar:
      SugarLevel level = (ingredient as Sugar).level;
      switch (level) {
        case SugarLevel.no:
          name = "無糖";
          break;
        case SugarLevel.low:
          name = "微糖";
          break;
        case SugarLevel.half:
          name = "半糖";
          break;
        case SugarLevel.less:
          name = "少糖";
          break;
        case SugarLevel.standard:
          name = "正常";
          break;
      }
      break;
    case Pearl:
      PearlType type = (ingredient as Pearl).type;
      name = type == PearlType.black ? "珍珠" : "白玉珍珠";
      break;
    case CoconutJelly:
      name = "椰果";
      break;
    case DrinkSize:
      Cup cup = (ingredient as DrinkSize).cup;
      if (cup == Cup.medium) {
        name = "中杯";
      } else if (cup == Cup.large) {
        name = "大杯";
      }
      break;
    default:
      name = (ingredient as OtherIngredient)?.ingredientName;
  }
  return name ?? "";
}
