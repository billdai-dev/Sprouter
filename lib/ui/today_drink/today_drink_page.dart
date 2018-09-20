import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/slack_login/slack_login_web_view_page.dart';
import 'package:sprouter/ui/today_drink/detail_photo/detail_photo_page.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_page.dart';
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

class TodayDrinkPageState extends State<TodayDrinkPage>
    with SingleTickerProviderStateMixin {
  static const String _ARG_TOKEN = "token";
  static const String _ARG_MESSAGES = "messages";

  bool _isInited = false;
  AnimationController _slackIconController;
  Animation<double> _slackIconAnimation;

  @override
  void initState() {
    super.initState();
    _slackIconController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slackIconAnimation =
        Tween(begin: 24.0, end: 30.0).animate(_slackIconController);
    _slackIconController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _slackIconController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _slackIconController.forward();
      }
    });
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
      floatingActionButton: _AddDrinkFab(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => OrderDrinkBlocProvider(
                  threadTs: bloc?.threadTs,
                  child: OrderDrinkPage(),
                ),
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _slackIconController?.dispose();
    super.dispose();
  }

  Widget _createScrollView(BuildContext context) {
    TodayDrinkBloc todayDrinkBloc = TodayDrinkBlocProvider.of(context);
    SlackLoginBloc slackLoginBloc = SlackLoginBlocProvider.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        StreamBuilder<Map<String, dynamic>>(
          stream: Observable.combineLatest2(
              slackLoginBloc?.getTokenCache,
              todayDrinkBloc?.drinkMessage,
              (token, message) => {_ARG_MESSAGES: message, _ARG_TOKEN: token}),
          builder: (context, snapshot) {
            List<Message> messages =
                snapshot.hasData ? snapshot.data[_ARG_MESSAGES] : [];
            String token = snapshot.hasData ? snapshot.data[_ARG_TOKEN] : "";
            if (token == null || token.isEmpty) {
              _slackIconController?.forward();
            } else {
              _slackIconController.stop();
            }
            return SliverAppBar(
                expandedHeight: 250.0,
                pinned: true,
                floating: false,
                title: _createTitle(messages),
                actions: <Widget>[
                  _SlackLoginAction(
                    animation: _slackIconAnimation,
                    onPressed: () async {
                      bool success = await Navigator.of(context)
                          .push(MaterialPageRoute<bool>(
                        builder: (BuildContext context) =>
                            SlackLoginWebViewPage(),
                      ));
                      if (success) {
                        todayDrinkBloc.fetchMessage.add(null);
                      }
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: _createImage(context, token, messages)));
          },
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => _createRefreshCallback(context),
        ),
        StreamBuilder<List<Message>>(
          stream: todayDrinkBloc?.drinkMessage,
          builder: (context, snapshot) {
            return _createReplyListView(context, snapshot.data);
          },
        )
      ],
    );
  }

  Future<void> _createRefreshCallback(BuildContext context) async {
    TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
    bloc?.fetchMessage?.add(null);
    await bloc.drinkMessage
        .timeout(Duration(seconds: 3), onTimeout: (sink) => sink.close())
        .forEach((messages) {});
    return null;
  }

  Widget _createReplyListView(BuildContext context, List<Message> drinkThread) {
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

  Widget _createTitle(List<Message> messages) {
    if (messages == null || messages.isEmpty) {
      return Text("");
    }
    List<String> parsedTitle = messages[0]?.files[0]?.title?.split(" ");
    String shopName =
        parsedTitle.isEmpty || parsedTitle.length < 2 ? "" : parsedTitle[1];
    return Text(
      shopName,
      style: TextStyle(
        color: Colors.black87,
      ),
    );
  }

  Widget _createImage(
      BuildContext context, String token, List<Message> messages) {
    print("token:$token");
    if (messages == null || messages.isEmpty) {
      return Container(
          color: Colors.grey,
          child: Center(child: CircularProgressIndicator()));
    }
    String imageUrl = messages[0].files[0].urlPrivate;
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
}

class _AddDrinkFab extends StatefulWidget {
  final VoidCallback onPressed;

  _AddDrinkFab({Key key, @required this.onPressed}) : super(key: key);

  @override
  __AddDrinkFabState createState() => __AddDrinkFabState();
}

class __AddDrinkFabState extends State<_AddDrinkFab>
    with SingleTickerProviderStateMixin {
  Animation<double> anim;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    anim = Tween(begin: 24.0, end: 30.0).animate(controller);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
    return StreamBuilder<bool>(
      stream: bloc?.isOrdering,
      builder: (context, snapshot) {
        snapshot.hasData ? controller?.forward() : controller?.stop();
        return Offstage(
          offstage: !snapshot.data ?? true,
          child: AnimatedBuilder(
            animation: anim,
            builder: (context, child) {
              return FloatingActionButton(
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: anim?.value ?? 24.0,
                ),
                onPressed:
                    snapshot.hasData && snapshot.data ? widget.onPressed : null,
              );
            },
          ),
        );
      },
    );
  }
}

class _SlackLoginAction extends AnimatedWidget {
  final VoidCallback onPressed;

  _SlackLoginAction(
      {Key key, Animation<double> animation, @required this.onPressed})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return IconButton(
      color: Colors.white,
      icon: Icon(
        FontAwesomeIcons.slack,
        size: animation?.value ?? 24.0,
      ),
      onPressed: onPressed,
    );
  }
}
