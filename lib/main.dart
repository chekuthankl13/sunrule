import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/splash/splash_screen.dart';
import 'package:sunrule/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      // child: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(
      //       create: (context) =>
      //           CategoryCubit(apiRepository: context.read<ApiRepository>()),
      //       child: Container(),
      //     )
      //   ],
        child: 
        MaterialApp(
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
      // ),
    );
  }
}
