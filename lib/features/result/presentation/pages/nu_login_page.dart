import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_result/core/utils/utils.dart';
import 'package:nu_result/features/result/presentation/bloc/examiner_result_bloc.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/constants/update_checker.dart';
import '../../../../core/constants/update_constants.dart';
import '../../../../shared/widgets/big_card_image_slide.dart';
import '../../../cgpa/presentation/pages/home.dart';
import '../../../html_scrapper/presentation/pages/input_page.dart';
import 'donation_page.dart';
import 'notice_model.dart';
import 'user_info_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _currentVersion = CURRENT_VERSION;
  String? studentRegistration;
  bool _isLoading = false;
  List<NoticeModel> _notices = [];

  //load Banner
  Future<void> _loadNotices() async {
    try {
      // Firebase functionality removed
      // final notices = await NoticeModel.loadFromFirebase();
      setState(() {
        _notices = [];
      });
    } catch (e) {
      // Handle error if needed
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching notices. Please try again.')),
      );
    }
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        context.read<ExaminerResultBloc>().add(
          GetUsrInfoEvent(registrationNumber: studentRegistration!),
        );
      } catch (e) {
        // Handle error if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching results. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNotices();
    // Check for updates when the app launches
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () async {
        if (context.mounted) {
          // ignore: use_build_context_synchronously
          _currentVersion = await checkUpdateFromGithub(context);
        }
        setState(() {
          _currentVersion = _currentVersion;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 100,
        title: const Text('NU Result - CGPA'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
        actions: [
          Image.asset(NU_LOGO_ICON, width: 40, height: 40),
          SizedBox(width: 10),
        ],
      ),
      drawer: _drawer(context),
      body: BlocConsumer<ExaminerResultBloc, ExaminerResultState>(
        listener: (context, state) {
          if (state is ExaminerResultError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error fetching results. Please try again.'),
              ),
            );
          } else if (state is UserInfoLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserInfoPage(user: state.user),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ExaminerResultLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Center logo
                        Center(
                          child: Image.asset(NU_PLAYSTORE_LOGO, width: 200),
                        ),
                        const Text(
                          'View User Information',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
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

                        // Submit Button
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child:
                                BlocBuilder<
                                  ExaminerResultBloc,
                                  ExaminerResultState
                                >(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        iconColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        _submitForm(context);
                                      },
                                      child: const Text(
                                        'View Profile',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Center(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         backgroundColor: Colors.blueAccent,
                        //         iconColor: Colors.white,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10.0),
                        //         ),
                        //       ),
                        //       onPressed: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const ResultInputPage(),
                        //           ),
                        //         );
                        //       },
                        //       child: const Text(
                        //         'View Results',
                        //         style: TextStyle(
                        //             fontSize: 18, color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        SizedBox(
                          height: 180,
                          child: Visibility(
                            visible: _notices.isNotEmpty,
                            child: Center(
                              child: BigCardImageSlide(notices: _notices),
                            ),
                          ),
                        ),

                        //Show a divider
                        const Divider(),

                        const SizedBox(height: 10),
                        //Join us on Telegram
                        TextButton(
                          onPressed: () {
                            launchURL('https://t.me/nu_fam');
                          },
                          child: const Text(
                            textAlign: TextAlign.center,
                            'Join us on Telegram\n@nu_fam - NU Result - CGPA App Family\nYou can ask for help here.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueAccent,
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
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  _drawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset('assets/icon/icon.jpg', width: 100, height: 100),
                  const Text(
                    'NU Result - CGPA',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(endIndent: 20),
          ListTile(
            title: const Text('CGPA Calculator'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GHomePage()),
              );
            },
          ),
          const Divider(endIndent: 20),
          ListTile(
            title: const Text('Result Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResultInputPage(),
                ),
              );
            },
          ),
          const Divider(endIndent: 20),
          ListTile(
            title: const Text('Donate'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DonationPage()),
              );
            },
          ),
          const Divider(endIndent: 20),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('About'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'This app is developed by Zaman Sheikh. It is a simple app to view the user information and result of a student of National University of Bangladesh.',
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            const url =
                                'https://www.facebook.com/zamansheikh.404';
                            launchURL(url);
                          },
                          child: const Text(
                            'Visit my Facebook',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20), // Replaced Spacer with SizedBox
          Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.system_update),
            title: Text(
              CURRENT_VERSION == _currentVersion
                  ? 'Up to date'
                  : _currentVersion,
            ),
            onTap: () {
              checkUpdateFromGithub(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
