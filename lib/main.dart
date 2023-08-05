import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_structure/constants/route_path.dart';
import 'package:project_structure/controller/app_provider.dart';
import 'package:project_structure/data/dio_api_service.dart';
import 'package:project_structure/data/dio_connectivity_retrier.dart';
import 'package:project_structure/data/logging_interceptor.dart';
import 'package:project_structure/data/retrier_interceptor.dart';
import 'package:project_structure/utils/router.dart';
import 'package:project_structure/utils/shared_preference.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //
  // initialize easy localization for internationalization
  //
  await EasyLocalization.ensureInitialized();

  //
  // initialize shared preference
  //
  await SharedPref.instance.getInstance();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider()),
        ],
        builder: (context, child) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    //
    // initialize dio and add interceptors
    //
    var dio = DioApiService.dio;
    dio.interceptors.addAll([
      LoggingInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: RoutePath.homeScreen,
    );
  }
}
