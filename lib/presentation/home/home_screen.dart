import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/logic/category/category_cubit.dart';
import 'package:sunrule/presentation/cart/cart_screen.dart';
import 'package:sunrule/presentation/category/category.dart';
import 'package:sunrule/presentation/home/fresh_fiesta.dart';
import 'package:sunrule/presentation/home/zepto.dart';
import 'package:sunrule/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // navbar index
  ValueNotifier<int> navIndex = ValueNotifier(1);

  // pages

  var pages = [
    const Zepto(),
    BlocProvider(
      create: (context) =>
          CategoryCubit(apiRepository: context.read<ApiRepository>())
            ..fetchCat(),
      child: const CategoryPage(),
    ),
    const FreshFiesta(),
    const CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: btmNav(),
        body: ValueListenableBuilder(
          valueListenable: navIndex,
          builder: (context, value, child) => pages[value],
        ));
  }

  /// bottom navbar

  btmNav() {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: kTextTabBarHeight + 20,
      color: Colors.white,
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      child: ValueListenableBuilder(
        valueListenable: navIndex,
        builder: (context, value, child) => Row(
          children: [
            navTile(
                ic: CupertinoIcons.home,
                ic2: CupertinoIcons.house_fill,
                txt: "Zepto",
                index: 0),
            navTile(
                ic: Icons.apps_outlined,
                ic2: Icons.apps_sharp,
                txt: "Categories",
                index: 1),
            navTile(
                ic: Icons.fastfood_outlined,
                ic2: Icons.fastfood_sharp,
                txt: "Fresh Fiesta",
                index: 2),
            navTile(
                ic: CupertinoIcons.cart,
                ic2: CupertinoIcons.cart_fill,
                txt: "Cart",
                index: 3)
          ],
        ),
      ),
    );
  }

  Widget navTile({index, txt, ic, ic2}) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          navIndex.value = index;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            navIndex.value == index
                ? Icon(ic2, size: 25, color: Config.violet2)
                : Icon(ic, size: 20, color: Colors.grey),
            spaceHeight(2),
            Text(
              txt,
              style: navIndex.value == index
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Config.violet2)
                  : const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  /** end  */
}
