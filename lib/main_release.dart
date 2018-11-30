import 'package:flutter/widgets.dart';
import 'package:sprouter/env_config.dart';
import 'package:sprouter/ui/main_app.dart';

void main() {
  EnvConfig.appFlavor = Flavor.RELEASE;
  runApp(MainApp());
}
