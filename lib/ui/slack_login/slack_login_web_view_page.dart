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
  static const String _teamName = "25sprout";

  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    final SlackLoginBloc bloc = SlackLoginBlocProvider.of(context);
    final String redirectUrl = bloc?.getSlackRedirectUrl();
    final String clientId = bloc?.getSlackClientId();

    /*Widget webView = WebviewScaffold(
      appBar: AppBar(
        title: Text("登入 25Sprout Slack"),
      ),
      url:
          "https://slack.com/oauth/authorize?scope=identity.basic,identity.team,identity.email&team=$_teamId&client_id=$clientId&redirect_uri=$redirectUrl",
    );*/

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
    }
    return FutureBuilder(
      future: _initialized ? Future.value(true) : showCopyTeamNameHint(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return WebviewScaffold(
          appBar: AppBar(
            title: Text("登入 25Sprout Slack"),
          ),
          url:
              "https://slack.com/oauth/authorize?scope=identity.basic,identity.team,identity.email&team=$_teamId&client_id=$clientId&redirect_uri=$redirectUrl",
        );
      },
    );
  }

  Future<bool> showCopyTeamNameHint() {
    return Future.delayed(
      Duration(
        milliseconds: 0,
      ),
    ).then((_) async {
      await showModalBottomSheet(
        context: context,
        builder: (context) {
          Clipboard.setData(new ClipboardData(text: _teamName));

          return Container(
            color: Colors.grey.shade800,
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).accentTextTheme.body2,
                children: <TextSpan>[
                  TextSpan(text: "已複製"),
                  TextSpan(
                    text: " $_teamName ",
                    style: Theme.of(context)
                        .accentTextTheme
                        .body2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "至剪貼簿，任意輕觸以繼續"),
                ],
              ),
            ),
          );
        },
      );
      _initialized = true;
      return true;
    });
  }
}
