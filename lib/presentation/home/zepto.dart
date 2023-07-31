import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/db/hive_helpers.dart';
import 'package:sunrule/presentation/splash/splash_screen.dart';
import 'package:sunrule/utils/utils.dart';

class Zepto extends StatelessWidget {
  const Zepto({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: kToolbarHeight,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    spaceWidth(5),
                    const Icon(
                      CupertinoIcons.person_alt,
                      color: Config.violet,
                    ),
                    spaceWidth(10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(HiveHelpers().getCredentials()!.name,
                            style: const TextStyle(fontSize: 12)),
                        spaceHeight(5),
                        Text(
                          HiveHelpers().getCredentials()!.address,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                        onPressed: () async {
                          await HiveHelpers().clearUserBox();
                          navigatorKey.currentState!.pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const SplashScreen(),
                              ),
                              (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Config.red,
                            side: const BorderSide(color: Config.red),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout")),
                    spaceWidth(5)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
