import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/models/category/category_detail_model.dart';
import 'package:sunrule/presentation/widget/empty.dart';
import 'package:sunrule/presentation/widget/error.dart';
import 'package:sunrule/presentation/widget/loading.dart';
import 'package:sunrule/utils/utils.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String title;
  const CategoryDetailScreen({required this.title, super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  ValueNotifier<List<Product?>> products = ValueNotifier([]);
  ValueNotifier<int> subcategoryValue = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return const Loading();
        }

        if (state is DetailsLoadError) {
          return ErrorPage(error: state.error);
        }

        if (state is DetailsLoaded) {
          products.value = state.pdt
              .where((element) => element!.subCatId == state.subcat[0]!.id)
              .toList();
          return state.subcat.isEmpty || state.pdt.isEmpty
              ? const Empty()
              : body(state);
        }

        return const Loading();
      },
    );
  }

  Scaffold body(DetailsLoaded state) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Config.shade),
          ),
          leading: IconButton(
              onPressed: () {
                navigatorKey.currentState!.pop();
              },
              icon: const Icon(CupertinoIcons.back)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.search),
            )
          ],
        ),
        body: SizedBox(
          height: sH(context),
          width: sW(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: sH(context),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: ValueListenableBuilder(
                    valueListenable: subcategoryValue,
                    builder: (context, value, child) => ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: state.subcat.length,
                      itemBuilder: (context, index) {
                        var data = state.subcat[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              subcategoryValue.value = index;
                              print("clicked!!");
                              products.value = state.pdt
                                  .where((e) => e!.subCatId == data.id)
                                  .toList();
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 60,
                                      decoration: value == index
                                          ? BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Config.bxClr1.withOpacity(.2),
                                                Config.bxClr1.withOpacity(.5),
                                              ]),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: value == index
                                                ? null
                                                : Config.bxClr1
                                                    .withOpacity(.2)),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: data!.img.isNotEmpty
                                                ? data.img
                                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1yq3IYQzQ8WsMghplkuU2HC2yTrgvXXipieWjlMnhaMn8WEW1qV-H8w0evI_HSMv2CNM&usqp=CAU",
                                            height: 40,
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Icon(
                                                Icons.fastfood,
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                spaceHeight(3),
                                Text(
                                  data.txt,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: value == index
                                      ? const TextStyle(
                                          fontSize: 14,
                                          color: Config.violet2,
                                          fontWeight: FontWeight.w500)
                                      : const TextStyle(
                                          fontSize: 12,
                                          color: Config.shade,
                                          fontWeight: FontWeight.w400),
                                ),
                                spaceHeight(2)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        spaceHeight(10),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image.asset(
                        //     "assets/images/banner.jpg",
                        //     height: 140,
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/banner.jpg",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const Positioned(
                              top: 20,
                              right: 5,
                              child: Text(
                                "Fresh vegetables & fruits",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 10,
                              child: Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: const Text(
                                  "Explore",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Config.violet,
                                      fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                        spaceHeight(15),
                        ValueListenableBuilder(
                          valueListenable: products,
                          builder: (context, value, child) {
                            return GridView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 220,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 4),
                              itemBuilder: (context, index) {
                                var data = value[index];
                                return Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 1,
                                  surfaceTintColor: Colors.transparent,
                                  // shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: data!.img.isNotEmpty
                                                  ? data.img
                                                  : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1yq3IYQzQ8WsMghplkuU2HC2yTrgvXXipieWjlMnhaMn8WEW1qV-H8w0evI_HSMv2CNM&usqp=CAU",
                                              height: 120,
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  const Icon(
                                                Icons.fastfood,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          data!.offPercen.isEmpty
                                              ? const SizedBox()
                                              : Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    height: 20,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                183,
                                                                64,
                                                                199)
                                                            .withOpacity(.9)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "${data.offPercen} % Off",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data.txt,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Config.shade,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceHeight(4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        child: Text(
                                          data.qty,
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ),
                                      spaceHeight(3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              data.offPrice.isEmpty
                                                  ? const SizedBox()
                                                  : Text(
                                                      "₹ ${data.price}",
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey),
                                                    ),
                                              spaceHeight(3),
                                              Text(
                                                "₹ ${data.offPrice.isEmpty ? data.price : data.offPrice}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.red,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  minimumSize:
                                                      const Size(50, 30),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  side: BorderSide(
                                                      color: Colors.red,
                                                      width: 1)),
                                              child: const Text(
                                                "Add",
                                                style: TextStyle(fontSize: 12),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
