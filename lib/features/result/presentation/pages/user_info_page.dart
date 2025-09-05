import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_result/core/utils/utils.dart';
import 'package:nu_result/features/html_scrapper/html_scrapper.dart';
import 'package:nu_result/features/result/domain/entities/user.dart';
import 'package:nu_result/features/result/presentation/bloc/examiner_result_bloc.dart';

import '../../../../core/constants/constant.dart';
import '../../../../shared/models/result_model.dart';
import 'all_result_page.dart';

class UserInfoPage extends StatefulWidget {
  final User user;
  const UserInfoPage({super.key, required this.user});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List<ResultModel> results = [];
  bool _isLoading = false;
  String getGender(String number) {
    if (number == '1') {
      return "Male";
    } else {
      return "Female";
    }
  }

  void fetchFake() async {
    setState(() {
      _isLoading = true;
    });
    results = await fetchAllResults();
    if (mounted) {
      if (results.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllResultPage(
              results: results,
            ),
          ),
        );
      } else {
        fToast(
          context,
          message: "Server Error!",
          decription:
              "Nu Server is not responding,Plese try again with stable internet connection.",
        );
      }
    }
  }

  Future<List<ResultModel>> fetchAllResults() async {
    List<ResultModel> allResults = [];

    final String regi = widget.user.regNo;
    // final String roll = widget.user.admissionRoll;
    final String year = widget.user.acSession.substring(0, 4);
    final int intYear = int.parse(year) + 1;
    final List<String> examTypes = [
      'first_year',
      'second_year',
      'third_year',
      'fourth_year'
    ];
    List<Map<String, String>> inputs = [];
    // inputs.add({
    //   'regi': "19228324714",
    //   'year': "2021",
    //   'roll': "",
    //   'examType': 'first_year'
    // });
    //make a loop for 7 years check
    for (var i = intYear; i < intYear + 7; i++) {
      final String year = i.toString();
      //loop for 4 years
      for (var j = 0; j < examTypes.length; j++) {
        final String examType = examTypes[j];
        inputs.add(
            {'regi': regi, 'year': year, 'roll': "", 'examType': examType});
      }
    }
    // print(inputs);

    for (var input in inputs) {
      try {
        ResultModel result = await webLoader(
          regi: input['regi']!,
          year: input['year']!,
          roll: "",
          examType: input['examType']!,
        );
        allResults.add(result); 
      } catch (e) {
        // Skip if an exception occurs
        // ignore: avoid_print
        print('Error ! Roll: ${input['roll']}, skipping...');
      }
    }
    setState(() {
      _isLoading = false;
    });

    return allResults; // Return the list of all successful results
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 100,
        title: const Text('Student Profile'),
        actions: [
          Image.asset(
            NU_LOGO_ICON,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: BlocConsumer<ExaminerResultBloc, ExaminerResultState>(
        listener: (context, state) {
          if (state is ExaminerResultError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // User Profile Image
                  Center(
                    child: Container(
                      width: 120, // Diameter of the CircleAvatar
                      height: 120, // Diameter of the CircleAvatar
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 3.0, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(widget.user.photoUrl),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Info Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  widget.user.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Reg. No: ${widget.user.regNo}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // User academic info section
                          _buildSectionHeader('Personal Information'),
                          const SizedBox(height: 8),
                          Text(
                            'Email: ${widget.user.email}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            'Mobile: ${widget.user.mobile}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            'Gender: ${getGender(widget.user.gender)}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            'Father: ${widget.user.fatherName}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            'Mother: ${widget.user.motherName}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),

                          const SizedBox(height: 8),
                          // User academic info section
                          _buildSectionHeader('Academic Information'),
                          const SizedBox(height: 8),
                          _buildInfoRow('Session', widget.user.acSession),
                          _buildInfoRow(
                              'Degree', widget.user.degree.degreeDisplayName),
                          _buildInfoRow('Merit Position',
                              widget.user.meritPosition ?? "N/A"),
                          _buildInfoRow(
                              'Admission Roll', widget.user.admissionRoll),
                          _buildInfoRow(
                              'Subject', widget.user.subject.subjectName),

                          const SizedBox(height: 16),

                          // User college info section
                          _buildSectionHeader('College Information'),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                              'College', widget.user.college.collegeName),
                          _buildInfoRow(
                              'College EIIN', widget.user.college.collegeEiin),
                          _buildInfoRow(
                              'College Address', widget.user.college.address),
                          _buildInfoRow('Division',
                              widget.user.college.districts.divisionId),
                          _buildInfoRow('District',
                              widget.user.college.districts.districtName),
                          _buildInfoRow(
                              'Post Code', widget.user.college.postCode),

                          const SizedBox(height: 20),

                          // Action Button to show results
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
                                onPressed: () async {
                                  fetchFake();
                                },
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Show - All Results(Testing)',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                              ),
                            ),
                          ),
                          //Expereimental feature text
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Note: This feature is experimental, it may not work properly. Maybe calculation is wrong.We are working on it.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
