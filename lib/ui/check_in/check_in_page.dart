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
                      _buildLastCheckInInfo(context),
                      Expanded(
                        child: _buildBackgroundImage(),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: CheckInFab(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLastCheckInInfo(BuildContext context) {
    return GestureDetector(
      onTap: () => showBottomSheet(
          context: context, builder: (context) => DetailRecordsBottomSheet()),
      child: StreamBuilder(
        stream: bloc.showCheckInBtn,
        builder: (context, snapshot) {
          Color containerColor;
          bool showCheckIn = snapshot.data;
          if (showCheckIn != null && showCheckIn) {
            DateTime now = DateTime.now();
            bool isDayNow = now.hour >= 6 && now.hour < 18;
            containerColor = isDayNow ? Color(0xffb4e0fb) : Color(0xff00121E);
          }
          return Container(
            color: containerColor,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4.0,
              margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
              child: Container(
                alignment: Alignment.center,
                height: 80.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: StreamBuilder<Map<bool, String>>(
                        stream: bloc.latestJibbleStatus,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("無資料");
                          }
                          bool latestCheckInStatus = snapshot.data.keys.first;
                          int timestamp = int.parse(snapshot.data.values.first);
                          String time =
                              Utils.convertTimestamp(seconds: timestamp);
                          String latestCheckIn =
                              latestCheckInStatus ? "上班" : "下班";
                          TextStyle title =
                              Theme.of(context).primaryTextTheme.title;
                          return Text.rich(
                            TextSpan(
                              text: "上次",
                              style: title,
                              children: <TextSpan>[
                                TextSpan(
                                  text: latestCheckIn,
                                  style: title.copyWith(
                                      fontStyle: FontStyle.italic),
                                ),
                                TextSpan(
                                  text: " 時間\n",
                                ),
                                TextSpan(
                                  text: time,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    StreamBuilder<bool>(
                        stream: bloc.isReminderEnabled,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox.shrink();
                          }
                          bool isReminderEnabled = snapshot.data;
                          return IconButton(
                              icon: Icon(
                                isReminderEnabled
                                    ? FontAwesomeIcons.solidBell
                                    : FontAwesomeIcons.solidBellSlash,
                                color: isReminderEnabled ? Colors.yellow : null,
                              ),
                              onPressed: () async {
                                await bloc
                                    .changeReminderStatus(!isReminderEnabled);
                                String snackBarText =
                                    isReminderEnabled ? "打卡提醒已解除" : "打卡提醒已啟動";
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(snackBarText)));
                              });
                        }),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.angleDown,
                          color: Colors.grey,
                        ),
                        onPressed: () => showBottomSheet(
                            context: context,
                            builder: (context) => DetailRecordsBottomSheet())),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return StreamBuilder<bool>(
      stream: bloc.showCheckInBtn.stream,
      builder: (context, snapshot) {
        String bgFileName;
        bool isDayNow;

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
            isDayNow = now.hour >= 6 && now.hour < 18;
            bgFileName = isDayNow ? "bg_street_day.jpg" : "bg_street_night.jpg";
          }
        }
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              transitionBuilder: (child, Animation<double> animation) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              layoutBuilder: (currentChild, previousChildren) {
                List<Widget> children = previousChildren;
                if (currentChild != null) {
                  children = children.toList()..add(currentChild);
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
            AnimatedFigure(isDayNow),
          ],
        );
      },
    );
  }
}

class AnimatedFigure extends StatefulWidget {
  final bool isDayNow;
  final bool isMale = Random().nextBool();

  AnimatedFigure(this.isDayNow);

  @override
  _AnimatedFigureState createState() => _AnimatedFigureState();
}

class _AnimatedFigureState extends State<AnimatedFigure>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDayNow = widget.isDayNow;
    double screenHeight = MediaQuery.of(context).size.height;
    double figureBottom = screenHeight * 0.03;

    String figureFileName = "man_on_duty.png";
    if (isDayNow != null) {
      if (isDayNow) {
        figureFileName =
            widget.isMale ? "man_on_duty.png" : "woman_on_duty.png";
      } else {
        figureFileName =
            widget.isMale ? "man_off_duty.png" : "woman_off_duty.png";
      }
    }
    Widget figureImage = isDayNow == null || figureFileName == null
        ? Container()
        : Image.asset(
            "assets/images/$figureFileName",
            fit: BoxFit.contain,
            key: ValueKey(Random().nextInt(1000)),
          );
    Animation<Offset> walkingAnimation;
    Animation<double> rotateAnimation;
    var animations = generateFigureAnimations(_controller, isDayNow);
    walkingAnimation =
        animations?.firstWhere((anim) => anim is Animation<Offset>);
    rotateAnimation =
        animations?.firstWhere((anim) => anim is Animation<double>);
    if (isDayNow != null) {
      _controller?.repeat();
    }

    return Positioned(
      width: 120.0,
      height: 120.0,
      left: isDayNow != null && isDayNow ? 0.0 : null,
      right: isDayNow != null && !isDayNow ? 0.0 : null,
      bottom: figureBottom,
      child: AnimatedSwitcher(
        child: figureImage,
        duration: Duration(seconds: 1),
        transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: isDayNow != null
                  ? SlideTransition(
                      position: walkingAnimation,
                      child: RotationTransition(
                        turns: rotateAnimation,
                        child: child,
                      ),
                    )
                  : child,
            ),
      ),
    );
  }

  List<dynamic> generateFigureAnimations(
      AnimationController controller, bool isDayNow) {
    if (controller == null || isDayNow == null) {
      return null;
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final double figureWidth = 120.0;
    int steps = (screenWidth / figureWidth).ceil() + 1;

    double step = isDayNow ? 1.0 : -1.0;
    final double rotateAngle = 0.04;

    List<TweenSequenceItem<Offset>> walkingTweenItems = [];
    List<TweenSequenceItem<double>> rotateTweenItems = [];

    double startPos = isDayNow ? -1.0 : 1.0;
    double lastStep;
    double lastEndAngle;
    for (int i = 0; i < steps; i++) {
      TweenSequenceItem<Offset> walkingTweenItem = TweenSequenceItem(
        tween: Tween<Offset>(
                begin: Offset(lastStep ?? startPos, 0.0),
                end: Offset(step * i, 0.0))
            .chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
        weight: 1.0,
      );
      walkingTweenItems.add(walkingTweenItem);
      lastStep = step * i;

      double angle = i.isEven ? rotateAngle : -rotateAngle;
      TweenSequenceItem<double> rotateTweenItem = TweenSequenceItem(
        tween: Tween<double>(begin: lastEndAngle ?? -rotateAngle, end: angle)
            .chain(CurveTween(curve: Curves.ease)),
        weight: 1.0,
      );
      rotateTweenItems.add(rotateTweenItem);
      lastEndAngle = angle;
    }
    Animation<Offset> walkingAnimation =
        TweenSequence(walkingTweenItems).animate(controller);
    Animation<double> rotateAnimation =
        TweenSequence(rotateTweenItems).animate(controller);
    return [walkingAnimation, rotateAnimation];
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
