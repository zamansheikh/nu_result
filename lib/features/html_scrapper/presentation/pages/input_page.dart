import 'package:flutter/material.dart';
import 'package:nu_result/core/utils/utils.dart';
import 'package:nu_result/features/html_scrapper/html_scrapper.dart';

import '../../../../core/constants/constant.dart';
import 'student_result_page.dart';

class ResultInputPage extends StatefulWidget {
  const ResultInputPage({super.key});

  @override
  State<ResultInputPage> createState() => _ResultInputPageState();
}

class _ResultInputPageState extends State<ResultInputPage> {
  final _formKey = GlobalKey<FormState>();

  String? studentRegistration;
  String? examYear;
  int selectedExamType = 1;
  String? studentRoll;
  bool _isLoading = false;

  // For storing exam types
  final Map<int, String> examTypes = {
    1: 'First Year',
    2: 'Second Year',
    3: 'Third Year',
    4: 'Fourth Year'
  };

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String caseType = examTypes[selectedExamType]!;
      String examType = caseType;
      switch (caseType) {
        case 'First Year':
          examType = 'first_year';
          break;
        case 'Second Year':
          examType = 'second_year';
          break;
        case 'Third Year':
          examType = 'third_year';
          break;
        case 'Fourth Year':
          examType = 'fourth_year';
          break;
        default:
          examType = 'first_year';
          break;
      }

      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        final model = await webLoader(
          regi: studentRegistration!,
          year: examYear!,
          roll: studentRoll!,
          examType: examType,
        );

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentResultPage(
                result: model,
                typeDetails: "$caseType ($examYear)",
                registration: studentRegistration!,
                roll: studentRoll!,
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

                    // Exam Year Field
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Exam Year',
                        hintText: "Ex: 2015",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter exam year';
                        } else if (int.tryParse(value) == null) {
                          return 'Please enter a valid year';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        examYear = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Student Roll Field
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Ex:207816",
                        labelText:
                            'Roll Optional : Only required for improvement result',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        studentRoll = (value == null) ? "" : value;
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
                      children: examTypes.entries.map((entry) {
                        return ChoiceChip(
                          label: Text(entry.value),
                          selected: selectedExamType == entry.key,
                          selectedColor: Colors.blueAccent,
                          labelStyle: TextStyle(
                            color: selectedExamType == entry.key
                                ? Colors.white
                                : Colors.black,
                          ),
                          onSelected: (bool selected) {
                            setState(() {
                              selectedExamType = entry.key;
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
