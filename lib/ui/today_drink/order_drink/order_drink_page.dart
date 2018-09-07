import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderDrinkPage extends StatefulWidget {
  @override
  _OrderDrinkPageState createState() => _OrderDrinkPageState();
}

class _OrderDrinkPageState extends State<OrderDrinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Wrap(
                spacing: 16.0,
                runSpacing: 8.0,
                children: <Widget>[
                  InputChip(
                    label: Text("label"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(),
            ),
            Expanded(
              flex: 1,
              child: Center(),
            )
          ],
        ),
      ),
    );
  }
}
