import 'package:flutter/material.dart';
import '../components/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShopkeeperElevatedButton(text: "로그인", buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){}),
              ShopkeeperElevatedButton(text: "회원가입", buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){})
            ],
          )
        ],
      ),
    );
  }
}
