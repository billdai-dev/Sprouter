import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';

/// A webview used for the sign in with slack flow.
class SlackLoginWebViewPage extends StatefulWidget {
  SlackLoginWebViewPage();

  @override
  _SlackLoginWebViewPageState createState() =>
      new _SlackLoginWebViewPageState();
}

class _SlackLoginWebViewPageState extends State<SlackLoginWebViewPage> {
  static const String _teamId = "T024ZT2L3";
  static const String _25SproutSlackUrl = "25sprout";

  final StreamController<bool> _rebuildController = StreamController();

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _rebuildController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    final SlackLoginBloc bloc = SlackLoginBlocProvider.of(context);
    final String redirectUrl = bloc?.getSlackRedirectUrl();
    final String clientId = bloc?.getSlackClientId();

    if (!_initialized) {
      flutterWebviewPlugin.onUrlChanged.listen((String changedUrl) async {
        if (!changedUrl.startsWith(redirectUrl)) {
          return;
        }
        Uri uri = Uri().resolve(changedUrl);
        String code = uri.queryParameters["code"];
        String token = await bloc?.getSlackOauthToken(code);

        Navigator.of(context).pop(token != null);
      });
      _initialized = true;
    }
    return StreamBuilder<bool>(
      stream: _rebuildController.stream,
      initialData: false,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (!snapshot.hasData || !snapshot.data) {
          return Scaffold(
            appBar: AppBar(
              title: Text("登入 25Sprout Slack"),
            ),
            body: Builder(
              builder: (context) {
                Clipboard.setData(ClipboardData(text: _25SproutSlackUrl));
                Future.delayed(Duration(milliseconds: 10), () {
                  return Scaffold.of(context)
                      .showSnackBar(SnackBar(
                        content: _buildSnackBar(),
                        duration: Duration(seconds: 2),
                      ))
                      .closed;
                }).then((_) {
                  _rebuildController.sink.add(true);
                });

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        }
        return WebviewScaffold(
          appBar: AppBar(
            title: Text("登入 25Sprout Slack"),
          ),
          url:
              "https://slack.com/oauth/authorize?scope=identity.basic,identity.team,identity.email,identity.avatar&team=$_teamId&client_id=$clientId&redirect_uri=$redirectUrl",
        );
      },
    );
  }

  Widget _buildSnackBar() {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).accentTextTheme.body2,
        children: <TextSpan>[
          TextSpan(text: "已複製"),
          TextSpan(
            text: " $_25SproutSlackUrl ",
            style: Theme.of(context)
                .accentTextTheme
                .body2
                .copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "至剪貼簿，貼上即可前往下一步"),
        ],
      ),
    );
  }
}
