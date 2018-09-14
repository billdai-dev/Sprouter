import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc_provider.dart';

class OrderDrinkPage extends StatefulWidget {
  @override
  _OrderDrinkPageState createState() => _OrderDrinkPageState();
}

class _OrderDrinkPageState extends State<OrderDrinkPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderDrinkBloc bloc = OrderDrinkBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildIngredientChips(context),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: _buildCompleteDrinkName(context),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints.expand(),
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: DragTarget(
                                  builder: (BuildContext context,
                                      List<dynamic> candidateData,
                                      List<dynamic> rejectedData) {
                                    return Image.asset(
                                      "assets/images/handmade_drink.png",
                                    );
                                  },
                                  onWillAccept: (data) => false,
                                  onAccept: (data) => print("accept!"),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.monetization_on),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        onChanged: (price) =>
                                            bloc.changePrice.add(price),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              FractionallySizedBox(
                                heightFactor: 0.7,
                                child: GridView.count(
                                  physics: ClampingScrollPhysics(),
                                  crossAxisCount: 2,
                                  children: [
                                    _DraggableIngredientGrid(Ice),
                                    _DraggableIngredientGrid(Sugar),
                                    _DraggableIngredientGrid(Pearl),
                                    _DraggableIngredientGrid(CoconutJelly),
                                    _DraggableIngredientGrid(OtherIngredient),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                alignment: Alignment(0.0, -0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        "品名",
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      flex: 8,
                      child: TextField(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.send,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientChips(BuildContext context) {
    OrderDrinkBloc bloc = OrderDrinkBlocProvider.of(context);
    return StreamBuilder<Drink>(
      stream: bloc.currentDrink,
      builder: (context, snapshot) {
        List<Widget> chips = snapshot.hasData
            ? snapshot.data.ingredients
                .map((ingredient) => _IngredientChip(
                      ingredient: ingredient,
                    ))
                .toList(growable: false)
            : [];
        return Wrap(
          spacing: 16.0,
          children: chips,
        );
      },
    );
  }

  Widget _buildCompleteDrinkName(BuildContext context) {
    OrderDrinkBloc bloc = OrderDrinkBlocProvider.of(context);
    return StreamBuilder<Drink>(
      stream: bloc.currentDrink,
      builder: (context, snapshot) {
        String completeDrinkName;
        if (!snapshot.hasData) {
          completeDrinkName = "";
        } else {}
        String state = "I want to drink... $completeDrinkName";
        return Text(state);
      },
    );
  }
}

class _IngredientChip extends StatefulWidget {
  final Ingredient ingredient;

  @override
  _IngredientChipState createState() => _IngredientChipState();

  _IngredientChip({Key key, this.ingredient}) : super(key: key);
}

class _IngredientChipState extends State<_IngredientChip> {
  Ingredient _ingredient;

  @override
  Widget build(BuildContext context) {
    OrderDrinkBloc bloc = OrderDrinkBlocProvider.of(context);
    String iconFileName;
    String label = getIngredientMapping(_ingredient);
    switch (_ingredient.runtimeType) {
      case Ice:
        iconFileName = "ice.png";
        break;
      case Sugar:
        iconFileName = "sugar.png";
        break;
      case Pearl:
        iconFileName = "pearl.png";
        break;
      case CoconutJelly:
        iconFileName = "coconut.png";
        break;
      default:
        iconFileName = ".png";
    }
    return InputChip(
      avatar: iconFileName != null
          ? Image(
              image: AssetImage(
                "assets/images/$iconFileName",
              ),
              color: null,
            )
          : null,
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      deleteIconColor: Colors.black54,
      labelPadding: EdgeInsets.all(2.0),
      onDeleted: () => bloc.removeIngredient.add(_ingredient),
      backgroundColor: Colors.lightBlue,
    );
  }

  @override
  void initState() {
    _ingredient = widget.ingredient;
    super.initState();
  }
}

class _DraggableIngredientGrid extends StatefulWidget {
  final Type ingredientType;

  _DraggableIngredientGrid(this.ingredientType);

  @override
  _DraggableIngredientGridState createState() =>
      _DraggableIngredientGridState();
}

class _DraggableIngredientGridState extends State<_DraggableIngredientGrid> {
  Ingredient ingredient;
  String imageFileName;
  String ingredientName;

  @override
  void initState() {
    super.initState();
    switch (widget.ingredientType) {
      case Ice:
        ingredient = Ice();
        imageFileName = "ice.png";
        break;
      case Sugar:
        ingredient = Sugar();
        imageFileName = "sugar.png";
        break;
      case Pearl:
        ingredient = Pearl();
        imageFileName = "pearl.png";
        break;
      case CoconutJelly:
        ingredient = CoconutJelly();
        imageFileName = "coconut.png";
        break;
      default:
        ingredient = OtherIngredient();
        imageFileName = ".png";
    }
    ingredientName = getIngredientMapping(ingredient);
    print(ingredientName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable(
        child: _buildIngredient(),
        dragAnchor: DragAnchor.pointer,
        feedback: _createIngredientImage(ingredient),
      ),
    );
  }

  Widget _buildIngredient() {
    Widget _buildGrid(Ingredient ingredient) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _createIngredientImage(ingredient),
          SizedBox(
            height: 3.0,
          ),
          Text(
            getIngredientMapping(ingredient),
          ),
        ],
      );
    }

    return ingredient is CoconutJelly
        ? _buildGrid(ingredient)
        : StreamBuilder<dynamic>(
            stream: _getIngredientChangeStream(),
            builder: (context, snapshot) =>
                _buildGrid(snapshot.data ?? ingredient),
          );
  }

  Widget _createIngredientImage(Ingredient ingredient) {
    return Image.asset(
      "assets/images/$imageFileName",
      width: 30.0,
      height: 30.0,
      fit: BoxFit.contain,
    );
  }

  Stream<dynamic> _getIngredientChangeStream() {
    OrderDrinkBloc bloc = OrderDrinkBlocProvider.of(context);
    switch (widget.ingredientType) {
      case Ice:
        return bloc.configIce.stream;
      case Sugar:
        return bloc.configSugar.stream;
      case Pearl:
        return bloc.configPearl.stream;
      default:
        return bloc.configOther.stream;
    }
  }
}
