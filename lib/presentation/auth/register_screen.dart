import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/auth/widget/fields.dart';
import 'package:sunrule/presentation/home/home_screen.dart';
import 'package:sunrule/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usrCntr = TextEditingController();
  TextEditingController pswCntr = TextEditingController();
  TextEditingController emailCntr = TextEditingController();
  TextEditingController addressCntr = TextEditingController();

  GlobalKey<FormState> fkey = GlobalKey<FormState>();

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
                  horizontal: 20, vertical: sH(context) / 5),
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
                // height: sH(context) / 3,
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
                      fields(
                          hint: "password",
                          ic: Icons.security,
                          cntr: pswCntr,
                          isPsw: true,
                          onPressed: () {}),
                      spaceHeight(10),
                      fields(
                          hint: "email",
                          isPsw: false,
                          ic: Icons.mail,
                          cntr: emailCntr),
                      spaceHeight(15),
                      fields(
                          hint: "Address",
                          ic: Icons.house,
                          cntr: addressCntr,
                          isPsw: false,
                          onPressed: () {}),
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
                                    error: "welcome  ${state.data.name} !!");
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
                                    context.read<AuthCubit>().registerUser(
                                        address: addressCntr.text
                                            .toLowerCase()
                                            .trim(),
                                        email:
                                            emailCntr.text.trim().toLowerCase(),
                                        psw: pswCntr.text.trim(),
                                        name: usrCntr.text);
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
                                child: const Text("Register"),
                              );
                            },
                          )
                        ],
                      ),
                      spaceHeight(10),
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
