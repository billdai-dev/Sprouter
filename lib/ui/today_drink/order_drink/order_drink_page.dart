import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc_provider.dart';

class OrderDrinkPage extends StatefulWidget {
  @override
  _OrderDrinkPageState createState() => _OrderDrinkPageState();
}

class _OrderDrinkPageState extends State<OrderDrinkPage>
    with SingleTickerProviderStateMixin {
  OverlayEntry overlayEntry;
  GlobalKey _handmadeDrinkKey = GlobalKey();
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        overlayEntry?.remove();
      }
    });
    overlayEntry?.remove();
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    controller?.dispose();
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
            Flexible(
              child: _buildIngredientChips(context),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
                                child: DragTarget<Ingredient>(
                                  key: _handmadeDrinkKey,
                                  builder:
                                      (context, candidateData, rejectedData) {
                                    Widget handmadeDrink = Image.asset(
                                      "assets/images/handmade_drink.png",
                                    );
                                    return controller.isAnimating ||
                                            candidateData.isEmpty
                                        ? handmadeDrink
                                        : Opacity(
                                            opacity: 0.5,
                                            child: handmadeDrink,
                                          );
                                  },
                                  onWillAccept: (data) =>
                                      !controller.isAnimating,
                                  onAccept: (data) {
                                    overlayEntry = OverlayEntry(
                                      builder: (context) =>
                                          _DropIngredientAnimation(
                                              ingredientType: data.runtimeType,
                                              handmadeDrinkRenderBox:
                                                  _handmadeDrinkKey
                                                      .currentContext
                                                      .findRenderObject(),
                                              controller: controller),
                                    );
                                    Overlay.of(context).insert(overlayEntry);
                                    controller.reset();
                                    controller.forward();
                                    bloc.addIngredient.add(data);
                                  },
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
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(3)
                                        ],
                                        keyboardType: TextInputType.number,
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
                      child: TextField(
                        onChanged: (name) => bloc.changeDrinkName.add(name),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => bloc.submitOrder.add(null),
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
            ? snapshot.data.ingredients.map((ingredient) {
                ValueKey key = ValueKey(ingredient is OtherIngredient
                    ? ingredient.ingredientName
                    : getIngredientMapping(ingredient));
                return _IngredientChip(
                  key: key,
                  ingredient: ingredient,
                );
              }).toList(growable: false)
            : [];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Wrap(
                spacing: 16.0,
                children: chips,
              );
            },
          ),
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
        } else {
          Drink drink = snapshot.data;
          StringBuffer ingredientString = StringBuffer("");
          drink.ingredients.forEach((ingredient) {
            ingredientString.write(" / ${getIngredientMapping(ingredient)}");
          });
          String price = drink.price == null ? "" : " / \$${drink.price}";
          completeDrinkName =
              "${drink.name ?? ""}${ingredientString.toString()}$price";
        }
        String state = "我想喝...\n$completeDrinkName";
        return Text(
          state,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        );
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
        iconFileName = "other_ingredient.png";
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
        imageFileName = "other_ingredient.png";
    }
    ingredientName = getIngredientMapping(ingredient);
  }

  @override
  Widget build(BuildContext context) {
    OrderDrinkBloc bloc = OrderDrinkBlocProvider.of(context);
    return GestureDetector(
      onTap: () async {
        if (ingredient is CoconutJelly) {
          return;
        }
        Ingredient newIngredient = await showDialog(
          context: context,
          builder: (context) => _AdjustIngredientDialog(ingredient),
        );
        if (newIngredient == null) {
          return;
        }
        ingredient = newIngredient;
        switch (newIngredient.runtimeType) {
          case Ice:
            bloc?.configIce?.add(newIngredient);
            break;
          case Sugar:
            bloc?.configSugar?.add(newIngredient);
            break;
          case Pearl:
            bloc?.configPearl?.add(newIngredient);
            break;
          case OtherIngredient:
            bloc?.configOther?.add(newIngredient);
            break;
        }
        //setState(() {});
      },
      child: Center(
        child: _buildIngredient(),
      ),
    );
  }

  Widget _buildIngredient() {
    return ingredient is CoconutJelly
        ? _buildGrid(ingredient)
        : StreamBuilder<Ingredient>(
            stream: _getIngredientChangeStream(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                ingredient = snapshot.data;
              }
              return _buildGrid(ingredient);
            },
          );
  }

  Widget _buildGrid(Ingredient ingredient) {
    return Draggable(
      maxSimultaneousDrags: 1,
      data: ingredient,
      dragAnchor: DragAnchor.pointer,
      feedback: _createIngredientImage(ingredient),
      child: Column(
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
      ),
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
        return bloc?.configIce?.stream;
      case Sugar:
        return bloc.configSugar.stream;
      case Pearl:
        return bloc.configPearl.stream;
      default:
        return bloc.configOther.stream;
    }
  }
}

class _AdjustIngredientDialog extends StatefulWidget {
  final Ingredient ingredient;

  _AdjustIngredientDialog(this.ingredient);

  @override
  _AdjustIngredientDialogState createState() {
    return new _AdjustIngredientDialogState();
  }
}

class _AdjustIngredientDialogState extends State<_AdjustIngredientDialog> {
  Ingredient ingredient;
  double sliderValue = 0.0;
  double sliderMinValue = 0.0;
  double sliderMaxValue;
  int divisions;
  String ingredientName;
  String otherIngredient;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    ingredient = widget.ingredient;
    switch (widget.ingredient.runtimeType) {
      case Ice:
        ingredientName = "冰塊";
        sliderValue = (widget.ingredient as Ice).level.index.toDouble();
        sliderMaxValue = IceLevel.values.length.toDouble() - 1;
        break;
      case Sugar:
        ingredientName = "甜度";
        sliderValue = (widget.ingredient as Sugar).level.index.toDouble();
        sliderMaxValue = SugarLevel.values.length.toDouble() - 1;
        break;
      case Pearl:
        ingredientName = "珍珠";
        sliderValue = (widget.ingredient as Pearl).type.index.toDouble();
        sliderMaxValue = PearlType.values.length.toDouble() - 1;
        break;
      case OtherIngredient:
        ingredientName = "其他配料";
        otherIngredient = (widget.ingredient as OtherIngredient).ingredientName;
        textEditingController = TextEditingController(text: otherIngredient);
        break;
    }
    if (sliderMaxValue != null) {
      divisions = sliderMaxValue.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("調整$ingredientName"),
      content: _createDialogContent(otherIngredient != null),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: Text("取消"),
        ),
        FlatButton(
          onPressed: ingredient is OtherIngredient && otherIngredient.isEmpty
              ? null
              : () {
                  Ingredient newIngredient;
                  switch (widget.ingredient.runtimeType) {
                    case Ice:
                      newIngredient =
                          Ice(level: IceLevel.values[sliderValue.toInt()]);
                      break;
                    case Sugar:
                      newIngredient =
                          Sugar(level: SugarLevel.values[sliderValue.toInt()]);
                      break;
                    case Pearl:
                      newIngredient =
                          Pearl(type: PearlType.values[sliderValue.toInt()]);
                      break;
                    case OtherIngredient:
                      newIngredient =
                          OtherIngredient(ingredientName: otherIngredient);
                      break;
                  }
                  Navigator.of(context, rootNavigator: true).pop(newIngredient);
                },
          child: Text("確定"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }

  Widget _createDialogContent(bool isOtherIngredient) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.2,
      child: isOtherIngredient
          ? TextField(
              controller: textEditingController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
              ],
              onChanged: (value) {
                bool needRebuild =
                    otherIngredient.isEmpty && value.isNotEmpty ||
                        otherIngredient.isNotEmpty && value.isEmpty;
                otherIngredient = value;
                if (needRebuild) {
                  setState(() {});
                }
              },
            )
          : Slider(
              value: sliderValue,
              onChanged: (value) {
                switch (ingredient.runtimeType) {
                  case Ice:
                    (ingredient as Ice).level = IceLevel.values[value.toInt()];
                    break;
                  case Sugar:
                    (ingredient as Sugar).level =
                        SugarLevel.values[value.toInt()];
                    break;
                  case Pearl:
                    (ingredient as Pearl).type =
                        PearlType.values[value.toInt()];
                    break;
                  case OtherIngredient:
                    (ingredient as OtherIngredient).ingredientName =
                        textEditingController.value.toString();
                    break;
                }
                setState(() => sliderValue = value);
              },
              min: sliderMinValue,
              max: sliderMaxValue,
              divisions: divisions,
              label: getIngredientMapping(ingredient),
            ),
    );
  }
}

class _DropIngredientAnimation extends StatelessWidget {
  final RenderBox handmadeDrinkRenderBox;
  final AnimationController controller;
  final Type ingredientType;

  _DropIngredientAnimation({
    Key key,
    @required this.ingredientType,
    @required this.handmadeDrinkRenderBox,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offset pos = handmadeDrinkRenderBox.localToGlobal(Offset.zero);
    double iconWidthHeight = 30.0;
    double animBeginX =
        pos.dx + handmadeDrinkRenderBox.size.width / 2 - iconWidthHeight / 2;
    double animBeginY = pos.dy;
    double translationDistanceRatio =
        handmadeDrinkRenderBox.size.height / 4 / iconWidthHeight;

    Animation<Offset> dropAnim = Tween(
            begin: Offset(0.0, 0.0), end: Offset(0.0, translationDistanceRatio))
        .animate(controller);
    Animation<double> opacityAnim = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent:
                CurvedAnimation(parent: controller, curve: Interval(0.8, 1.0)),
            curve: Curves.ease));

    return AnimatedBuilder(
      animation: dropAnim,
      builder: (context, child) => Stack(children: <Widget>[child]),
      child: Positioned(
        left: animBeginX,
        top: animBeginY,
        height: iconWidthHeight,
        child: FadeTransition(
          opacity: opacityAnim,
          child: SlideTransition(
            position: dropAnim,
            child: Image.asset(
              _getImageFileName(ingredientType),
              width: iconWidthHeight,
              height: iconWidthHeight,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  String _getImageFileName(Type ingredientType) {
    String fileName;
    switch (ingredientType) {
      case Ice:
        fileName = "ice.png";
        break;
      case Sugar:
        fileName = "sugar.png";
        break;
      case Pearl:
        fileName = "pearl.png";
        break;
      case CoconutJelly:
        fileName = "coconut.png";
        break;
      case OtherIngredient:
        fileName = "other_ingredient.png";
        break;
    }
    return "assets/images/$fileName";
  }
}
