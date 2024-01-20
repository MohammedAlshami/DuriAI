import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Color themeColor = Color(0xFFAECC76);
Color bgColor = Color(0xFFF4F4F4);

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Welcome(),
                // NavIcons(),
                SizedBox(
                  height: 20,
                ),
                Info(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Products extends StatelessWidget {
  const Products({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Text 1"),
    );
  }
}

class NavIcons extends StatelessWidget {
  const NavIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Icon(
                  Icons.flip,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(width: 40.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Icon(
                  Icons.medical_information,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(width: 40.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Icon(
                  Icons.storefront,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(width: 40.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      decoration: BoxDecoration(
        border: Border.all(
          color: bgColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20.0), // Add border radius
      ),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/icons/DurianIcon.png', // Replace with the path to your PNG asset
              width: 120, // Set the width
              height: 120, // Set the height
            ),
            SizedBox(height: 40),
            Text(
              "Idenitfy Your First Durian",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.add_circle, size: 50, color: themeColor),
          ],
        ),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: themeColor,
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
                            color: themeColor,
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
              ),
              SizedBox(width: 20),
              Icon(
                Icons.notifications,
                size: 30,
                color: Colors.black,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Row(
                  children: [
                    Icon(Icons.email, size: 30, color: Colors.white),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text('''Tap here to Check Inbox.''',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    Icon(Icons.arrow_right, size: 30, color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
