import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofigure/screens/main_screen.dart';
import 'package:gofigure/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.green,
//      ),
//      home: MainScreen(),
//    );
//  }
//}

class MyApp extends StatefulWidget {
  static restartApp(BuildContext context) {
    final _MyAppState state =
        context.ancestorStateOfType(const TypeMatcher<_MyAppState>());
    state.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String theme;

  //Check for active theme after app starts
  checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefTheme =
        prefs.getString("theme") == null ? "light" : prefs.getString("theme");
    print("THEME: $prefTheme");
    setState(() {
      theme = prefTheme;
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          prefTheme == "dark" ? Constants.darkPrimary : Constants.lightPrimary,
    ));
  }

  @override
  void initState() {
    super.initState();
    checkTheme();
  }

  //This function assigns a new key to the material app making it lose it's state
  Key key = UniqueKey();
  restartApp() {
    setState(() {
      key = UniqueKey();
    });
    checkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: theme == "dark" ? Constants.darkTheme : Constants.lightTheme,
      home: MainScreen(),
    );
  }
}
