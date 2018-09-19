import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprouter/ui/slack_login/slack_login_bloc_provider.dart';
import 'package:sprouter/ui/tab_navigator.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.orangeAccent,
      accentIconTheme: IconThemeData(color: Colors.white),
    ),
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
  };

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SlackLoginBlocProvider(
      child: WillPopScope(
        onWillPop: () async {
          return !await navigatorKeys[_currentPage].currentState.maybePop();
        },
        child: Scaffold(
          appBar: _currentPage == 0
              ? null
              : AppBar(
                  title: Text("Sprouter"),
                ),
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
          ]),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentPage,
              onTap: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.local_drink),
                  title: Text('Drink'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.access_time,
                    color: Colors.orange,
                  ),
                  title: Text('Jibbler'),
                )
              ]),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int pageIndex) {
    return Offstage(
      offstage: _currentPage != pageIndex,
      child: TabNavigator(
        pageIndex,
        navigatorKey: navigatorKeys[pageIndex],
      ),
    );
  }
}
