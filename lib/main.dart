import 'package:flutter/material.dart';
import 'package:flutter_slack_oauth/flutter_slack_oauth.dart';
import 'package:flutter_slack_oauth/oauth/slack.dart' as slack;
import 'dart:developer';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Slack OAuth Example"),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Center(
            child: new SlackButton(
              clientId: "373821001234.373821382898",
              clientSecret: "f0ce30315c4689da519c5281883c0667",
              onSuccess: () async {
                String accessToken = await Token.getLocalAccessToken();
                UserList users = await slack.getUsers(accessToken);

                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text('We found ' +
                      users.users.length.toString() +
                      ' users'),
                ));
              },
              onFailure: () {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text('Slack Login Failed'),
                ));
              },
              onCancelledByUser: () {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text('Slack Login Cancelled by user'),
                ));
              },
            ),
          );
        },
      ),
    ),
  ));
}
