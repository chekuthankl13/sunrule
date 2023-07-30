import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/utils/utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Config.violet,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: const Text(
          "Cart",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Empty Cart",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: btmNav(),
      body: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                gradient: LinearGradient(colors: [
                  Config.violet,
                  Config.red.withOpacity(.9),
                  // const Color.fromARGB(255, 111, 43, 163)
                ])),
          )
        ],
      ),
    );
  }

  btmNav() {
    return BottomAppBar(
      surfaceTintColor: Colors.transparent,
      color: Colors.transparent,
      height: 130,
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 25,
            width: sW(context),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 210, 255, 158).withOpacity(.3),
              const Color.fromARGB(255, 212, 255, 163).withOpacity(.5),
            ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (value) {},
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const Text(
                      "I don't need a papper bag",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        foregroundColor: Colors.green,
                      ),
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.green,
                        size: 15,
                      ),
                      label: const Text(
                        "Know more",
                        style: TextStyle(fontSize: 10),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "HOME",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      spaceWidth(3),
                      Text(
                        "- sri maruthi nillaya,j spiders builiuhuij",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(60, 20)),
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: Config.red,
                    size: 10,
                  ),
                  label: const Text(
                    "CHANGE ADDRESS",
                    style: TextStyle(fontSize: 12, color: Config.red),
                  ),
                ),
              ],
            ),
          ),
          // spaceHeight(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "₹ 501",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                spaceWidth(20),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Config.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("CONTINUE TO PAYMENT")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
