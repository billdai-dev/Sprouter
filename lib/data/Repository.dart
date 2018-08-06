import 'dart:async';

import 'package:flutter_slack_oauth/oauth/model/user_identity.dart';
import 'package:rxdart/rxdart.dart';

abstract class Repository{
  Observable<String> getSlackUserData({String token});
}