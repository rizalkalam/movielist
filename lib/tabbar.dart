import 'package:api_movielist/listview.dart';
import 'package:api_movielist/listview2.dart';
import 'package:api_movielist/listview3.dart';
import 'package:flutter/material.dart';

class TabbarExample extends StatefulWidget {
  const TabbarExample({Key? key}) : super(key: key);

  @override
  State<TabbarExample> createState() => _TabbarExampleState();
}

class _TabbarExampleState extends State<TabbarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ListAllFootball(),
    listview2(),
    listview3()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller = TabController(length: list.length, vsync: this);

  //   _controller.addListener(() {
  //     setState(() {
  //       _selectedIndex = _controller.index;
  //     });
  //     print("Selected Index: " + _controller.index.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          // bottom: TabBar(
          //   onTap: (value) {},
          //   controller: _controller,
          //   tabs: list,
          // ),
          centerTitle: true,
          title: Text(
            'MovieList',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'TV',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_sharp),
              label: 'Trending',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          backgroundColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
