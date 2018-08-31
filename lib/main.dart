import 'package:flutter/material.dart';
import 'package:sprouter/ui/login/slack_auth_bloc_provider.dart';
import 'package:sprouter/ui/login/slack_login_page.dart';
import 'package:sprouter/ui/today_drink_bloc_provider.dart';
import 'package:sprouter/ui/today_drink_page.dart';

void main() {
  runApp(new MaterialApp(
    home: MainPage(),
    routes: {
      "/conversation_list_page": (context) => TodayDrinkBlocProvider(
            child: TodayDrinkPage(),
          )
    },
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomNavigationBar _bottomNavigationBar;
  final Key _todayDrinkPage_key = PageStorageKey("TodayDrinkPage");
  final Key _jibblerPage_key = PageStorageKey("JibblerPage");

  Widget _todayDrinkPage;
  Widget _jibblerPage;
  List<Widget> _pages;
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _pageIndex == 0
          ? null
          : AppBar(
              title: Text("Sprouter"),
            ),
      body: _pages[_pageIndex],
      bottomNavigationBar: _bottomNavigationBar,
    );
  }

  @override
  void initState() {
    _todayDrinkPage = TodayDrinkPage(
      key: _todayDrinkPage_key,
    );
    /*_todayDrinkPage = TodayDrinkBlocProvider(
      key: _todayDrinkPage_key,
      child: TodayDrinkPage(key: _todayDrinkPage_key),
    );*/
    _jibblerPage = SlackAuthBlocProvider(
      child: SlackLoginPage(),
    );
    _pages = [_todayDrinkPage, _jibblerPage];

    _bottomNavigationBar = BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
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
        ]);
    super.initState();
  }
}
