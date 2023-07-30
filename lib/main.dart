import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/firebase_options.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/splash/splash_screen.dart';
import 'package:sunrule/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// bloc observe state change
  Bloc.observer = MyBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiRepository(),
        ),
        // RepositoryProvider(
        //   create: (context) => SubjectRepository(),
        // ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
               CartBloc()
          )
        ],
      child: MaterialApp(
        title: 'Sunrule',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Config.violet),
          primaryColor: Config.violet,
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen(),
      ),
      ),
    );
  }
}
