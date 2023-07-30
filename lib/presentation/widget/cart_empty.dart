import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/utils/utils.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/bag.png",
                height: sH(context) / 2,
                width: sW(context) / 2,
                fit: BoxFit.contain,
              ),
            ],
          ),
          spaceHeight(10),
          const Text("Cart is Empty")
        ],
      ),
    );
  }
}
