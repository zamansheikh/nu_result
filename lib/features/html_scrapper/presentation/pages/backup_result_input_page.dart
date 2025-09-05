// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nu_result/core/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constant.dart';
import '../../../../shared/models/link_model.dart';
import 'backup_result_view.dart';

class BackupResultInputPage extends StatefulWidget {
  const BackupResultInputPage({super.key});

  @override
  State<BackupResultInputPage> createState() => _BackupResultInputPageState();
}

class _BackupResultInputPageState extends State<BackupResultInputPage> {
  final _formKey = GlobalKey<FormState>();
  List<LinkModel> totalExamUrl = [];
  String selectedExamType = 'Any';
  @override
  void initState() {
    super.initState();
    // Firebase functionality removed
    // LinkModel.loadFromFirebase().then((value) {
    setState(() {
      totalExamUrl = [];
      selectedExamType = 'Any';
    });
    // });
  }

  Future<String> backupWebLoader({required String url}) async {
    int retryCount = 0; // Track how many retries have been made

    while (retryCount < 3) {
      // Retry up to 3 times
      try {
        print(url);
        var response = await http.get(Uri.parse(url)).timeout(
          const Duration(seconds: 30), // Timeout after 10 seconds
          onTimeout: () {
            throw TimeoutException(
                'The connection has timed out, please try again.');
          },
        );

        if (response.statusCode == 200) {
          var htmlString = response.body;
          print("${htmlString.length} + \n$url");
          if (htmlString.contains('Wrong')) {
            throw Exception('Wrong regi or Year!.');
          }

          // Scrape the student result from the HTML content
          String result = htmlString;

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
        //retry
        retryCount++;
        if (retryCount < 3) {
          print('Retrying... Attempt $retryCount');
          await Future.delayed(
              const Duration(seconds: 2)); // Add a small delay before retrying
          continue; // Retry the request
        } else {
          throw Exception('Connection timed out. Please try again later.');
        }
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

  String? studentRegistration;
  String? examYear;
  String? studentRoll;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String caseType = selectedExamType;
      String generatedUrl = "";
      switch (caseType) {
        case 'BA':
          var linkModel =
              totalExamUrl.firstWhere((element) => element.title == 'BA');
          generatedUrl = LinkModel.generateUrl(linkModel,
              studentRegistration ?? "", studentRoll ?? "", examYear ?? "");
          break;
        case 'BSS':
          var linkModel =
              totalExamUrl.firstWhere((element) => element.title == 'BSS');
          generatedUrl = LinkModel.generateUrl(linkModel,
              studentRegistration ?? "", studentRoll ?? "", examYear ?? "");

          break;
        case 'BSc':
          var linkModel =
              totalExamUrl.firstWhere((element) => element.title == 'BSc');
          generatedUrl = LinkModel.generateUrl(linkModel,
              studentRegistration ?? "", studentRoll ?? "", examYear ?? "");

          break;
        case 'BBA':
          var linkModel =
              totalExamUrl.firstWhere((element) => element.title == 'BBA');
          generatedUrl = LinkModel.generateUrl(linkModel,
              studentRegistration ?? "", studentRoll ?? "", examYear ?? "");

          break;
        case 'B.Mus':
          var linkModel =
              totalExamUrl.firstWhere((element) => element.title == 'B.Mus');
          generatedUrl = LinkModel.generateUrl(linkModel,
              studentRegistration ?? "", studentRoll ?? "", examYear ?? "");

          break;

        default:
          var linkModel =
              totalExamUrl.firstWhere((element) => element.title == 'BA');
          generatedUrl = LinkModel.generateUrl(linkModel,
              studentRegistration ?? "", studentRoll ?? "", examYear ?? "");
          break;
      }

      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        final htmlString = await backupWebLoader(
          url: generatedUrl,
        );
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BackupResultView(
                htmlString: htmlString,
              ),
            ),
          );
        }
      } catch (e) {
        // Handle error if needed
        if (mounted) {
          fToast(context, message: e.toString(), decription: e.toString());
        }
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 100,
        title: const Text('NU Result - CGPA'),
        actions: [
          Image.asset(
            NU_LOGO_ICON,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Center logo
                    Center(
                      child: Image.asset(
                        NU_PLAYSTORE_LOGO,
                        width: 200,
                      ),
                    ),

                    const Text(
                      'Enter Exam Details',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // Student Registration Field
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Ex: 13227207816",
                        labelText: 'Student Registration',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter student registration number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        studentRegistration = value;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Select Exam Type',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Exam Type Selectable Chips
                    Wrap(
                      spacing: 10.0,
                      children: totalExamUrl.map((exam) {
                        return ChoiceChip(
                          label: Text(exam.title),
                          selected: selectedExamType == exam.title,
                          selectedColor: Colors.blueAccent,
                          labelStyle: TextStyle(
                            color: selectedExamType == exam.title
                                ? Colors.white
                                : Colors.black,
                          ),
                          onSelected: (bool selected) {
                            setState(() {
                              selectedExamType = exam.title;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            iconColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Show loading indicator when submitting form
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
