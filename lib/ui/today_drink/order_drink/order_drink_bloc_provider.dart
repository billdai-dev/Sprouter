import 'package:flutter/material.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc.dart';

class OrderDrinkBlocProvider extends StatefulWidget {
  final Widget child;
  final Message drinkShop;
  final Message selectedOrder;

  OrderDrinkBlocProvider(
      {Key key, @required this.drinkShop, this.selectedOrder, this.child})
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
    super.initState();
    _bloc = OrderDrinkBloc(
        drinkShop: widget.drinkShop, selectedOrder: widget.selectedOrder);
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
