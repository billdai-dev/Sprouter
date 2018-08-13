import 'package:flutter/material.dart';
import 'package:flutter_slack_oauth/flutter_slack_oauth.dart';
import 'package:sprouter/ui/login/SlackAuthBlocProvider.dart';

class SlackLoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SlackAuthBlocProvider provider = SlackAuthBlocProvider.of(context);
    return StreamBuilder<String>(
        stream: provider.bloc.userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /*Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("Hi ${snapshot.data}"),
            ));
            return Center();*/
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
        }
    );
  }
}