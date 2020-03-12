import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/dashboard_page.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Side menu',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}