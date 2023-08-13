import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'token_service.dart';

class HttpService {
  static Future<Response> postWithFormData(String url, Map<String, dynamic> formData) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': "Basic ZWdvdi11c2VyLWNsaWVudDo=",
        },
        body: formData,
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return Response(body: body, statusCode: response.statusCode);
      } else {
        return Response(body: null, statusCode: response.statusCode);
      }
    } on HttpException catch (e) {
      log(e.toString());
      return const Response(body: null, statusCode: 500);
    }
  }

  static Future<Response> postRequestWithoutToken(String url, Map<String, dynamic> jsonMap) async {
    String body = json.encode(jsonMap);

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return Response(body: body, statusCode: response.statusCode);
      } else {
        return Response(body: null, statusCode: response.statusCode);
      }
    } on HttpException catch (e) {
      log(e.toString());
      return const Response(body: null, statusCode: 500);
    }
  }

  static Future<Response> getRequest(String route) async {
    try {
      var response = await http.get(Uri.parse(route), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await SecureStorageService.read("token") ?? 'null'}'
      });
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return Response(body: body, statusCode: response.statusCode);
      } else {
        return Response(body: null, statusCode: response.statusCode);
      }
    } on HttpException catch (e) {
      log(e.toString());
      return const Response(body: null, statusCode: 666);
    }
  }

  static Future<Response> getRequestWithoutToken(String route) async {
    String url = uri + route;
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return Response(body: body, statusCode: response.statusCode);
      } else {
        return Response(body: null, statusCode: response.statusCode);
      }
    } on HttpException catch (e) {
      log(e.toString());
      return const Response(body: null, statusCode: 666);
    }
  }

  static Future<Response> deleteRequest(String route, Map<String, dynamic>? jsonMap) async {
    String url = uri + route;
    String body = json.encode(jsonMap);
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await SecureStorageService.read("token") ?? 'null'}'
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return Response(body: body, statusCode: response.statusCode);
      } else {
        return Response(body: null, statusCode: response.statusCode);
      }
    } on HttpException catch (e) {
      log(e.toString());
      return const Response(body: null, statusCode: 666);
    }
  }

  static Future<Response> putRequest(String route, Map<String, dynamic> jsonMap) async {
    String url = uri + route;
    String body = json.encode(jsonMap);

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await SecureStorageService.read("token") ?? 'null'}'
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        return Response(body: body, statusCode: response.statusCode);
      } else {
        return Response(body: null, statusCode: response.statusCode);
      }
    } on HttpException catch (e) {
      log(e.toString());
      return const Response(body: null, statusCode: 666);
    }
  }
}
