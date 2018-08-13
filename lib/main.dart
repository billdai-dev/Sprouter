import 'package:flutter/material.dart';
import 'package:sprouter/ui/login/SlackAuthBlocProvider.dart';
import 'package:sprouter/ui/login/SlackLoginPage.dart';

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
                  icon: const Icon(Icons.star),
                  title: new Text('First'),
                  backgroundColor: Colors.lightBlue
              ),

              new BottomNavigationBarItem(
                  icon: const Icon(Icons.star),
                  title: new Text('Second'),
                  backgroundColor: Colors.red
              )
            ]

        )
    ),
  ));
}
