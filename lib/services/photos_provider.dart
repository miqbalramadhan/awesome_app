import 'package:awesome_app/services/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PhotosProvider extends ChangeNotifier {
  static Future<dynamic> getAll(
      {required query, required int page, required int load}) async {
    String url = "search?page=$page&per_page=$load&query=$query";
    try {
      Response response = await getDio().get(
        url,
      );
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class NetworkException implements Exception {}
