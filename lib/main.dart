import 'package:flutter/material.dart';
import 'package:sprouter/ui/login/slack_auth_bloc_provider.dart';
import 'package:sprouter/ui/tab_navigator.dart';
import 'package:sprouter/ui/today_drink_bloc_provider.dart';

void main() {
  runApp(new MaterialApp(
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
    return SlackAuthBlocProvider(
      child: TodayDrinkBlocProvider(
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
