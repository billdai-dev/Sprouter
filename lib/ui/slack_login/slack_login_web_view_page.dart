import 'package:flutter/material.dart';
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
  static const String _TEAM_ID = "T024ZT2L3";

  bool setupUrlChangedListener = false;

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    final SlackLoginBloc bloc = SlackLoginBlocProvider.of(context);
    final String redirectUrl = bloc?.getSlackRedirectUrl();
    final String clientId = bloc?.getSlackClientId();

    if (!setupUrlChangedListener) {
      flutterWebviewPlugin.onUrlChanged.listen((String changedUrl) async {
        if (!changedUrl.startsWith(redirectUrl)) {
          return;
        }
        Uri uri = Uri().resolve(changedUrl);
        String code = uri.queryParameters["code"];
        String token = await bloc?.getSlackOauthToken(code);

        Navigator.of(context).pop(token != null);
      });
      setupUrlChangedListener = true;
    }

    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Log in with Slack"),
      ),
      url:
          "https://slack.com/oauth/authorize?scope=identity.basic,identity.team,identity.email&team=$_TEAM_ID&client_id=$clientId&redirect_uri=$redirectUrl",
    );
  }
}
