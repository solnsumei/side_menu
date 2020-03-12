import 'package:flutter/material.dart';

final Color darkModeBgColor = Color(0xFF4A4A58);
final Color darkModeTextColor = Colors.white;

final Color lightModeBgColor = Colors.grey[100];
final Color lightModeTextColor = Colors.black54;

final Color staticTextColor = Colors.white;


class DashboardPage extends StatefulWidget {
  createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _slideAnimation;
  Animation<double> _menuScaleAnimation;
  bool isDarkMode =  true;

  Color backgroundColor = darkModeBgColor;
  Color textColor = darkModeTextColor;

  initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                menuText('Dashboard'),
                spacingVertical(),
                menuText('Messages'),
                spacingVertical(),
                menuText('Utility Bills'),
                spacingVertical(),
                menuText('Funds Transfer'),
                spacingVertical(),
                menuText('Branches'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget spacingVertical({ double height }) {
    return SizedBox(height: height ?? 10.0);
  }

  Widget menuText(String title) {
    return Text(title,
      style: TextStyle(color: textColor, fontSize: 22.0),
    );
  }

  Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : - 0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.circular(isCollapsed ? 0.0 : 40.0),
          elevation: 8,
          color: backgroundColor,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu, color: textColor),
                        onPressed: () {
                          setState(() {
                            if (isCollapsed) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text('My Cards',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isDarkMode = !isDarkMode;

                            textColor = isDarkMode ? darkModeTextColor : lightModeTextColor;
                            backgroundColor = isDarkMode ? darkModeBgColor : lightModeBgColor;
                          });
                        },
                        icon: Icon(Icons.settings, color: textColor),
                      ),
                    ],
                  ),
                  Container(
                    height: 180,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.9),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        pageViewContainer(
                          color: Colors.blueAccent,
                        ),
                        pageViewContainer(
                          color: Colors.blueAccent,
                        ),
                        pageViewContainer(
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                  spacingVertical(height: 20.0),
                  Text('Transactions',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.0,
                    ),
                  ),
                  spacingVertical(height: 5.0),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Macbook', style: TextStyle(color: textColor)),
                          subtitle: Text('Apple', style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black38)),
                          trailing: Text('- \$ 2900',  style: TextStyle(color: textColor, fontWeight: FontWeight.bold )),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.laptop_mac, color: textColor, size: 16.0,),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      }, itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pageViewContainer({ Color color }) {
    return Container(
      padding: EdgeInsets.all(isCollapsed ? 22.0 : 16.0),
      decoration: BoxDecoration(
        color: color ?? Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        primary: false,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Current Balance',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10.0,
                ),
              ),
              Text('BankX',
                style: TextStyle(
                  color: staticTextColor,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          spacingVertical(height: 3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('\$12.344.32',
                style: TextStyle(
                  color: staticTextColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          spacingVertical(height: 35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text('**** **** **** 1505',
                  style: TextStyle(
                    color: staticTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: isCollapsed ? 4.0 : 2.0,
                    wordSpacing: 3.0,
                  ),
                ),
              ),
            ],
          ),
          spacingVertical(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Card Holder',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 9.0,
                      ),
                    ),
                    Text('Salmon Dung',
                      style: TextStyle(
                        color: staticTextColor,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Expires',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 9.0,
                      ),
                    ),
                    Text('05/20',
                      style: TextStyle(
                        color: staticTextColor,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0, top: 4.0),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: staticTextColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12.0, top: 4.0),
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: staticTextColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}