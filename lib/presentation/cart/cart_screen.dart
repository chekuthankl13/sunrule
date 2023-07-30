import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/logic/maincart/main_cart_cubit.dart';
import 'package:sunrule/models/cart/cart_model.dart';
import 'package:sunrule/presentation/widget/cart_empty.dart';
import 'package:sunrule/presentation/widget/error.dart';
import 'package:sunrule/presentation/widget/loading.dart';
import 'package:sunrule/utils/utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCartCubit, MainCartState>(
      builder: (context, state) {
        if (state is MainCartLoading) {
          return const Loading();
        }
        if (state is MainCartLoaded) {
          return StreamBuilder(
            stream: state.carts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const CartEmpty();
                } else {
                  return body(context, snapshot.data);
                }
              } else if (snapshot.hasError) {
                return ErrorPage(error: snapshot.error.toString());
              } else {
                return const Loading();
              }
            },
          );
        }
        return const Loading();
      },
    );
  }

  Scaffold body(BuildContext context, List<CartModel>? carts) {
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
      bottomNavigationBar: btmNav(carts!
          .map((e) => double.parse(e.totalAmount))
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2)),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 50,
                width: sW(context),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    gradient: LinearGradient(colors: [
                      Config.violet,
                      Config.red.withOpacity(.9),
                      // const Color.fromARGB(255, 111, 43, 163)
                    ])),
                child: const Text(
                  "Delivering in 20 mins",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 20,
                child: Image.asset(
                  "assets/images/food-delivery.png",
                  height: 40,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
          spaceHeight(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: sW(context),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 2)
                ]),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/free-shipping.png",
                  color: Colors.amber,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                spaceWidth(10),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yay! you've unlocked",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        "Free Delivery",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                spaceWidth(5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          color: Config.violet,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "1/3",
                        style: TextStyle(fontSize: 7, color: Colors.white),
                      ),
                    ),
                    spaceHeight(8),
                    Row(
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 ? Config.violet : Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
                spaceWidth(10)
              ],
            ),
          ),
          spaceHeight(15),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: carts.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = carts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: data.product.img.isNotEmpty
                            ? data.product.img
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1yq3IYQzQ8WsMghplkuU2HC2yTrgvXXipieWjlMnhaMn8WEW1qV-H8w0evI_HSMv2CNM&usqp=CAU",
                        height: 60,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                          child: Icon(
                            Icons.fastfood,
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      spaceWidth(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.product.txt,
                              style: const TextStyle(fontSize: 12),
                            ),
                            spaceHeight(2),
                            Row(
                              children: [
                                Text(
                                  data.product.qty,
                                  style: const TextStyle(
                                      fontSize: 9, color: Colors.grey),
                                ),
                                spaceWidth(5),
                                Text(
                                  "X",
                                  style: const TextStyle(
                                      fontSize: 9, color: Colors.green),
                                ),
                                spaceWidth(5),
                                Text(
                                  "₹ ${data.product.price}",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 70,
                        // padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Config.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            btn(
                                ic: CupertinoIcons.minus,
                                onPressed: () {
                                  context.read<MainCartCubit>().decrementCart(
                                      id: data.id,
                                      qty: data.qty,
                                      price: data.product.price);
                                }),
                            ValueListenableBuilder(
                              valueListenable: cartLoading,
                              builder: (context, value, child) =>
                                  value == data.id
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          data.qty,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                            ),
                            btn(
                                ic: CupertinoIcons.add,
                                onPressed: () async {
                                  context.read<MainCartCubit>().incrementCart(
                                      id: data.id,
                                      qty: data.qty,
                                      price: data.product.price);
                                }),
                          ],
                        ),
                      ),
                      spaceWidth(8),
                      SizedBox(
                        width: 60,
                        child: Text(
                          "₹ ${data.totalAmount}",
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/discount.png",
              color: Colors.green,
              height: 20,
              fit: BoxFit.contain,
            ),
            title: const Text(
              "Avail Offers/ Coupens",
              style: TextStyle(fontSize: 12),
            ),
            trailing: const Icon(
              Icons.arrow_right,
              size: 20,
              color: Config.red,
            ),
          )
        ],
      ),
    );
  }

  btmNav(String amt) {
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
                      const Text(
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
                Text(
                  "₹ $amt",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
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

  Widget btn({ic, void Function()? onPressed}) {
    return Expanded(
      child: IconButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(0),
            // maximumSize: const Size(20, 20),
            // fixedSize: const Size(20, 20),
            minimumSize: const Size(25, 20)),
        icon: Icon(
          ic,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
