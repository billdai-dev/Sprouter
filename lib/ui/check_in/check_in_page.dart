import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/check_in/check_in_bloc.dart';
import 'package:sprouter/ui/check_in/check_in_bloc_provider.dart';
import 'package:sprouter/util/utils.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  CheckInBloc bloc;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double figureLeft = screenWidth * (0.4 - 120 / screenWidth / 2);
    double figureBottom = screenHeight * 0.01;

    return CheckInBlocProvider(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Builder(
          builder: (context) {
            bloc = CheckInBlocProvider.of(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("Sprouter"),
              ),
              body: Builder(
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (context) => DetailRecordsBottomSheet());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          height: 80.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              StreamBuilder<Map<bool, String>>(
                                stream: bloc.latestJibbleStatus,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("無資料");
                                  }
                                  bool latestCheckInStatus =
                                      snapshot.data.keys.first;
                                  int timestamp =
                                      int.parse(snapshot.data.values.first);
                                  String time = Utils.convertTimestamp(
                                      seconds: timestamp);
                                  String latestCheckIn =
                                      latestCheckInStatus ? "上班" : "下班";
                                  return Text(
                                    "上次$latestCheckIn時間：$time",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .title,
                                  );
                                },
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              IconButton(
                                  icon: Icon(FontAwesomeIcons.bellSlash),
                                  onPressed: () {})
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<bool>(
                          stream: bloc.showCheckInBtn.stream,
                          builder: (context, snapshot) {
                            String bgFileName;
                            String figureFileName;
                            //Default image
                            if (!snapshot.hasData) {
                              bgFileName = "bg_street_day.jpg";
                            } else {
                              bool shouldShowCheckIn = snapshot.data;
                              //Jibbled in
                              if (!shouldShowCheckIn) {
                                bgFileName = "bg_working.png";
                              }
                              //Jibbled out
                              else {
                                DateTime now = DateTime.now();
                                bool isDayNow = now.hour >= 6 && now.hour < 18;
                                bgFileName = isDayNow
                                    ? "bg_street_day.jpg"
                                    : "bg_street_night.jpg";
                                figureFileName = isDayNow
                                    ? "man_on_duty.png"
                                    : "man_off_duty.png";
                              }
                            }
                            Widget figureImage = figureFileName == null
                                ? Container()
                                : Image.asset(
                                    "assets/images/$figureFileName",
                                    fit: BoxFit.contain,
                                    key: ValueKey(Random().nextInt(1000)),
                                  );

                            return Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                AnimatedSwitcher(
                                  duration: Duration(seconds: 1),
                                  transitionBuilder:
                                      (child, Animation<double> animation) =>
                                          FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                  layoutBuilder:
                                      (currentChild, previousChildren) {
                                    List<Widget> children = previousChildren;
                                    if (currentChild != null) {
                                      children = children.toList()
                                        ..add(currentChild);
                                    }
                                    return Stack(
                                      fit: StackFit.expand,
                                      children: children,
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/images/$bgFileName",
                                    key: ValueKey(Random().nextInt(1000)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  width: 120.0,
                                  height: 120.0,
                                  left: figureLeft,
                                  bottom: figureBottom,
                                  child: AnimatedSwitcher(
                                    child: figureImage,
                                    duration: Duration(seconds: 1),
                                    transitionBuilder: (child, animation) =>
                                        FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: CheckInFab()
                  /*floatingActionButton: StreamBuilder<String>(
                stream: bloc.latestJibbleText,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  bool isCheckedIn = snapshot.data.contains("in");
                  IconData icon = isCheckedIn
                      ? FontAwesomeIcons.signOutAlt
                      : FontAwesomeIcons.signInAlt;
                  String label = isCheckedIn ? "下班啦" : "上班啦";

                  return FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).accentColor,
                    onPressed: () {
                      bloc.checkInOrOut(!isCheckedIn);
                    },
                    icon: Icon(icon),
                    label: Text(label),
                  );
                },
              )*/
                  ,
            );
          },
        ),
      ),
    );
  }
}

class CheckInFab extends StatefulWidget {
  @override
  _CheckInFabState createState() => _CheckInFabState();
}

class _CheckInFabState extends State<CheckInFab>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CheckInBloc bloc;

  static const List<IconData> icons = const [
    FontAwesomeIcons.signInAlt,
    FontAwesomeIcons.signOutAlt,
  ];

  final Animatable<Offset> _slideAnimatable = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset(0.0, -0.2),
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));
  final Animatable<double> _scaleAnimatable = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = CheckInBlocProvider.of(context);
    return StreamBuilder<bool>(
      stream: bloc.showCheckInBtn.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        bool shouldShowCheckIn = snapshot.data;
        IconData icon = shouldShowCheckIn
            ? FontAwesomeIcons.signInAlt
            : FontAwesomeIcons.signOutAlt;
        String label = shouldShowCheckIn ? "上班啦" : "下班啦";

        Widget extendedFab = GestureDetector(
          onLongPress: () => bloc.checkInOrOut(shouldShowCheckIn),
          child: FloatingActionButton.extended(
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            icon: Icon(icon),
            label: Text(label),
          ),
        );

        IconData anotherIcon = shouldShowCheckIn
            ? FontAwesomeIcons.signOutAlt
            : FontAwesomeIcons.signInAlt;

        Widget anotherFab = SlideTransition(
          position: _slideAnimatable.animate(_controller),
          child: ScaleTransition(
            scale: _scaleAnimatable.animate(_controller),
            child: FloatingActionButton(
              onPressed: () {
                if (_controller.isCompleted) {
                  _controller.reverse();
                }
                bloc.showCheckInBtn.add(!shouldShowCheckIn);
              },
              //backgroundColor: backgroundColor,
              mini: true,
              child: Icon(anotherIcon),
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            anotherFab,
            extendedFab,
          ],
        );
      },
    );
  }
}

class DetailRecordsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CheckInBloc bloc = CheckInBlocProvider.of(context);
    return StreamBuilder<List<Message>>(
      stream: bloc.jibbleRecords,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
        double bottomSheetHeight = MediaQuery.of(context).size.height * 0.3;
        return Container(
          height: bottomSheetHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "最近打卡記錄",
                style: Theme.of(context).primaryTextTheme.title,
              ),
              SizedBox(
                height: 4.0,
              ),
              Divider(
                height: 1.0,
              ),
              SizedBox(
                height: 4.0,
              ),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Message message = snapshot.data[index];
                    bool isOnDuty = message.text.contains("in");
                    String duty = isOnDuty ? "上班" : "下班";
                    int timestamp = int.parse(message.ts.split(".")[0]);
                    String time = Utils.convertTimestamp(seconds: timestamp);
                    IconData leadingIcon = isOnDuty
                        ? FontAwesomeIcons.signInAlt
                        : FontAwesomeIcons.signOutAlt;
                    return ListTile(
                      leading: Icon(leadingIcon),
                      title: Text("於 $time $duty",
                          style: Theme.of(context).primaryTextTheme.subhead),
                    );
                  },
                  reverse: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
