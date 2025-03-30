import 'package:aros_staff/config/routes/app_route.dart';
import 'package:aros_staff/core/constants/api.dart';
import 'package:aros_staff/features/auth/data/repositoryImp/auth_repository_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/data/data_sources/local/auth_local_data_source.dart';
import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_reset_otp_usecase.dart';
import '../../features/auth/domain/usecases/old_login_usecase.dart';
import '../../features/auth/domain/usecases/request_reset_otp_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/home/data/data_sources/remote/home_remote_datasource.dart';
import '../../features/home/data/repositoryImp/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/check_in_usecase.dart';
import '../../features/home/domain/usecases/check_out_usecase.dart';
import '../../features/home/domain/usecases/check_state_usecase.dart';
import '../../features/home/domain/usecases/face_scan_usecase.dart';
import '../../features/home/domain/usecases/get_attendance_detail_usecase.dart';
import '../../features/home/domain/usecases/get_attendance_info_usecase.dart';
import '../../features/home/domain/usecases/get_current_month_dates_usecase.dart';
import '../../features/home/presentation/main/bloc/main_bloc.dart';
import '../../features/setting/data/data_source/remote/support_remote_datasource.dart';
import '../../features/setting/data/repositoryImp/support_repository_impl.dart';
import '../../features/setting/domain/repositories/support_repository.dart';
import '../../features/setting/domain/usecases/get_support_usecase.dart';
import '../constants/db_name.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {


  // internet connection checker
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));


  // App Router
  sl.registerLazySingleton<AppRouter>(() => AppRouter());

  // Local Data Source (Auth)
  sl.registerLazySingleton<AuthUserLocalDataSource>(() => AuthUserDataSourceIml(hiveBox: Hive.box(dbName)));


  // Dio Client
  sl.registerLazySingleton<DioClient>(() => DioClient( dio:  Dio(), baseUrl:ApiConstants.baseUrl, dataSource:  sl<AuthUserLocalDataSource>()));


  // Auth Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl<DioClient>()));


  // Auth repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource:sl<AuthRemoteDataSource>() ,localDataSource:sl<AuthUserLocalDataSource>()));


  // Auth useCase
  // sl.registerLazySingleton<CheckOtpUseCase>(() => CheckOtpUseCase(sl<AuthRepository>()));

  sl.registerLazySingleton<OldLoginUseCase>(() => OldLoginUseCase(sl<AuthRepository>()));

  sl.registerLazySingleton<ResetCheckOtpUseCase>(() => ResetCheckOtpUseCase(sl<AuthRepository>()));

  sl.registerLazySingleton<ResetOtpUseCase>(() => ResetOtpUseCase(sl<AuthRepository>()));

  sl.registerLazySingleton<ResetNewPasswordUseCase>(() => ResetNewPasswordUseCase(sl<AuthRepository>()));

  // sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl<AuthRepository>()));





  // Home Remote Data Source
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(sl<DioClient>()));


  // Home Repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: sl<HomeRemoteDataSource>()));


  // Home Use Cases
  sl.registerLazySingleton<GetCurrentMonthDatesUseCase>(() => GetCurrentMonthDatesUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<GetAttendanceDetailUseCase>(() => GetAttendanceDetailUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<CheckInUseCase>(() => CheckInUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<CheckOutUseCase>(() => CheckOutUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<FaceScanUseCase>(() => FaceScanUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<CheckStateUseCase>(() => CheckStateUseCase(sl<HomeRepository>()));

  sl.registerLazySingleton<GetAttendanceInfoUseCase>(() => GetAttendanceInfoUseCase(sl<HomeRepository>()));




// MainBloc
  sl.registerLazySingleton<MainBloc>(() => MainBloc(checkInUseCase: sl<CheckInUseCase>(), checkOutUseCase: sl<CheckOutUseCase>(), checkStateUseCase: sl<CheckStateUseCase>(), faceScanUseCase:  sl<FaceScanUseCase>()));

// Support
  sl.registerLazySingleton<SupportRemoteDataSource>(() => SupportRemoteDataSourceImpl(sl<DioClient>()));
  sl.registerLazySingleton<SupportRepository>(() => SupportRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetSupportInfo(sl()));
}
