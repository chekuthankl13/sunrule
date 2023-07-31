import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/db/hivemodels/user_hive_model.dart';
import 'package:sunrule/firebase_options.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/splash/splash_screen.dart';
import 'package:sunrule/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// hive init
 await Hive.initFlutter();
//register adpater
Hive.registerAdapter<UserHiveModel>(UserHiveModelAdapter());
//open box
await Hive.openBox<UserHiveModel>("user");

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
               CartBloc(
                apiRepository: context.read<ApiRepository>()
               )..add(CartLoadEvent())
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
