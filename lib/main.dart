import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_result/features/html_scrapper/presentation/pages/backup_result_input_page.dart';
import 'package:nu_result/features/result/presentation/bloc/examiner_result_bloc.dart';
import 'package:nu_result/features/result/presentation/pages/nu_login_page.dart';
import 'package:nu_result/features/update/presentation/pages/link_form_page.dart';
import 'core/injection_container.dart';
import 'core/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExaminerResultBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NU Result - CGPA Calculator and Marksheet Generator',
        theme: ThemeData(
          primaryColor: Colors.blue.shade800,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/backupresult': (context) => const BackupResultInputPage(),
          '/linkform': (context) => const LinkFormPage(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
