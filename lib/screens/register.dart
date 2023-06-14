import 'package:flutter/material.dart';
import 'package:shopkeeper/components/ShopkeeperTextForm.dart';
import 'package:shopkeeper/components/appBar.dart';
import 'package:shopkeeper/components/button.dart';
import 'package:shopkeeper/components/text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String selectedFoodCategory = '';
  String selectedOpenTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopkeeperAppBar(appBarTitle: '식당 등록',),
      body: Form(child: ListView(
        children: [
          ShopkeeperTextForm(label: "식당명", onSaved: (newValue){}, validator: (val){}),
          const ShopkeeperMainText(text: '식당 카테고리', verticalPadding: 8.0, horizontalPadding: 8.0),
          ElevatedButton(
            onPressed: (){},
            child: Text(selectedFoodCategory, style: TextStyle(color: Colors.black),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow, fixedSize: const Size(12.0, 12.0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShopkeeperElevatedButton(text: '한식', buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){
                setState(() {
                  selectedFoodCategory = '한식';
                });
              }, buttonWidth: 16.0, buttonHeight: 16.0,),
              ShopkeeperElevatedButton(text: '중식', buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){
                setState(() {
                  selectedFoodCategory = '중식';
                });
              }, buttonWidth: 16.0, buttonHeight: 16.0,),
              ShopkeeperElevatedButton(text: '일식', buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){
                setState(() {
                  selectedFoodCategory = '일식';
                });
              }, buttonWidth: 16.0, buttonHeight: 16.0,),
            ],
          ),
          ShopkeeperTextForm(label: "위치 (ex.경기도 용인시 수지구 단국대학교 ICT관 1층) ", onSaved: (newValue){}, validator: (val){}),

          const ShopkeeperMainText(text: '오픈 시간', verticalPadding: 8.0, horizontalPadding: 8.0),
          ShopkeeperSubText(text: selectedOpenTime, verticalPadding: 3.0, horizontalPadding: 8.0),
          ShopkeeperElevatedButton(text: '오픈 시간 선택', buttonColor: Colors.lightBlueAccent, textColor: Colors.white, buttonWidth: 16.0, buttonHeight: 16.0, onPressed: (){
            showTimePickerPop();
          }),

          const ShopkeeperMainText(text: '마감 시간', verticalPadding: 8.0, horizontalPadding: 8.0),
          ShopkeeperSubText(text: selectedOpenTime, verticalPadding: 3.0, horizontalPadding: 8.0),
          ShopkeeperElevatedButton(text: '마감 시간 선택', buttonColor: Colors.lightBlueAccent, textColor: Colors.white, buttonWidth: 16.0, buttonHeight: 16.0, onPressed: (){
            showTimePickerPop();
          }),

          ShopkeeperTextForm(label: "예약 시간 단위 (0 ~ 60(분)으로 입력)", onSaved: (newValue){}, validator: (val){}),
          ShopkeeperTextForm(label: "블로그 주소", onSaved: (newValue){}, validator: (val){}),
          ShopkeeperTextForm(label: "인스타그램 아이디", onSaved: (newValue){}, validator: (val){}),
          ShopkeeperTextForm(label: "가게 소개(짧게)", onSaved: (newValue){}, validator: (val){}),
          ShopkeeperTextForm(label: "가게 전화번호 (ex. 010-1234-5678)", onSaved: (newValue){}, validator: (val){}),

          ShopkeeperMainText(text: '좌석 등록', verticalPadding: 8.0, horizontalPadding: 8.0),
          ShopkeeperTextForm(label: "가게 층", onSaved: (newValue){}, validator: (val){}),
          ShopkeeperTextForm(label: "전체 좌석 수", onSaved: (newValue){}, validator: (val){}),

          ShopkeeperElevatedButton(text: '식당 등록 완료', buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){})
        ],
      ))
    );
  }

  void showTimePickerPop() {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((timeOfDay) {
      Fluttertoast.showToast(
        msg: timeOfDay.toString(),
        toastLength: Toast.LENGTH_LONG,
        //gravity: ToastGravity.CENTER,  //위치(default 는 아래)
      );

      setState(() {
        selectedOpenTime = '${timeOfDay?.hour}:${timeOfDay?.minute}';
      });
    });
  }

}


