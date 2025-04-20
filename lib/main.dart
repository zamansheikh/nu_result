import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nu_result/features/html_scrapper/pages/backup_result_input_page.dart';
import 'package:nu_result/features/result/presentation/bloc/examiner_result_bloc.dart';
import 'package:nu_result/features/result/presentation/page/nu_login_page.dart';
import 'package:nu_result/features/update/link_form_page.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        title: 'CGPAViZ - NuResult',
        theme: ThemeData(
          primaryColor: Colors.blue.shade800,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
          ),
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

// //! Gplay Generator
// import 'package:flutter/material.dart';
// import 'package:nu_result/gplay/pages/g_home.dart';
// import 'package:nu_result/gplay/gplay_const/gplay_contants.dart';
// import 'injection_container.dart' as di;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: GplayContants.appTitle,
//       theme: ThemeData(
//         primaryColor: Colors.blue.shade800,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.blueAccent,
//         ),
//       ),
//       home: const GHomePage(),
//     );
//   }
// }
