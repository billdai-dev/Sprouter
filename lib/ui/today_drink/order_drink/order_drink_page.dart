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
                children: <Widget>[
                  InputChip(
                    label: Text("label"),
                  ),
                  InputChip(
                    label: Text("label2"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Text("I want to drink... "),
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
                                      child: TextField(),
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
                                    Center(
                                      child: Draggable(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/images/ice.png",
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              Text("test"),
                                            ],
                                          ),
                                          dragAnchor: DragAnchor.pointer,
                                          feedback: Icon(Icons.repeat)),
                                    ),
                                    Center(
                                      child: Draggable(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/images/sugar.png",
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              Text("test"),
                                            ],
                                          ),
                                          dragAnchor: DragAnchor.pointer,
                                          feedback: Icon(Icons.repeat)),
                                    ),
                                    Center(
                                      child: Draggable(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/images/pearl.png",
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              Text("test"),
                                            ],
                                          ),
                                          dragAnchor: DragAnchor.pointer,
                                          feedback: Icon(Icons.repeat)),
                                    ),
                                    Center(
                                      child: Draggable(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/images/coconut.png",
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              Text("test"),
                                            ],
                                          ),
                                          dragAnchor: DragAnchor.pointer,
                                          feedback: Icon(Icons.repeat)),
                                    ),
                                    Center(
                                      child: Draggable(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(Icons.forward),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              Text("test"),
                                            ],
                                          ),
                                          dragAnchor: DragAnchor.pointer,
                                          feedback: Icon(Icons.repeat)),
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
}
