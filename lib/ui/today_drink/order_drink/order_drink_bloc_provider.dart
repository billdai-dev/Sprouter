import 'package:flutter/material.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc.dart';

class OrderDrinkBlocProvider extends StatefulWidget {
  final Widget child;
  final Message drinkShopMessage;

  OrderDrinkBlocProvider({Key key, @required this.drinkShopMessage, this.child})
      : super(key: key);

  @override
  _OrderDrinkBlocProviderState createState() => _OrderDrinkBlocProviderState();

  static OrderDrinkBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_OrderDrinkBlocProvider)
              as _OrderDrinkBlocProvider)
          ?.bloc;
}

class _OrderDrinkBlocProviderState extends State<OrderDrinkBlocProvider> {
  OrderDrinkBloc _bloc;

  @override
  void initState() {
    _bloc = OrderDrinkBloc(drinkShopMessage: widget.drinkShopMessage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _OrderDrinkBlocProvider(
      bloc: _bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }
}

class _OrderDrinkBlocProvider extends InheritedWidget {
  final OrderDrinkBloc bloc;

  _OrderDrinkBlocProvider({Key key, @required this.bloc, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is _OrderDrinkBlocProvider) {
      return oldWidget.bloc != bloc;
    }
    return oldWidget != this;
  }
}
