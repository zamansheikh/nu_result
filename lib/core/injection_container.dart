import 'package:get_it/get_it.dart';
import 'package:nu_result/features/result/data/datasources/examiner_remote_data_source.dart';
import 'package:nu_result/features/result/data/repositories/examiner_repository_impl.dart';
import 'package:nu_result/features/result/domain/repositories/examiner_repository.dart';
import 'package:nu_result/features/result/domain/usecases/get_examiner_result.dart';
import 'package:nu_result/features/result/domain/usecases/get_user_info.dart';
import 'package:nu_result/features/result/presentation/bloc/examiner_result_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../core/network/network_info.dart';
import '../core/utils/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Number Trivia

  //! Features - Result
  // Bloc
  sl.registerFactory(
    () => ExaminerResultBloc(
      getExaminerResultUseCase: sl(),
      getUserInfoUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetExaminerResult(sl()));
  sl.registerLazySingleton(() => GetUserInfo(sl()));

  // Repository
  sl.registerLazySingleton<ExaminerRepository>(() => ExaminerRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<ExaminerRemoteDataSource>(
      () => ExaminerRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}

// //! Gplay Generator
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';

// import 'core/platform/network_info.dart';
// import 'core/utils/input_converter.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   //! Core
//   sl.registerLazySingleton(() => InputConverter());
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//   //! External
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   sl.registerLazySingleton<SharedPreferences>(() => prefs);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => Connectivity());
// }
