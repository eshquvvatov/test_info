import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/localization/app_localizations.dart';
import 'config/localization/localizationBloc/localization_cubit.dart';
import 'config/routes/app_route.dart';

import 'core/constants/db_name.dart';
import 'core/di/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/utils/logger.dart';
import 'features/home/presentation/main/bloc/main_bloc.dart';

void main() async {


  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    await Hive.openBox(dbName);
    await initializeDependencies();

    runApp(MultiBlocProvider(providers: [
      BlocProvider<LocalizationCubit>(
          create: (BuildContext context) => LocalizationCubit()),

      BlocProvider<MainBloc>(
          create: (BuildContext context) =>  sl<MainBloc>(),),
    ], child: const MyApp()));
  },
        (error, stackTrace) => LogService.i("${error}\nstackTrace${ stackTrace}"),
  );

}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (__, state) {
              return MaterialApp.router(

                routerConfig: sl<AppRouter>().router,
                debugShowCheckedModeBanner: false,
                title: "Aros Staff",
                locale: state.appLocal,
                builder: (___, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.noScaling,
                    ),
                    child: child!,
                  );
                },
                supportedLocales: const [
                  Locale('uz', 'UZ'),
                  Locale('ru', 'RU'),
                  Locale('en', 'EN'),
                ],
                localizationsDelegates: const[
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                localeResolutionCallback: (final deviceLocale, final supportedLocales) {
                  for (final locale in supportedLocales) {
                    if (deviceLocale == locale) {
                      return deviceLocale;
                    }
                  }

                  for (final locale in supportedLocales) {
                    if (locale.languageCode == state.appLocal.languageCode) {
                      return state.appLocal;
                    }
                  }
                  return const Locale('en', 'EN');
                },
              );
            },
          );
        });
  }
}

