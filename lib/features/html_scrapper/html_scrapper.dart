// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

import '../../shared/models/result_model.dart';

ResultModel scrapeStudentResult(String htmlString) {
  // Parse the HTML string
  Document document = html_parser.parse(htmlString);
  List<Element> courseRows1 = document.querySelectorAll('table#customers tr');
  List<CourseGrade> courseGrades1 = [];
  for (int i = 4; i < courseRows1.length; i++) {
    var rowColumns = courseRows1[i].querySelectorAll('td');
    if (rowColumns.length == 4) {
      courseGrades1.add(CourseGrade(
        courseCode: rowColumns[0].text.trim(),
        courseTitle: rowColumns[1].text.trim(),
        credit: rowColumns[2].text.trim(),
        letterGrade: rowColumns[3].text.trim(),
      ));
    }
  }

  // Extract student result data from the HTML content
  // String getTextAfterLabel(String label) {
  //   var element = document.querySelectorAll('td').firstWhere(
  //         (td) => td.text.trim().toLowerCase() == label.toLowerCase(),
  //         orElse: () => Element.tag('td'), // Return a dummy element
  //       );
  //   return element.nextElementSibling?.text.trim() ?? '';
  // }

  String getTextAfterLabel(String label) {
    var element = document.querySelectorAll('td').firstWhere(
          (td) => td.text.trim().toLowerCase() == label.trim().toLowerCase(),
          orElse: () => Element.tag('td'), // Return a dummy element
        );
    return element.nextElementSibling?.text.trim() ?? '';
  }

  String isPromoted() {
    if (htmlString.contains("Not Promoted")) {
      return "Not Promoted";
    } else if (htmlString.contains("Promoted")) {
      return "Promoted";
    } else if (htmlString.contains("Conditional Promoted")) {
      return "Conditional Promoted";
    } else if (htmlString.contains("Withheld")) {
      return "Withheld";
    } else if (htmlString.contains("Reported")) {
      return "Reported";
    } else {
      return "Unknown";
    }
  }

  var studentName = getTextAfterLabel('Name of Student');
  var college = getTextAfterLabel('College');
  var registrationNo = getTextAfterLabel('Registration no.');
  var session = getTextAfterLabel('Session');
  var studentType = getTextAfterLabel('Student Type');
  var subject = getTextAfterLabel('Subject');
  var result = getTextAfterLabel('Result').isEmpty
      ? isPromoted()
      : getTextAfterLabel('Result');
  // Extract course grades
  var courseGrades = <CourseGrade>[];
  var courseRows = document.querySelectorAll('#customers tr');
  for (var row in courseRows.skip(2)) {
    // Skip header rows
    var columns = row.querySelectorAll('td');
    if (columns.length == 4) {
      var courseCode = columns[0].text.trim();
      var courseTitle = columns[1].text.trim();
      var credit = columns[2].text.trim();
      var letterGrade = columns[3].text.trim();
      courseGrades.add(CourseGrade(
        courseCode: courseCode,
        courseTitle: courseTitle,
        credit: credit,
        letterGrade: letterGrade,
      ));
    }
  }
  return ResultModel(
    studentName: studentName,
    college: college,
    registrationNo: registrationNo,
    session: session,
    studentType: studentType,
    subject: subject,
    result: result,
    courseGrades: courseGrades.sublist(1),
    examType: "",
    year: "",
  );
}

Future<ResultModel> webLoader({
  required String regi,
  required String year,
  required String roll,
  required String examType,
}) async {
  final String url =
      "http://results.nu.ac.bd/honours/${examType}_result_show.php?roll_number=$roll&reg_no=$regi&exam_year=$year";

  int retryCount = 0; // Track how many retries have been made

  while (retryCount < 3) {
    // Retry up to 3 times
    try {
      var response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10), // Timeout after 10 seconds
        onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, please try again.');
        },
      );

      if (response.statusCode == 200) {
        var htmlString = response.body;
        print("${htmlString.length} + $regi + $year + $examType\n$url");
        if (htmlString.contains('Wrong')) {
          throw Exception('Wrong regi or Year!.');
        }
        if (htmlString.contains('will be available soon')) {
          throw Exception('Result not published yet.\nWill be available soon.');
        }

        // Scrape the student result from the HTML content
        ResultModel result = scrapeStudentResult(htmlString);
        result = result.copyWith(
          examType: examType,
          year: year,
          registrationNo: regi,
        );
        return result;
      } else {
        throw HttpException(
            'Failed to load data, status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print('SocketException occurred: $e');
      throw Exception(
          'No internet connection or host not found. Please check your network and try again.');
    } on TimeoutException catch (e) {
      print('TimeoutException occurred: $e');
      throw Exception('Connection timed out. Please try again.');
    } on http.ClientException catch (e) {
      // Specifically handle 'ClientException: Connection closed before full header was received'
      print('ClientException occurred: $e');

      retryCount++; // Increment retry counter

      if (retryCount < 3) {
        print('Retrying... Attempt $retryCount');
        await Future.delayed(
            const Duration(seconds: 2)); // Add a small delay before retrying
        continue; // Retry the request
      } else {
        throw Exception(
            'Connection closed unexpectedly. Please try again later.');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
      if (e.toString().contains("Wrong")) {
        throw Exception(
            "Wrong Registration or Year!\nMaybe result not published yet.");
      } else {
        throw Exception(e.toString());
      }
    }
  }

  // After 3 retries, if still failing, throw an error
  throw Exception(
      'Failed to retrieve data after multiple attempts. Please try again later.');
}
