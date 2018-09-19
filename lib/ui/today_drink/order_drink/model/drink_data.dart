class Drink {
  String name;
  String price;
  List<Ingredient> ingredients = [];
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

enum IceLevel { no, low, less, normal }

enum SugarLevel { no, low, half, less, standard }

enum PearlType { black, white }

enum Cup { medium, large }

String getIngredientMapping(Ingredient ingredient) {
  String name;
  switch (ingredient.runtimeType) {
    case Ice:
      IceLevel level = (ingredient as Ice).level;
      switch (level) {
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
