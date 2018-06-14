import 'package:flutter/material.dart';
import 'package:flutter_slack_oauth/flutter_slack_oauth.dart';
import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:flutter_slack_oauth/oauth/slack.dart' as slack;
import 'package:scoped_model/scoped_model.dart';
import 'package:sprouter/scoped_model/MainModel.dart';
import 'package:sprouter/scoped_model/SlackAuthModel.dart';

void main() {
  int _pageIndex = 0;
  runApp(new ScopedModel<MainModel>(
    model: new MainModel(),
    child: new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Sprouter"),
          ),
          body: new Builder(
            builder: (BuildContext context) {
              return new ScopedModelDescendant<MainModel>(
                builder: (context, _, mainModel) =>
                new Center(
                  child: new ScopedModel<SlackAuthModel>(
                    model: new SlackAuthModel(),
                    child: new ScopedModelDescendant<SlackAuthModel>(
                      builder: (context, _, authModel) =>
                      new SlackButton(
                        clientId: authModel.slackClientId,
                        clientSecret: authModel.slackClientSecret,
                        onSuccess: () async {
                          //The library has already saved the token internally
                          String accessToken =
                          await Token.getLocalAccessToken();
                          UserIdentity user =
                          await slack.getUserIdentity(accessToken);

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
                    ),
                  ),
                ),
                child: new Center(),
              );
            },
          ),
          bottomNavigationBar: new BottomNavigationBar(
              currentIndex: _pageIndex,
              onTap: (int index) {
                _pageIndex = index;
                setState(() {

                });
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
    ),
  ));
}
