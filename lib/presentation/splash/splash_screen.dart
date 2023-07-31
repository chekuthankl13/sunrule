import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/db/hive_helpers.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/auth/login_screen.dart';
import 'package:sunrule/presentation/home/home_screen.dart';
import 'package:sunrule/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      bool isUser = HiveHelpers.userBox.isEmpty;

      if (isUser) {
        navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(apiRepository: context.read<ApiRepository>()),
            child: const LoginScreen(),
          ),
        ),
      );
      } else {
        navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      }
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: sH(context),
      width: sW(context),
      decoration: const BoxDecoration(
          color: Colors.black12,
          image: DecorationImage(
              image: AssetImage(
                "assets/images/splash.jpg",
              ),
              opacity: .6,
              colorFilter: ColorFilter.linearToSrgbGamma(),
              fit: BoxFit.cover)),
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    ));
  }
}
