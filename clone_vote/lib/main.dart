import 'package:clone_vote/screnns/home_screen.dart';
import 'package:clone_vote/screnns/launch_screen.dart';
import 'package:clone_vote/screnns/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:clone_vote/constants.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => Scaffold(
              body: LaunchScreen(),
            ),
        '/home': (context) => Scaffold(
              appBar: AppBar(
                title: Text(kAppName),
              ),
              body: HomeScreen(),
            ),
        '/result': (context) => Scaffold(
              appBar: AppBar(
                title: Text('Result'),
                leading: IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {
                    print('Result Screen');
                  },
                ),
              ),
              body: ResultScreen(),
            )
      },
    );
  }
}
