class Drink {
  String name;
  String price;
  List<Ingredient> ingredients;
}

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

class OtherIngredient extends Ingredient {
  OtherIngredient({this.ingredientName = "Other"});

  String ingredientName;
}

enum IceLevel { no, low, less, normal }

enum SugarLevel { no, low, half, less, standard }

enum PearlType { black, white }
