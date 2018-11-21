import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprouter/ui/check_in/check_in_bloc.dart';
import 'package:sprouter/ui/check_in/check_in_bloc_provider.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  CheckInBloc _bloc;

  @override
  Widget build(BuildContext context) {
    //_bloc = CheckInBlocProvider.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double figureLeft = screenWidth * (0.4 - 120 / screenWidth / 2);
    double figureBottom = screenHeight * 0.01;
    return CheckInBlocProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sprouter"),
        ),
        body: Builder(
          builder: (context) {
            _bloc = CheckInBlocProvider.of(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.grey,
                  height: 80.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<List<String>>(
                        stream: _bloc.latestJibbleTextTimestamp,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("無資料");
                          }
                          String text = snapshot.data[0];
                          String timestamp = snapshot.data[1];
                          String time = DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(timestamp) * 1000)
                              .toString();
                          String displayTime =
                              time.substring(0, time.lastIndexOf(":"));
                          String statement = text.contains("in") ? "上班" : "下班";
                          return Text(
                            "上次$statement時間：$displayTime",
                            style: Theme.of(context).primaryTextTheme.title,
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
                Flexible(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/bg_street_day.jpg",
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        width: 120.0,
                        height: 120.0,
                        left: figureLeft,
                        bottom: figureBottom,
                        child: Image.asset(
                          "assets/images/man_on_duty.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
