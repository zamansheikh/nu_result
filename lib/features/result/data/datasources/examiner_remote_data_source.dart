import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nu_result/features/result/data/models/examiner_model.dart';
import 'package:nu_result/features/result/data/models/user_model.dart';

import '../../../../core/constants/app_key.dart';
import '../../../../core/errors/exception.dart';

abstract class ExaminerRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ExaminerModel> getExaminerResult(
      String registrationNumber, String session);

  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getUserInfo(String registrationNumber);
}

class ExaminerRemoteDataSourceImpl implements ExaminerRemoteDataSource {
  final http.Client client;
  ExaminerRemoteDataSourceImpl({required this.client});

  @override
  Future<ExaminerModel> getExaminerResult(
      String registrationNumber, String session) async {
    int sessionInt = int.parse(session);
    List<String> sessionUrlList = [];

    // Generate URLs for each session
    for (var i = sessionInt; i < sessionInt + 5; i++) {
      sessionUrlList.add(getUrlViaRegistrationNumber(
          registrationNumber, "$i", ExamType.first, ""));
      sessionUrlList.add(getUrlViaRegistrationNumber(
          registrationNumber, "$i", ExamType.second, ""));
      sessionUrlList.add(getUrlViaRegistrationNumber(
          registrationNumber, "$i", ExamType.third, ""));
      sessionUrlList.add(getUrlViaRegistrationNumber(
          registrationNumber, "$i", ExamType.fourth, ""));
    }

    ExaminerModel examinerModel = ExaminerModel(
        registrationNumber: registrationNumber, name: "No Name", html: []);

    // Fetch the URLs in parallel with error handling
    const int maxRetries = 3; // Max retries for each request

    try {
      Future<String> fetchUrlWithRetry(String url, int retries) async {
        for (int attempt = 1; attempt <= retries; attempt++) {
          try {
            final response = await client.get(Uri.parse(url), headers: {
              'Content-Type': 'application/json',
            });
            if (response.statusCode == 200) {
              return response.body;
            } else {
              throw ServerException(); // Throw an error if the status is not 200
            }
          } catch (e) {
            if (attempt == retries) {
              // ignore: avoid_print
              print('Failed to fetch $url after $retries attempts: $e');
              return ''; // Return empty string if all retries fail
            } else {
              await Future.delayed(const Duration(seconds: 1)); // Retry delay
              // ignore: avoid_print
              print('Retrying ($attempt/$retries) for $url...');
            }
          }
        }
        return ''; // Fallback in case of failure after retries
      }

      // Fetch all session URLs concurrently
      List<Future<String>> requestFutures = sessionUrlList
          .map((url) => fetchUrlWithRetry(url, maxRetries))
          .toList();

      // Wait for all requests to complete
      List<String> responses = await Future.wait(requestFutures);

      // Add successful responses to the examinerModel
      for (var responseBody in responses) {
        if (responseBody.isNotEmpty) {
          examinerModel.html!.add(responseBody);
        }
      }

      return Future.value(examinerModel);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserInfo(String registrationNumber) async {
    final url = Uri.parse('http://103.113.200.44:8006/api/student/login');
    final body = {
      'username': registrationNumber,
      'password': "123456",
      'recaptcha-v3': 'undefined',
    };
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final studentJson = jsonResponse['student'];
      final userModel = UserModel.fromJson(studentJson);
      return Future.value(userModel);
    } else {
      throw ServerException();
    }
  }
}
