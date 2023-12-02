// models.restaurant_model.dart

import 'dart:core';
import 'package:dio/dio.dart';
import '../enums/FoodCategory.dart';

class RestaurantRegisterRequest {
  List<MultipartFile> menus;
  List<MultipartFile> interiors;
  RestaurantRequest data;

  RestaurantRegisterRequest({
    required this.menus,
    required this.interiors,
    required this.data,
  });
}

class RestaurantRequest {
  String blog;
  FoodCategory category;
  DateTime endTime;
  String greeting;
  String instagram;
  String location;
  String name;
  int reservationTimeUnit;
  SeatRequest seatRequest;
  DateTime startTime;
  String telephoneNumber;

  RestaurantRequest({
    required this.blog,
    required this.category,
    required this.endTime,
    required this.greeting,
    required this.instagram,
    required this.location,
    required this.name,
    required this.reservationTimeUnit,
    required this.seatRequest,
    required this.startTime,
    required this.telephoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'blog': blog,
    'category': category.toString().split('.').last,
    'endTime': endTime.toIso8601String(),
    'greeting': greeting,
    'instagram': instagram,
    'location': location,
    'name': name,
    'reservationTimeUnit': reservationTimeUnit,
    'seatRequest': seatRequest.toJson(),
    'startTime': startTime.toIso8601String(),
    'telephoneNumber': telephoneNumber,
  };
}

class SeatRequest {
  int floor;
  int total;

  SeatRequest({
    required this.floor,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
    'floor': floor,
    'total': total,
  };
}