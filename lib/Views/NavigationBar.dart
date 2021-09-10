import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_language/Views/ListViewPage.dart';
import 'package:safe_language/Views/ShareCode.dart';
import 'HomePage.dart';


class NavigationBar extends StatefulWidget {


  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final _screens =[new HomePage(), new ListViewPage(), new ShareCode()];
  var _index = 0 ;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text("Bem-vindos"),
        ),
      ),
      body: _screens[_index],
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items:[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
              backgroundColor: new Color(0xFF5575B4)
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.list),
              title: new Text("Alfabeto"),
              backgroundColor: new Color(0xFF5A64AE),

          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.share),
              title: new Text("Compartilhar"),
              backgroundColor: new Color(0xFF6049A5)

          )
        ],
        onTap: (index) => {
          this.setState(() {
            _index = index;
          })
        },

      ),
    );
  }
}

