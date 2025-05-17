import 'dart:convert';
import 'dart:io'
    show Platform; // Import necesario solo para plataformas móviles
import 'package:flutter/foundation.dart'; // Import para kIsWeb
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  // Método para obtener la URL base según la plataforma
  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://192.168.1.223:8000/api'; // URL para Web
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api'; // URL para Android (emulador)
    } else {
      return 'http://192.168.1.223:8000/api'; // URL para iOS u otras plataformas
    }
  }

  //get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post(
        '${getBaseUrl()}/login',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'Accept': 'application/json'}, // Encabezado agregado
        ),
      );
      //if request successfully, then return token
      if (response.statusCode == 200 && response.data != '') {
        //store returned token into share preferences for get other data later
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //get user data
  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get(
        '${getBaseUrl()}/user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json', // Encabezado agregado
          },
        ),
      );
      //if request successfully, then return user data
      if (user.statusCode == 200 && user.data != '') {
        return jsonEncode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

  //register new user
  Future<dynamic> registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      var user = await Dio().post(
        '${getBaseUrl()}/register',
        data: {'name': username, 'email': email, 'password': password},
      );
      //if register successfully, return true
      if (user.statusCode == 201 && user.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //store booking details
  Future<dynamic> bookAppointment(
    String date,
    String day,
    String time,
    int doctor,
    String token,
  ) async {
    try {
      var response = await Dio().post(
        '${getBaseUrl()}/book',
        data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctor},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data != 'data') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //retrieve booking details
  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await Dio().get(
        '${getBaseUrl()}/appointments',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data != 'data') {
        return json.encode(response.data);
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
}
