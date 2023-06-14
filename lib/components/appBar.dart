import 'package:flutter/material.dart';

class ShopkeeperAppBar extends PreferredSize {
  final String appBarTitle;


  ShopkeeperAppBar({
    super.key,
    required this.appBarTitle
  }) : super(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
          iconTheme: const IconThemeData(
              color: Colors.black
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            appBarTitle,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'AppleSDGothicNeoBold',
                fontSize: 25
            ),
          ),
          centerTitle: true
      )
  );
}
