import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprouter/ui/check_in/check_in_bloc.dart';
import 'package:sprouter/ui/check_in/check_in_bloc_provider.dart';

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
      child: Builder(
        builder: (context) {
          bloc = CheckInBlocProvider.of(context);
          return Scaffold(
              appBar: AppBar(
                title: Text("Sprouter"),
              ),
              body: Column(
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
                          stream: bloc.latestJibbleTextTimestamp,
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
                            String statement =
                                text.contains("in") ? "上班" : "下班";
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
                    child: StreamBuilder<String>(
                      stream: bloc.latestJibbleText,
                      builder: (context, snapshot) {
                        String bgFileName;
                        String figureFileName;
                        ;
                        //Default image
                        if (!snapshot.hasData) {
                          bgFileName = "bg_street_day.jpg";
                        } else {
                          //Jibbled in
                          if (snapshot.data.contains("in")) {
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
                              );

                        return Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/$bgFileName",
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              width: 120.0,
                              height: 120.0,
                              left: figureLeft,
                              bottom: figureBottom,
                              child: figureImage,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: StreamBuilder<String>(
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
              ));
        },
      ),
    );
  }
}
