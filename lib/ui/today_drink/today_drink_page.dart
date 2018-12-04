import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprouter/data/model/message.dart';
import 'package:sprouter/data/remote/api_error.dart';
import 'package:sprouter/ui/check_in/check_in_bloc_provider.dart';
import 'package:sprouter/ui/empty_data_view.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/slack_login/slack_login_web_view_page.dart';
import 'package:sprouter/ui/today_drink/detail_photo/detail_photo_page.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink/order_drink/order_drink_page.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc.dart';
import 'package:sprouter/ui/today_drink/today_drink_bloc_provider.dart';
import 'package:sprouter/util/utils.dart';

class TodayDrinkPage extends StatefulWidget {
  TodayDrinkPage({Key key}) : super(key: key);

  @override
  TodayDrinkPageState createState() {
    return TodayDrinkPageState();
  }
}

class TodayDrinkPageState extends State<TodayDrinkPage>
    with SingleTickerProviderStateMixin {
  static const String _ARG_TOKEN = "token";
  static const String _ARG_MESSAGES = "messages";

  GlobalKey<ScaffoldState> _scaffoldKey;

  TodayDrinkBloc todayDrinkBloc;
  SlackLoginBloc slackLoginBloc;

  StreamSubscription drinkMessagesErrorHandler;

  AnimationController _slackIconController;
  Animation<double> _slackIconAnimation;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();

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
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        TodayDrinkBloc bloc = TodayDrinkBlocProvider.of(context);
        bloc?.fetchMessage?.add(null);
        bloc?.showMoreContentIndicator?.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    todayDrinkBloc = TodayDrinkBlocProvider.of(context);
    drinkMessagesErrorHandler ??=
        todayDrinkBloc.drinkMessage.listen((_) {}, onError: (e) {
      if (e is AuthError) {
        _scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text("使用者資料異常，請重新登入"),
        ));
      }
    });
    slackLoginBloc = SlackLoginBlocProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Platform.isIOS
              ? _buildScrollView()
              : RefreshIndicator(
                  child: _buildScrollView(),
                  onRefresh: () => _buildRefreshCallback(),
                ),
          Positioned(
            child: _buildShowMoreContentButton(),
            bottom: 20.0,
          )
        ],
      ),
      floatingActionButton: _AddDrinkFab(
        onPressed: () => _showOrderDrinkPage(),
      ),
    );
  }

  @override
  void dispose() {
    _slackIconController?.dispose();
    _scrollController?.dispose();
    drinkMessagesErrorHandler?.cancel();
    super.dispose();
  }

  void _showOrderDrinkPage({Message message}) async {
    bool isDrinkOrdered =
        await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => OrderDrinkBlocProvider(
            drinkShop: todayDrinkBloc?.drinkShopMessage,
            selectedOrder: message,
            child: OrderDrinkPage(),
          ),
    ));
    isDrinkOrdered ??= false;
    if (!isDrinkOrdered) {
      return;
    }
    todayDrinkBloc?.forceFetchMessage?.add(null);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message == null ? "訂單已送出" : "訂單已編輯"),
      duration: Duration(seconds: 2),
    ));
  }

  Widget _buildShowMoreContentButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: StreamBuilder<bool>(
        stream: todayDrinkBloc?.showMoreContentIndicator?.stream,
        initialData: false,
        builder: (context, snapshot) {
          return Visibility(
            child: RaisedButton.icon(
              label: Text("查看最新內容"),
              icon: Icon(Icons.arrow_downward),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.greenAccent,
              onPressed: () {
                _scrollController?.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
                todayDrinkBloc?.showMoreContentIndicator?.add(false);
              },
            ),
            visible: snapshot.hasData && snapshot.data,
          );
        },
      ),
    );
  }

  Widget _buildScrollView() {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: <Widget>[
        StreamBuilder<Map<String, dynamic>>(
          stream: Observable.combineLatest2(
              slackLoginBloc?.getTokenCache,
              todayDrinkBloc?.drinkMessage,
              (token, message) => {_ARG_MESSAGES: message, _ARG_TOKEN: token}),
          builder: (context, snapshot) {
            List<Message> messages =
                snapshot.hasData ? snapshot.data[_ARG_MESSAGES] : null;
            String token = snapshot.hasData ? snapshot.data[_ARG_TOKEN] : "";
            if (token == null || token.isEmpty) {
              _slackIconController?.forward();
            } else {
              _slackIconController.stop();
            }
            return SliverAppBar(
              expandedHeight: 220.0,
              pinned: true,
              floating: false,
              title: _buildTitle(messages),
              actions: <Widget>[
                _SlackLoginAction(
                  animation: _slackIconAnimation,
                  onPressed: () async {
                    bool success = await Navigator.of(
                      context,
                      rootNavigator: true,
                    ).push(MaterialPageRoute<bool>(
                      builder: (BuildContext context) =>
                          SlackLoginWebViewPage(),
                    ));
                    if (success != null && success) {
                      CheckInBlocProvider.of(context)
                          .fetchLatestJibbleMessage();
                      todayDrinkBloc?.forceFetchMessage?.add(null);
                    }
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: snapshot.hasError
                    ? Container(
                        color: Colors.grey,
                        child: EmptyDataView("登入 Slack 以查看最新飲料訂單"),
                      )
                    : _buildShopImage(context, token, messages),
              ),
            );
          },
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => _buildRefreshCallback(),
        ),
        StreamBuilder<List<Message>>(
          stream: todayDrinkBloc?.drinkMessage,
          builder: (context, snapshot) =>
              _buildReplyListView(context, snapshot),
        )
      ],
    );
  }

  Future<void> _buildRefreshCallback() async {
    todayDrinkBloc?.forceFetchMessage?.add(null);
    await todayDrinkBloc.drinkMessage
        .timeout(Duration(seconds: 3), onTimeout: (sink) => sink.close())
        .forEach((messages) {});
    return null;
  }

  Widget _buildReplyListView(
      BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
    if (snapshot.hasError) {
      return SliverFillRemaining(
        child: EmptyDataView("登入 Slack 以查看最新飲料訂單"),
      );
    }
    List<Message> drinkThread = snapshot.data;
    List<Message> replies;
    if (Utils.isListNullOrEmpty(drinkThread)) {
      Widget child = drinkThread == null
          ? CircularProgressIndicator()
          : EmptyDataView("快叫 peipei 開單\n ლ(•ω •ლ)");
      return SliverFillRemaining(
        child: Center(child: child),
      );
    }
    replies = drinkThread.skip(1).toList(growable: false);

    Message lastOrderKeywords = drinkThread.lastWhere((message) {
      return message.text == "點單" || message.text == "收單";
    }, orElse: () => null);
    if (lastOrderKeywords == null) {
      return SliverFillRemaining(
        child: Center(
          child: Text("無法取得訂單狀態"),
        ),
      );
    }
    bool isOrdering = lastOrderKeywords.text == "點單";

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: <Widget>[
            _buildMessageTile(isOrdering, index, replies[index]),
            Divider(height: 2.0)
          ],
        );
      }, childCount: replies.length),
    );
  }

  Widget _buildMessageTile(bool isOrdering, int index, Message reply) {
    bool isAddedBySprouter = reply?.isAddedBySprouter ?? false;
    bool isFavoriteDrink =
        isAddedBySprouter && (reply?.isFavoriteDrink ?? false);

    Widget _buildTrailingIcon() {
      if (isFavoriteDrink) {
        return Icon(
          FontAwesomeIcons.solidHeart,
          color: Colors.redAccent,
        );
      }
      if (isAddedBySprouter) {
        return Icon(
          FontAwesomeIcons.leaf,
          color: Color(0xff50bf37),
        );
      }
      return null;
    }

    String userName = reply?.userProfile?.displayName;
    userName = Utils.isStringNullOrEmpty(userName)
        ? reply?.userProfile?.realName
        : userName;
    int replyTs = int.parse(reply?.ts?.split(".")[0]) * 1000;
    String replyTime = Utils.getTimeDeltaStatement(
        DateTime.fromMillisecondsSinceEpoch(replyTs));

    Widget listTile = ListTile(
      key: ValueKey(reply?.ts),
      leading: StreamBuilder(
        stream: todayDrinkBloc?.slackToken,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    reply?.userProfile?.image48,
                    headers: {"Authorization": "Bearer ${snapshot.data}"},
                  ),
                )
              : SizedBox.shrink();
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                userName,
                style: Theme.of(context).primaryTextTheme.subhead,
              ),
              SizedBox(width: 8.0),
              Text(
                replyTime,
                style: Theme.of(context)
                    .primaryTextTheme
                    .body1
                    .copyWith(color: Colors.grey.shade400),
              )
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            reply?.text,
            style: Theme.of(context).primaryTextTheme.body2,
          ),
        ],
      ),
      trailing: _buildTrailingIcon(),
      onTap: isOrdering && isAddedBySprouter
          ? () => _showOrderDrinkPage(message: reply)
          : null,
    );

    return isAddedBySprouter
        ? Dismissible(
            key: ValueKey(reply?.ts),
            background: Container(
              padding: EdgeInsets.only(right: 12.0),
              color: Colors.redAccent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "刪除",
                    style: Theme.of(context).accentTextTheme.body2,
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    FontAwesomeIcons.trash,
                    color: Theme.of(context).accentIconTheme.color,
                  ),
                ],
              ),
            ),
            direction: DismissDirection.endToStart,
            dismissThresholds: {DismissDirection.endToStart: 0.6},
            onDismissed: ((direction) =>
                todayDrinkBloc?.deleteMessage?.add(index)),
            child: listTile,
          )
        : listTile;
  }

  Widget _buildTitle(List<Message> messages) {
    if (messages == null || messages.isEmpty) {
      return Text("Sprouter");
    }
    List<String> parsedTitle = messages[0]?.files[0]?.title?.split(" ");
    String shopName =
        parsedTitle.isEmpty || parsedTitle.length < 2 ? "" : parsedTitle[1];
    return Text(
      shopName,
      style: Theme.of(context).primaryTextTheme.title,
    );
  }

  Widget _buildShopImage(
      BuildContext context, String token, List<Message> messages) {
    if (Utils.isListNullOrEmpty(messages)) {
      return Container(
          alignment: Alignment.center,
          color: Colors.grey,
          child: messages == null
              ? CircularProgressIndicator()
              : EmptyDataView("沒有訂單，沒有菜單\n╮(╯_╰)╭"));
    }
    String imageUrl = messages[0].files[0].thumb800;
    return Container(
      color: Colors.grey.shade300,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPhotoPage(
                  todayDrinkBloc?.drinkShopMessage?.getShopName,
                  imageUrl,
                  token),
            ),
          );
        },
        child: Hero(
          tag: "photo",
          child: CachedNetworkImage(
            placeholder: Center(child: CircularProgressIndicator()),
            imageUrl: imageUrl,
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
  _AddDrinkFabState createState() => _AddDrinkFabState();
}

class _AddDrinkFabState extends State<_AddDrinkFab>
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
        bool isVisible = snapshot.hasData && snapshot.data;
        return Visibility(
          visible: isVisible,
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
      icon: Icon(
        FontAwesomeIcons.slack,
        size: animation?.value ?? 24.0,
      ),
      onPressed: onPressed,
    );
  }
}
