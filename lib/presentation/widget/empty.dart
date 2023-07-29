
import 'package:flutter/material.dart';
import 'package:sunrule/utils/utils.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/empty.webp",
            height: sH(context) / 2,
            width: sW(context),
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
