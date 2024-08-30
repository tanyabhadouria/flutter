import 'dart:io';

import 'package:recipe_app/services/http_service.dart';

import '../models/user.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  //This creates a singleton instance of AuthService.
  // This means only one instance of this class can exist throughout the application.

  final _httpService =
      HTTPService(); //This creates an instance of the HTTPService class for making HTTP requests.

  User?
      user; //This defines a variable to store the logged-in user information as a User object.

  factory AuthService() {
    //his is a factory constructor. It returns the singleton instance (_singleton) instead of creating a new object when called.
    return _singleton;
  }

  AuthService._internal(); //his is a private constructor that prevents creating new instances directly. Only the factory constructor can access it.
  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post("auth/login", {
        "username": username,
        "password": password,
      });
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        HTTPService().setup(bearerToken: user!.token);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}


//This is an asynchronous method called login that takes username and password as arguments and returns a Future<bool>. It performs the following steps:
//Uses _httpService.post to send a POST request to the "/auth/login" endpoint with the provided username and password.
//Checks the response status code. If it's 200 (success) and there's data, it parses the data using User.fromJson (presumably a method in the User class to convert JSON data to a User object).
//Sets the user variable with the parsed user information.
//Calls HTTPService().setup (likely to set a bearer token for future requests using the user's token).
//Returns true if successful.
//Catches any exceptions and prints them.
//Returns false in case of failures.




//Overall, this class manages user login by sending a POST request to an authentication endpoint and storing the user information if successful.
