import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/auth/register_screen.dart';
import 'package:sunrule/presentation/auth/widget/fields.dart';
import 'package:sunrule/presentation/home/home_screen.dart';
import 'package:sunrule/utils/utils.dart';

ValueNotifier<bool> isSHow = ValueNotifier(false);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController usrCntr = TextEditingController();
TextEditingController pswCntr = TextEditingController();

GlobalKey<FormState> fkey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Config.violet.withOpacity(.5),
      body: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: sH(context) / 4),
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
                    fit: BoxFit.cover),
              ),
              child: Container(
                height: sH(context) / 3,
                // width: sW(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: fkey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      spaceHeight(10),
                      fields(
                          hint: "username",
                          isPsw: false,
                          ic: Icons.emoji_people_rounded,
                          cntr: usrCntr),
                      spaceHeight(15),
                      ValueListenableBuilder(
                        valueListenable: isSHow,
                        builder: (context, value, child) => fields(
                            hint: "password",
                            ic: Icons.security,
                            cntr: pswCntr,
                            isPsw: true,
                            onPressed: () {
                              if (value) {
                                isSHow.value = false;
                              } else {
                                isSHow.value = true;
                              }
                            }),
                      ),
                      spaceHeight(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthLoadError) {
                                errorToast(context, error: state.error);
                              }
                              if (state is AuthLoadSuccess) {
                                errorToast(context,
                                    error:
                                        "welcome back ${state.data.name} !!");
                                navigatorKey.currentState!.pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false);
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(sW(context) / 2, 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Config.violet,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const CupertinoActivityIndicator(
                                      color: Colors.white,
                                    ));
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  if (fkey.currentState!.validate()) {
                                    context.read<AuthCubit>().loginUser(
                                        email:
                                            usrCntr.text.trim().toLowerCase(),
                                        psw: pswCntr.text.trim());
                                  }
                                  // context.read<AuthCubit>().onLogin(
                                  //     name: usrCntr.text.trim(),
                                  //     psw: pswCntr.text.trim());
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(sW(context) / 2, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Config.violet,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Login"),
                              );
                            },
                          )
                        ],
                      ),
                      spaceHeight(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () {
                                navigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => AuthCubit(
                                          apiRepository:
                                              context.read<ApiRepository>()),
                                      child: const RegisterScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Register"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
