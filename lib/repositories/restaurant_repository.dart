// repositories.restaurant_repository.dart

import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/restaurant_model.dart';

class RestaurantRepository {
  final Dio _dio = Dio(
      BaseOptions(
        baseUrl: 'http://15.165.54.240:8080',
      )
  );

  restaurantRegister(RestaurantRegisterRequest request) async {
    try {
      var formData = FormData();
      formData.files.addAll(
          request.menus.map((file) => MapEntry('menus', file))
      );
      formData.files.addAll(
          request.interiors.map((file) => MapEntry('interiors', file))
      );
      formData.fields.add(MapEntry("data", json.encode(request.data.toJson())));

      final _response = await _dio.post("/restaurant/register", data: formData);
    } catch (error) {
    }
  }
}