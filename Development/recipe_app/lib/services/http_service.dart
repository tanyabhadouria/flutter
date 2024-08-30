import 'package:dio/dio.dart';
import 'package:recipe_app/consts.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService
      ._internal(); //This creates a singleton instance of HTTPService.
  //This means only one instance of this class can exist throughout the application.

  final _dio =
      Dio(); //This creates an instance of the Dio class for making HTTP requests.

  factory HTTPService() {
    //This is a factory constructor. It returns the singleton instance (_singleton) instead of creating a new object when called.
    return _singleton;
  }

  HTTPService._internal() {
    //This is a private constructor that prevents creating new instances directly. Only the factory constructor can access it.
    setup(); //Calls the setup method to configure the Dio instance.
  }
  Future<void> setup({String? bearerToken}) async {
    final headers = {
      "Content-Type": "application/json",
    };
    if (bearerToken != null) {
      headers["Authorization"] = "Bearer $bearerToken";
    }
    final Options = BaseOptions(
        baseUrl: API_BASE_URL,
        headers: headers,
        validateStatus: (status) {
          if (status == null) return false;
          return status < 500;
        });

    _dio.options = Options;
  }

//   //This is an asynchronous method called setup that takes an optional bearerToken argument (likely for authorization). It performs the following steps:
// Defines a map of headers with "Content-Type: application/json" for sending JSON data.
// If bearerToken is provided, it adds an "Authorization" header with the "Bearer" prefix and the token.
// Creates a BaseOptions object for Dio configuration. This object sets the base URL from API_BASE_URL (presumably defined in consts.dart), sets the default headers, and defines a custom validation function for response status codes.
// The validation function checks if the status code is less than 500 (meaning successful or client-side errors). This allows handling of non-200 successful responses (like 201 Created) while considering errors above 500 as server-side issues.
// Sets the configured options to the _dio instance.

  Future<Response?> post(String path, Map data) async {
    try {
      final Response = await _dio.post(
        path,
        data: data,
      );
      return Response;
    } catch (e) {
      print(e);
    }
  }

//   This is an asynchronous method called post that takes a path and data map as arguments and returns a Future<Response?>. It performs the following steps:
// Tries to make a POST request to the specified path with the provided data using _dio.post.
// If successful, it returns the response object.
// Catches any exceptions and prints them.
// Returns null in case of exceptions.

  Future<Response?> get(String path) async {
    try {
      final Response = await _dio.get(path);
      return Response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

// This is an asynchronous method called get that takes a path as a string argument and returns a Future<Response?>. It performs the following steps similar to post:
// Tries to make a GET request to the specified path using _dio.get.
// If successful, it returns the response object.
// Catches any exceptions and prints them.
// Returns null in case of exceptions.
