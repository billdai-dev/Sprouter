import 'package:flutter/material.dart';
import 'package:sprouter/ui/login/slack_auth_bloc_provider.dart';
import 'package:sprouter/ui/login/slack_login_page.dart';
import 'package:sprouter/ui/today_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink_page.dart';

void main() {
  int _pageIndex = 0;
  runApp(new MaterialApp(
    home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Sprouter"),
        ),
        body: SlackAuthBlocProvider(child: SlackLoginPage()),
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: (int index) {
              _pageIndex = index;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              new BottomNavigationBarItem(
                  icon: const Icon(Icons.local_drink),
                  title: new Text('Drink'),
                  backgroundColor: Colors.lightBlue),
              new BottomNavigationBarItem(
                  icon: const Icon(Icons.access_time),
                  title: new Text('Second'),
                  backgroundColor: Colors.red)
            ])),
    routes: {
      "/conversation_list_page": (context) => TodayDrinkBlocProvider(
            child: TodayDrinkPage(),
          )
    },
  ));
}
