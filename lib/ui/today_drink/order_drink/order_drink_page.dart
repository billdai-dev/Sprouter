import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprouter/ui/loading_screen.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/detail_photo/detail_photo_page.dart';
import 'package:sprouter/ui/today_drink/order_drink/model/drink_data.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';
import 'package:sprouter/util/utils.dart';

class OrderDrinkPage extends StatefulWidget {
  @override
  _OrderDrinkPageState createState() => _OrderDrinkPageState();
}

class _OrderDrinkPageState extends State<OrderDrinkPage>
    with SingleTickerProviderStateMixin {
  final bool _useMaleImage = Random().nextBool();

  OrderDrinkBloc bloc;

  OverlayEntry overlayEntry;
  OverlayEntry drinkMenuOverlayEntry;
  GlobalKey _handmadeDrinkKey = GlobalKey();
  GlobalKey _drinkMenuKey = GlobalKey();
  AnimationController dropIngredientAnimController;
  TextEditingController priceController;
  TextEditingController drinkNameController;

  @override
  void initState() {
    super.initState();
    dropIngredientAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    dropIngredientAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        overlayEntry?.remove();
      }
    });
    priceController = TextEditingController();
    drinkNameController = TextEditingController();
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    drinkMenuOverlayEntry?.remove();
    dropIngredientAnimController?.dispose();
    priceController?.dispose();
    drinkNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = OrderDrinkBlocProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("點杯飲料"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.bookReader,
                key: _drinkMenuKey,
              ),
              onPressed: () {
                TodayDrinkBloc todayDrinkBloc =
                    TodayDrinkBlocProvider.of(context);
                SlackLoginBloc slackLoginBloc =
                    SlackLoginBlocProvider.of(context);
                String token = slackLoginBloc?.token;
                String photoUrl = todayDrinkBloc?.photoUrl;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPhotoPage(bloc?.shopName, photoUrl, token)));
              }),
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: _buildIngredientChips(context),
                ),
                Divider(
                  height: 1.0,
                  color: Theme.of(context).accentColor,
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      _buildCompleteDrinkName(context),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: _buildQuickDrinkSetting(_useMaleImage),
                              ),
                              Expanded(
                                child: _buildHandmadeDrinkImage(),
                              ),
                              Expanded(
                                child: _buildIngredientsZone(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildDrinkNameInput(),
                )
              ],
            ),
            StreamBuilder(
              stream: bloc?.isLoading,
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data
                    ? LoadingIndicator()
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientChips(BuildContext context) {
    return StreamBuilder<Drink>(
      stream: bloc.currentDrink,
      builder: (context, snapshot) {
        List<Widget> chips = snapshot.hasData &&
                !Utils.isListNullOrEmpty(snapshot.data.ingredients)
            ? snapshot.data.ingredients.map((ingredient) {
                ValueKey key = ValueKey(ingredient is OtherIngredient
                    ? ingredient.ingredientName
                    : getIngredientMapping(ingredient));
                return _IngredientChip(
                  key: key,
                  ingredient: ingredient,
                );
              }).toList(growable: false)
            : [
                InputChip(
                    disabledColor: Colors.grey.shade300,
                    avatar: Image.asset("assets/images/bulb.png"),
                    label: Text("試著將配料丟進杯子..")),
              ];
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
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: StreamBuilder<Drink>(
        stream: bloc.currentDrink,
        builder: (context, snapshot) {
          String imageFile =
              _useMaleImage ? "thirsty_man.png" : "thirsty_woman.png";
          bool isEmptyDrink = !snapshot.hasData ||
              Utils.isStringNullOrEmpty(snapshot.data.completeDrinkName);
          String completeDrinkName = snapshot.hasData &&
                  !Utils.isStringNullOrEmpty(snapshot.data.completeDrinkName)
              ? snapshot.data.completeDrinkName
              : "我想喝...";
          return Row(
            children: <Widget>[
              Spacer(flex: 3),
              Flexible(
                flex: 14,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    "assets/images/$imageFile",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 3.0),
              Flexible(
                flex: 83,
                child: Text(
                  isEmptyDrink ? "我想喝..." : snapshot.data.completeDrinkName,
                  style: isEmptyDrink
                      ? TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        )
                      : TextStyle(
                          height: 1.0,
                          fontSize: 16.0,
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuickDrinkSetting(bool useMaleImage) {
    String imageFile = useMaleImage ? "waiter.png" : "waitress.png";

    return Column(
      children: <Widget>[
        Expanded(
          flex: 50,
          child: Image.asset(
            "assets/images/$imageFile",
          ),
        ),
        Flexible(
          flex: 20,
          child: _buildGetFavoriteDrinkButton(),
        ),
        Spacer(
          flex: 2,
        ),
        Flexible(
          flex: 20,
          child: _buildRecommendationButton(),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Widget _buildHandmadeDrinkImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: DragTarget<Ingredient>(
            key: _handmadeDrinkKey,
            builder: (context, candidateData, rejectedData) {
              Widget handmadeDrink = Image.asset(
                "assets/images/handmade_drink.png",
              );
              return dropIngredientAnimController.isAnimating ||
                      candidateData.isEmpty
                  ? handmadeDrink
                  : Opacity(
                      opacity: 0.5,
                      child: handmadeDrink,
                    );
            },
            onWillAccept: (data) => !dropIngredientAnimController.isAnimating,
            onAccept: (data) {
              overlayEntry = OverlayEntry(
                builder: (context) => _DropIngredientAnimation(
                    ingredientType: data.runtimeType,
                    handmadeDrinkRenderBox:
                        _handmadeDrinkKey.currentContext.findRenderObject(),
                    controller: dropIngredientAnimController),
              );
              Overlay.of(context).insert(overlayEntry);
              dropIngredientAnimController?.reset();
              dropIngredientAnimController?.forward();
              bloc?.addIngredient?.add(data);
            },
          ),
        ),
        /*_buildFavoriteIcon(),
        SizedBox(
          height: 8.0,
        ),*/
        _buildPriceTag(),
      ],
    );
  }

  Widget _buildPriceTag() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.monetization_on,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 3.0,
          ),
          Expanded(
            child: StreamBuilder<Drink>(
              stream: bloc?.currentDrink
                  ?.distinct((prev, current) => prev.price == current.price),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String price = snapshot.data.price ?? "";
                  priceController?.text = price;
                  priceController?.selection = TextSelection(
                      baseOffset: price.length, extentOffset: price.length);
                }
                return TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4.0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 2.0),
                    ),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  keyboardType: TextInputType.number,
                  onChanged: (price) => bloc.changePrice.add(price),
                  controller: priceController,
                );
              },
            ),
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }

  Widget _buildIngredientsZone() {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          child: GridView.count(
            physics: ClampingScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: [
              _DraggableIngredientGrid(Ice),
              _DraggableIngredientGrid(Sugar),
              _DraggableIngredientGrid(Pearl),
              _DraggableIngredientGrid(CoconutJelly),
              _DraggableIngredientGrid(DrinkSize),
              _DraggableIngredientGrid(OtherIngredient),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkNameInput() {
    return FractionallySizedBox(
      widthFactor: 0.48,
      child: Container(
        margin: EdgeInsets.only(left: 15.0),
        alignment: Alignment(0.0, -0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: StreamBuilder<Drink>(
                stream: bloc?.currentDrink
                    ?.distinct((prev, current) => prev.name == current.name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String drinkName = snapshot.data.name ?? "";
                    drinkNameController?.text = drinkName;
                    drinkNameController?.selection = TextSelection(
                        baseOffset: drinkName.length,
                        extentOffset: drinkName.length);
                  }
                  return TextField(
                    decoration: InputDecoration(
                      labelText: "品名",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: "NotoSansTC",
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(4.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 2.0),
                      ),
                    ),
                    onChanged: (name) => bloc.changeDrinkName.add(name),
                    controller: drinkNameController,
                  );
                },
              ),
            ),
            Expanded(
              child: _buildSubmitButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetFavoriteDrinkButton() {
    return Builder(
      builder: (context) => FractionallySizedBox(
            widthFactor: 0.8,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.zero,
              onPressed: () async {
                bool success = await bloc?.getFavoriteDrink();
                String snackBarText =
                    success != null && success ? "已套用最愛飲料" : "還沒有最愛的飲料哦";
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(snackBarText)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "最愛喝的",
                    style: Theme.of(context).accentTextTheme.button,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildRecommendationButton() {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "為我推薦",
              style: Theme.of(context).accentTextTheme.button,
            ),
            Icon(
              Icons.arrow_forward,
              size: 16.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return StreamBuilder<bool>(
      stream: bloc?.isLoading,
      builder: (context, snapshot) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Builder(
            builder: (context) {
              Color accentColor = Theme.of(context).accentColor;
              return IconButton(
                icon: Icon(Icons.send),
                color: accentColor,
                disabledColor: Colors.grey,
                onPressed: snapshot.hasData && snapshot.data
                    ? null
                    : () async {
                        int addedDrinkId = await bloc?.submitOrder();
                        if (addedDrinkId == null) {
                          Navigator.of(context).pop(false);
                          return;
                        }

                        await showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildSetFavoriteBottomSheet(
                                context, addedDrinkId));
                        Navigator.of(context).pop(true);
                      },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSetFavoriteBottomSheet(BuildContext context, int addedDrinkId) {
    String imageFile =
        _useMaleImage ? "drinking_man.png" : "drinking_woman.png";
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight * 0.8;
        return Container(
          width: width,
          height: height,
          child: Card(
            color: Colors.green.shade50,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: width / 2.0,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.asset("assets/images/$imageFile"),
                  ),
                ),
                Text(
                  "將此杯飲料設為我的最愛即可一鍵下單！",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                ButtonTheme.bar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FlatButton.icon(
                        color: Colors.grey.shade400,
                        onPressed: () => Navigator.of(context).pop(false),
                        icon: Icon(
                          FontAwesomeIcons.tired,
                          color: Theme.of(context).accentIconTheme.color,
                        ),
                        label: Text(
                          "不用",
                          style: Theme.of(context).accentTextTheme.button,
                        ),
                      ),
                      FlatButton.icon(
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          await bloc?.setFavoriteDrink(addedDrinkId);
                          Navigator.of(context).pop(true);
                        },
                        icon: Icon(
                          FontAwesomeIcons.grinHearts,
                          color: Theme.of(context).accentIconTheme.color,
                        ),
                        label: Text(
                          "設為最愛",
                          style: Theme.of(context).accentTextTheme.button,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
  OrderDrinkBloc bloc;

  @override
  void initState() {
    super.initState();
    _ingredient = widget.ingredient;
  }

  @override
  Widget build(BuildContext context) {
    bloc = OrderDrinkBlocProvider.of(context);

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
      case DrinkSize:
        iconFileName = "cup.png";
        break;
      default:
        iconFileName = "other_ingredient.png";
    }
    return InputChip(
      avatar: iconFileName != null
          ? Image(
              image: AssetImage("assets/images/$iconFileName"),
              color: null,
            )
          : null,
      label: Text(
        label,
        style: Theme.of(context).accentTextTheme.body1,
      ),
      backgroundColor: Theme.of(context).accentColor,
      deleteIconColor: Colors.black54,
      labelPadding: EdgeInsets.all(2.0),
      onDeleted: () => bloc.removeIngredient.add(_ingredient),
      onPressed: () async {
        if (_ingredient is CoconutJelly) {
          return;
        }
        Ingredient newIngredient = await showDialog(
          context: context,
          builder: (context) => _AdjustIngredientDialog(_ingredient),
        );
        if (newIngredient == null) {
          return;
        }
        bloc.removeIngredient.add(_ingredient);
        _ingredient = newIngredient;
        bloc?.addIngredient?.add(newIngredient);
      },
    );
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
  OrderDrinkBloc bloc;

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
      case DrinkSize:
        ingredient = DrinkSize();
        imageFileName = "cup.png";
        break;
      default:
        ingredient = OtherIngredient();
        imageFileName = "other_ingredient.png";
    }
    ingredientName = getIngredientMapping(ingredient);
  }

  @override
  Widget build(BuildContext context) {
    bloc = OrderDrinkBlocProvider.of(context);

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
          case DrinkSize:
            bloc?.configDrinkSize?.add(newIngredient);
            break;
          case OtherIngredient:
            bloc?.configOther?.add(newIngredient);
            break;
        }
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(1.0, 2.0, 2.0, 2.0),
        elevation: 2.0,
        child: Center(
          child: _buildIngredient(),
        ),
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
            height: 2.0,
          ),
          Text(
            getIngredientMapping(ingredient),
            style: TextStyle(fontSize: 12.0),
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
    switch (widget.ingredientType) {
      case Ice:
        return bloc?.configIce?.stream;
      case Sugar:
        return bloc.configSugar.stream;
      case Pearl:
        return bloc.configPearl.stream;
      case DrinkSize:
        return bloc.configDrinkSize.stream;
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
    switch (widget.ingredient.runtimeType) {
      case Ice:
        ingredientName = "冰塊";
        sliderValue = (widget.ingredient as Ice).level.index.toDouble();
        sliderMaxValue = IceLevel.values.length.toDouble() - 1;
        ingredient = Ice(level: IceLevel.values[sliderValue.toInt()]);
        break;
      case Sugar:
        ingredientName = "甜度";
        sliderValue = (widget.ingredient as Sugar).level.index.toDouble();
        sliderMaxValue = SugarLevel.values.length.toDouble() - 1;
        ingredient = Sugar(level: SugarLevel.values[sliderValue.toInt()]);
        break;
      case Pearl:
        ingredientName = "珍珠";
        sliderValue = (widget.ingredient as Pearl).type.index.toDouble();
        sliderMaxValue = PearlType.values.length.toDouble() - 1;
        ingredient = Pearl(type: PearlType.values[sliderValue.toInt()]);
        break;
      case DrinkSize:
        ingredientName = "容量";
        sliderValue = (widget.ingredient as DrinkSize).cup.index.toDouble();
        sliderMaxValue = Cup.values.length.toDouble() - 1;
        ingredient = DrinkSize(cup: Cup.values[sliderValue.toInt()]);
        break;
      case OtherIngredient:
        ingredientName = "其他配料";
        otherIngredient = (widget.ingredient as OtherIngredient).ingredientName;
        textEditingController = TextEditingController(text: otherIngredient);
        ingredient = OtherIngredient(ingredientName: ingredientName);
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
                  switch (ingredient.runtimeType) {
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
                    case DrinkSize:
                      newIngredient =
                          DrinkSize(cup: Cup.values[sliderValue.toInt()]);
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
                  case DrinkSize:
                    (ingredient as DrinkSize).cup = Cup.values[value.toInt()];
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
                CurvedAnimation(parent: controller, curve: Interval(0.7, 1.0)),
            curve: Curves.ease));

    return AnimatedBuilder(
      animation: dropAnim,
      builder: (context, child) => child,
      child: Stack(
        children: <Widget>[
          Positioned(
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
        ],
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
      case DrinkSize:
        fileName = "cup.png";
        break;
      case OtherIngredient:
        fileName = "other_ingredient.png";
        break;
    }
    return "assets/images/$fileName";
  }
}

class _DrinkMenuImage extends StatefulWidget {
  final String imageUrl;
  final String token;
  final VoidCallback onTap;

  _DrinkMenuImage({Key key, this.token, this.imageUrl, this.onTap})
      : super(key: key);

  @override
  _DrinkMenuImageState createState() => _DrinkMenuImageState();
}

class _DrinkMenuImageState extends State<_DrinkMenuImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl ?? "",
        fit: BoxFit.contain,
        httpHeaders: {"Authorization": "Bearer ${widget.token}"},
      ),
    );
  }
}
