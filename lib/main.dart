import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Exploring Post Api in flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:const HomePage(),
    );
  }
}