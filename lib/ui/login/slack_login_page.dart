import 'package:flutter/material.dart';
import 'package:flutter_slack_oauth/flutter_slack_oauth.dart';
import 'package:sprouter/ui/login/slack_auth_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/today_drink_page.dart';

/*class SlackLoginPage extends StatefulWidget {
  @override
  _SlackLoginPageState createState() => new _SlackLoginPageState();
}

class _SlackLoginPageState extends State<SlackLoginPage> {
  String _userName;

  @override
  Widget build(BuildContext context) {
    final SlackAuthBlocProvider provider = SlackAuthBlocProvider.of(context);
    if (_userName != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Hi $_userName"),
      ));
    }

    return StreamBuilder<String>(
        stream: provider.bloc.userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _userName = snapshot.data;
            */ /*Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Hi $_userName"),
            ));*/ /*
            */ /*Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Hi ${snapshot.data}"),
              ));*/ /*
            return Center();
          }
          return Center(
              child: SlackButton(
                clientId: "373821001234.373821382898",
                clientSecret: "f0ce30315c4689da519c5281883c0667",
                onSuccess: () {
                  //The library has already saved the token internally
                  provider.bloc.onUserLogin.add(null);
                },
                onFailure: () {
                  */ /*Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('Slack Login Failed'),
                  ));*/ /*
                },
                onCancelledByUser: () {
                  */ /*Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text(
                        'Slack Login Cancelled by user'),
                  ));*/ /*
                },
              ));
        }
    );
  }
}*/

class SlackLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SlackAuthBlocProvider provider = SlackAuthBlocProvider.of(context);
    return StreamBuilder<String>(
        stream: provider.bloc.userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /*Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Hi $_userName"),
            ));*/
            /*Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Hi ${snapshot.data}"),
              ));*/
            return Center();
          }
          return Center(
              child: SlackButton(
            clientId: "373821001234.373821382898",
            clientSecret: "f0ce30315c4689da519c5281883c0667",
            onSuccess: () {
              //The library has already saved the token internally
              provider.bloc.onUserLogin.add(null);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodayDrinkBlocProvider(
                        child: TodayDrinkPage(() {}),
                      ),
                ),
              );
            },
            onFailure: () {
              /*Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('Slack Login Failed'),
                  ));*/
            },
            onCancelledByUser: () {
              /*Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text(
                        'Slack Login Cancelled by user'),
                  ));*/
            },
          ));
        });
  }
}
