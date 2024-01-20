import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:test1/Assistant.dart';
import 'package:test1/Camera.dart';
import 'package:test1/main.dart';
import 'home.dart';

Color themeColor = Color(0xFFAECC76);

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: themeColor,
        backgroundColor: Colors.transparent,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(
            Icons.home_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.medical_information, size: 30, color: Colors.white),
          Icon(Icons.camera, size: 30, color: Colors.white),
          Icon(Icons.shopping_basket, size: 30, color: Colors.white),
        ],
        buttonBackgroundColor: themeColor,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _buildPage(_page),
    );
  }

  Widget _buildPage(int page) {
    switch (page) {
      case 0:
        return const Home();
      case 1:
        return Assistant();
      case 2:
        return CameraPage();
      case 3:
        return InfoPage();
      default:
        return Container();
    }
  }

  CurvedNavigationBarState? getNavBarState() {
    return _bottomNavigationKey.currentState;
  }
}

class InfoPage extends StatelessWidget {
  final List<Map<String, dynamic>> itemList = [
    {
      'imageURL': 'https://asian-veggies.com/cdn/shop/products/musangking.png',
      'title': 'Durian',
      'subtitle': '',
    },
    {
      'imageURL': 'https://havva.my/wp-content/uploads/2021/06/S2-big-small.jpg',
      'title': 'Organic Pesticides',
      'subtitle': '',
    },
    {
      'imageURL':
          'https://i.ebayimg.com/images/g/6mkAAOSwUd1kdG5P/s-l1200.webp',
      'title': 'Farm Tools',
      'subtitle': '',
    },
    {
      'imageURL': 'https://i0.wp.com/2.bp.blogspot.com/-wzyGHPiKD-I/UFnkw7u7QGI/AAAAAAAAERo/xyqrtjPZ5M8/s1600/P7241390.JPG',
      'title': 'Seeds',
      'subtitle': '',
    },
 
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Flutter Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row with icons and text
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.history, size: 30, color: Colors.green),
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.diamond, size: 30, color: Colors.green),
                ],
              ),
            ),
            SizedBox(height: 50.0), // Spacer

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(20.0), // Add border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ), // Add spacing between icon and text
                      Text("Search Durian"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0), // Spacer

            // Vertical ListView with two elements in each row
            Expanded(
              child: ListView.builder(
                itemCount: (itemList.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final int firstIndex = index * 2;
                  final int secondIndex = index * 2 + 1;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (firstIndex < itemList.length)
                        _buildItem(context, itemList[firstIndex]),
                      SizedBox(width: 16.0),
                      if (secondIndex < itemList.length)
                        _buildItem(context, itemList[secondIndex]),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> item) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to a fake page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FakePage(item: item),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16.0, left: 10, top: 10, right: 10),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    item['imageURL'],
                    width: double.infinity,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                item['title'],
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                item['subtitle'],
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FakePage extends StatelessWidget {
  final Map<String, dynamic> item;

  FakePage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Page'),
      ),
      body: Center(
        child: Text('Clicked on ${item['title']}'),
      ),
    );
  }
}
