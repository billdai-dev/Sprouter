import 'dart:async';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slack_oauth/oauth/slack_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/today_drink/detail_photo/detail_photo_page.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';

class TodayDrinkPage extends StatefulWidget {
  final GestureTapCallback onItemClick;

  TodayDrinkPage(this.onItemClick, {Key key}) : super(key: key);

  @override
  TodayDrinkPageState createState() {
    return TodayDrinkPageState();
  }
}

class TodayDrinkPageState extends State<TodayDrinkPage> {
  static const String _ARG_TOKEN = "token";
  static const String _ARG_MESSAGES = "messages";
  static const String _CLIENT_ID = "373821001234.373821382898";
  static const String _CLIENT_SECRET = "f0ce30315c4689da519c5281883c0667";
  static const String _REDIRECT_URL =
      "https://kunstmaan.github.io/flutter_slack_oauth/success.html";

  bool _isInited = false;

  Widget _createScrollView(BuildContext context) {
    TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        StreamBuilder<Map<String, dynamic>>(
          stream:
              bloc?.slackToken?.zipWith(bloc?.drinkMessage, (token, message) {
            return {_ARG_MESSAGES: message, _ARG_TOKEN: token};
          }),
          builder: (context, snapshot) {
            return SliverAppBar(
                expandedHeight: 250.0,
                pinned: true,
                floating: false,
                title: _createTitle(snapshot),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.slack,
                    ),
                    onPressed: () async {
                      bool success = await Navigator.of(context)
                          .push(MaterialPageRoute<bool>(
                        builder: (BuildContext context) =>
                            new SlackLoginWebViewPage(
                              clientId: _CLIENT_ID,
                              clientSecret: _CLIENT_SECRET,
                              redirectUrl: _REDIRECT_URL,
                            ),
                      ));
                      if (success) {
                        TodayDrinkBlocProvider.of(context)
                            .fetchMessage
                            .add(null);
                      }
                    },
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: _createImage(context, snapshot)));
          },
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => _createRefreshCallback(context),
        ),
        StreamBuilder<BuiltList<Message>>(
          stream: bloc?.drinkMessage,
          builder: (context, snapshot) {
            return _createReplyListView(context, snapshot.data);
          },
        )
      ],
    );
  }

  Widget _createReplyListView(
      BuildContext context, BuiltList<Message> drinkThread) {
    List<Message> replies;
    if (drinkThread == null ||
        (replies = drinkThread?.skip(1)?.toList(growable: false)) == null ||
        replies.isEmpty) {
      return SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()));
    }
    Message lastOrderKeywords = drinkThread.lastWhere((message) {
      return message.text == "點單" || message.text == "收單";
    }, orElse: () => null);
    if (lastOrderKeywords == null || lastOrderKeywords.text == "收單") {
      return SliverFillRemaining(child: Center(child: Text("Closed")));
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
                children: <Widget>[
                  ListTile(
                    title: Text(replies[index].text),
                    onTap: widget.onItemClick,
                  ),
                  Divider(height: 2.0)
                ],
              ),
          childCount: replies.length),
    );
  }

  Widget _createTitle(AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Text("");
    }
    BuiltList<Message> drinkThread = snapshot.data[_ARG_MESSAGES];
    List<String> parsedTitle = drinkThread[0]?.files[0]?.title?.split(" ");
    String shopName =
        parsedTitle.isEmpty || parsedTitle.length < 2 ? "" : parsedTitle[1];
    return Text(
      shopName,
      style: TextStyle(
        color: Colors.black87,
      ),
    );
  }

  Widget _createImage(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Container(
          color: Colors.grey,
          child: Center(child: CircularProgressIndicator()));
    }
    BuiltList<Message> messages = snapshot.data[_ARG_MESSAGES];

    String imageUrl = messages[0].files[0].urlPrivate;
    String token = snapshot.data[_ARG_TOKEN];

    return Container(
      color: Colors.grey,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: false).push(
            MaterialPageRoute(
              builder: (context) => DetailPhotoPage(imageUrl, token),
            ),
          );
        },
        child: Hero(
          tag: "photo",
          child: CachedNetworkImage(
            placeholder: Center(child: CircularProgressIndicator()),
            imageUrl: messages[0].files[0].urlPrivate,
            fit: BoxFit.contain,
            httpHeaders: {"Authorization": "Bearer $token"},
          ),
        ),
      ),
    );
  }

  Future<void> _createRefreshCallback(BuildContext context) async {
    TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
    bloc?.fetchMessage?.add(null);
    try {
      await bloc.drinkMessage.timeout(Duration(seconds: 3)).forEach((messages) {
        print(messages);
      });
    } catch (e) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
    if (!_isInited) {
      bloc?.fetchMessage?.add(null);
      _isInited = true;
    }

    return Scaffold(
      body: Platform.isIOS
          ? _createScrollView(context)
          : RefreshIndicator(
              child: _createScrollView(context),
              onRefresh: () => _createRefreshCallback(context),
            ),
    );
  }
}
