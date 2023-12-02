// register.dart

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopkeeper/components/ShopkeeperTextForm.dart';
import 'package:shopkeeper/components/appBar.dart';
import 'package:shopkeeper/components/button.dart';
import 'package:shopkeeper/components/text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopkeeper/enums/FoodCategory.dart';
import 'package:shopkeeper/models/restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:shopkeeper/repositories/restaurant_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  List<XFile?> pickedMenuList = [];
  List<XFile?> pickedInteriorList = [];
  String name = '';
  String location = '';
  String selectedFoodCategoryText = '';
  FoodCategory? selectedFoodCategory;
  String selectedOpenTime = '';
  String selectedCloseTime = '';
  String reservationTimeUnit = '';
  String blog = '';
  String instagram = '';
  String info = '';
  String phone = '';
  String floor = '';
  String totalSeatCount = '';

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width / 3 - 16.0;
    final imageHeight = imageWidth;

    return Scaffold(
        appBar: ShopkeeperAppBar(
          appBarTitle: '식당 등록',
        ),
        body: Form(
            child: ListView(
              children: [
                ShopkeeperTextForm(
                    label: "식당명", onChanged: (newValue) {
                      print(newValue);
                      setState(() {
                        name = newValue;
                      });
                }, validator: (val) {}),
                const ShopkeeperMainText(
                    text: '식당 카테고리', verticalPadding: 8.0, horizontalPadding: 8.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    selectedFoodCategoryText,
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      fixedSize: const Size(12.0, 12.0)),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['한식', '중식', '일식']
                        .map((category) => ShopkeeperElevatedButton(
                      text: category,
                      buttonColor: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          selectedFoodCategoryText = category;
                          if(category.contains("한식")) {
                            selectedFoodCategory = FoodCategory.KOREAN_FOOD;
                          } else if(category.contains("중식")) {
                            selectedFoodCategory = FoodCategory.CHINESE_FOOD;
                          } else if(category.contains("일식")) {
                            selectedFoodCategory = FoodCategory.JAPANESE_FOOD;
                          }

                        });
                      },
                      buttonWidth: 16.0,
                      buttonHeight: 16.0,
                    ))
                        .toList()),
                ShopkeeperMainText(text: "식당 메뉴 사진 (최대 3개)", verticalPadding: 8.0, horizontalPadding: 8.0),
                Row(
                  children: [
                    if(pickedMenuList.isNotEmpty)
                      _showImage(imageWidth, imageHeight, "menu"),
                    if(pickedMenuList.length != 3)
                      _noneImage(imageWidth, "menu"),
                  ],
                ),

                ShopkeeperMainText(text: "식당 내부 사진 (최대 3개)", verticalPadding: 8.0, horizontalPadding: 8.0),
                Row(
                  children: [
                    if(pickedInteriorList.isNotEmpty)
                      _showImage(imageWidth, imageHeight, "interior"),
                    if(pickedInteriorList.length != 3)
                      _noneImage(imageWidth, "interior"),
                  ],
                ),
                ShopkeeperTextForm(
                    label: "위치 (ex.경기도 용인시 수지구 단국대학교 ICT관 1층) ",
                    onChanged: (newValue) {
                      location = newValue;
                    },
                    validator: (val) {}),
                const ShopkeeperMainText(
                    text: '오픈 시간', verticalPadding: 8.0, horizontalPadding: 8.0),
                ShopkeeperSubText(
                    text: selectedOpenTime,
                    verticalPadding: 3.0,
                    horizontalPadding: 8.0),
                ShopkeeperElevatedButton(
                    text: '오픈 시간 선택',
                    buttonColor: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    buttonWidth: 16.0,
                    buttonHeight: 16.0,
                    onPressed: () {
                      showTimePickerPop("open");
                    }),
                const ShopkeeperMainText(
                    text: '마감 시간', verticalPadding: 8.0, horizontalPadding: 8.0),
                ShopkeeperSubText(
                    text: selectedCloseTime,
                    verticalPadding: 3.0,
                    horizontalPadding: 8.0),
                ShopkeeperElevatedButton(
                    text: '마감 시간 선택',
                    buttonColor: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    buttonWidth: 16.0,
                    buttonHeight: 16.0,
                    onPressed: () {
                      showTimePickerPop("close");
                    }),
                ShopkeeperTextForm(
                    label: "예약 시간 단위 (0 ~ 60(분)으로 입력)",
                    onChanged: (newValue) {
                      reservationTimeUnit = newValue;
                    },
                    validator: (val) {}),
                ShopkeeperTextForm(
                    label: "블로그 주소", onChanged: (newValue) {
                      blog = newValue;
                }, validator: (val) {}),
                ShopkeeperTextForm(
                    label: "인스타그램 아이디",
                    onChanged: (newValue) {
                      instagram = newValue;
                    },
                    validator: (val) {}),
                ShopkeeperTextForm(
                    label: "가게 소개(짧게)",
                    onChanged: (newValue) {
                      info = newValue;
                    },
                    validator: (val) {}),
                ShopkeeperTextForm(
                    label: "가게 전화번호 (ex. 010-1234-5678)",
                    onChanged: (newValue) {
                      phone = newValue;
                    },
                    validator: (val) {}),
                ShopkeeperMainText(
                    text: '좌석 등록', verticalPadding: 8.0, horizontalPadding: 8.0),
                ShopkeeperTextForm(
                    label: "가게 층", onChanged: (newValue) {
                      floor = newValue;
                }, validator: (val) {}),
                ShopkeeperTextForm(
                    label: "전체 좌석 수", onChanged: (newValue) {
                      totalSeatCount = newValue;
                }, validator: (val) {}),
                ShopkeeperElevatedButton(
                    text: '식당 등록 완료',
                    buttonColor: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      // 2023-06-15T11:30:00.442
                      // 2020-01-02T07:12
                      var now = DateTime.now();
                      var year = now.year.toString();
                      var month = now.month.toString();
                      if(month.length == 1) month = '0$month';
                      var day = now.day.toString();
                      var sec = now.second.toString();
                      var openHour = selectedOpenTime.split(":")[0];
                      var openMin = selectedOpenTime.split(":")[1];
                      if(openHour.length == 1) openHour = '0$openHour';
                      if(openMin.length == 1) openMin = '0$openMin';

                      var closeHour = selectedCloseTime.split(":")[0];
                      var closeMin = selectedCloseTime.split(":")[1];
                      if(closeHour.length == 1) closeHour = '0$closeHour';
                      if(closeMin.length == 1) closeMin = '0$closeMin';

                      var open = '$openHour:$openMin';
                      var close = '$closeHour:$closeMin';

                      var openTime = "$year-$month-${day}T$open";
                      var closeTime = "$year-$month-${day}T$close";

                      var seatRequest = SeatRequest(floor: int.parse(floor), total: int.parse(totalSeatCount));
                      var restaurantRequest = RestaurantRequest(
                        name: name,
                        blog: blog,
                        category: selectedFoodCategory!,
                        greeting: info,
                        instagram: instagram,
                        location: location,
                        reservationTimeUnit: int.parse(reservationTimeUnit),
                        seatRequest: seatRequest,
                        startTime: DateTime.parse(openTime),
                        endTime: DateTime.parse(closeTime),
                        telephoneNumber: phone
                      );
                      print(restaurantRequest);

                      registerRestaurant(pickedMenuList, pickedInteriorList, restaurantRequest, context);

                    })
              ],
            )));

  }

  String showTimePickerPop(String type) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((timeOfDay) {
      print(timeOfDay);
      Fluttertoast.showToast(
        msg: timeOfDay.toString(),
        toastLength: Toast.LENGTH_LONG,
        //gravity: ToastGravity.CENTER,  //위치(default 는 아래)
      );
      if(type == "open"){
        setState(() {
          selectedOpenTime = '${timeOfDay?.hour}:${timeOfDay?.minute}';
        });
      } else if(type == "close"){
        setState(() {
          selectedCloseTime = '${timeOfDay?.hour}:${timeOfDay?.minute}';
        });
      }

      return '${timeOfDay?.hour}:${timeOfDay?.minute}';
    });
    return '';
  }

  _noneImage(double imageWidth, String type) {
    return Container(
      color: Colors.white,
      height: imageWidth,
      width: imageWidth,
      // constraints: BoxConstraints(
      //     minHeight: MediaQuery.of(context).size.width / 4,
      //     minWidth: imageWidth
      // ),
      child: GestureDetector(
        onTap: () {
          _showBottomSheet(type);
        },
        child: Row(
          children: [
            Icon(Icons.add, size: imageWidth),
          ],
        ),
      ),
    );
  }

  _showImage(double imageWidth, double imageHeight, String type){
    List<XFile?> imageList = [];

    if(type == "menu"){
      imageList = pickedMenuList;
    } else if(type == "interior"){
      imageList = pickedInteriorList;
    }

    return Row(
        children: List.generate(imageList.length, (index){
          return Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 0.5, color: Color(0xff666666)),
              image: DecorationImage(
                  image: FileImage(File(imageList[index]!.path)),
                  fit: BoxFit.fitHeight),
            ),
          );
        })
    );
  }

  _getPhotoLibraryImage(String type) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        if(type == "menu"){
          pickedMenuList.add(pickedImage);
        } else if(type == "interior"){
          pickedInteriorList.add(pickedImage);
        }
        print(pickedImage.name);

      });
    } else {
      if (kDebugMode) {
        print('이미지 선택X');
      }
    }
  }

  _showBottomSheet(String type) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ShopkeeperElevatedButton(text: '갤러리', buttonColor: Colors.blue, textColor: Colors.white, onPressed: (){
              _getPhotoLibraryImage(type);
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}


Future<void> registerRestaurant(List<XFile?> menus, List<XFile?> interiors, RestaurantRequest restaurantRequest, BuildContext context ) async{
  var dio = Dio();

  final List<MultipartFile> menusImage = menus
      .map((img) => MultipartFile.fromFileSync(img!.path,))
      .toList();

  final List<MultipartFile> interiorsImage = interiors
      .map((img) => MultipartFile.fromFileSync(img!.path,))
      .toList();

  final Map<String, dynamic> jsonData = restaurantRequest.toJson();
  final jsonString = json.encode(jsonData);
  print(jsonString);

  FormData formData;
  dio.options.contentType = 'multipart/form-data';

  formData = FormData.fromMap({
    "menus": menusImage,
    "interiors": interiorsImage,
    "data": MultipartFile.fromString(jsonString, contentType: MediaType('application', 'json') ),
  });
  
  dio.post('http://15.165.54.240:8080/restaurant/register', data: formData)
    .then((value) => {
      _showModal(context),
  });
}

_showModal(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
    return AlertDialog(
      title: Text('식당 등록'),
      content: Text('식당 등록에 성공하셨습니다.'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
  );
}

