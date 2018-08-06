import 'package:flutter/material.dart';
import 'package:flutter_slack_oauth/flutter_slack_oauth.dart';
import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:flutter_slack_oauth/oauth/slack.dart' as slack;

void main() {
  int _pageIndex = 0;
  runApp(new MaterialApp(
    home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Sprouter"),
        ),
        body: new Builder(
          builder: (BuildContext context) {
            return Center(
              child: SlackButton(
                clientId: "373821001234.373821382898",
                clientSecret: "f0ce30315c4689da519c5281883c0667",
                onSuccess: () async {
                  //The library has already saved the token internally
                  

                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("Hi ${user?.user?.name}"),
                  ));
                },
                onFailure: () {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('Slack Login Failed'),
                  ));
                },
                onCancelledByUser: () {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text(
                        'Slack Login Cancelled by user'),
                  ));
                },
              ),
            );
          },
        ),
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: (int index) {
              _pageIndex = index;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              new BottomNavigationBarItem(
                  icon: const Icon(Icons.star),
                  title: new Text('First'),
                  backgroundColor: Colors.lightBlue
              ),

              new BottomNavigationBarItem(
                  icon: const Icon(Icons.star),
                  title: new Text('Second'),
                  backgroundColor: Colors.red
              )
            ]

        )
    ),
  ));
}
