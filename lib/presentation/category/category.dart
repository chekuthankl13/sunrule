import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/category/category_detail_screen.dart';
import 'package:sunrule/presentation/widget/error.dart';
import 'package:sunrule/presentation/widget/loading.dart';
import 'package:sunrule/utils/utils.dart';
import 'dart:math' as math;

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Loading();
        }
        if (state is CategoryLoadError) {
          return ErrorPage(error: state.error);
        }
        if (state is CategoryLoaded) {
          return body(state);
        }
        return const Loading();
      },
    );
  }

  Scaffold body(CategoryLoaded state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.violet,
        centerTitle: true,
        title: const Text(
          "All Categories",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
        ),
        actions: [
          const Icon(
            CupertinoIcons.search,
            color: Colors.white,
          ),
          spaceWidth(10)
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        physics: const ScrollPhysics(),
        children: [
          spaceHeight(15),
          // title
          title(txt: "Explore New Categories"),
          spaceHeight(15),

          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 120,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      Color((math.Random().nextDouble() * 0xFF2196F3).toInt())
                          .withOpacity(.2),
                ),
              ),
            ),
          ),

          ////  categories
          spaceHeight(15),
          title(txt: "Explore By Categories"),
          spaceHeight(15),

          /// two catg

          SizedBox(
            height: 140,
            child: Row(
              children: List.generate(
                state.twoCategories.length,
                (index) => cat(
                    txt: state.twoCategories[index].txt,
                    id: state.twoCategories[index].id,
                    img: state.twoCategories[index].img),
              ).toList(),
            ),
          ),
          /*** end ***/
          spaceHeight(15),
          GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: state.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 140,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              var data = state.categories[index];
              return GestureDetector(
                onTap: () {
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => DetailsCubit(
                            apiRepository: context.read<ApiRepository>())
                          ..loadDetails(id: data.id),
                        child: const CategoryDetailScreen(),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 1)
                      ]
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Config.bxClr1.withOpacity(.2),
                      //     Config.bxClr2.withOpacity(.2),
                      //   ],
                      // ),
                      ),
                  child: Column(
                    children: [
                      spaceHeight(5),
                      Text(
                        data.txt.toString(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Config.violet2),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          spaceHeight(15)
        ],
      ),
    );
  }

  Expanded cat({txt, img, id}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) =>
                    DetailsCubit(apiRepository: context.read<ApiRepository>())
                      ..loadDetails(id: id),
                child: const CategoryDetailScreen(),
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1)]
              // gradient: LinearGradient(
              //   colors: [
              //     Config.bxClr1.withOpacity(.5),
              //     Config.bxClr2.withOpacity(.5),
              //   ],
              // ),
              ),
          child: Column(
            children: [
              spaceHeight(8),
              Text(
                txt,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Config.violet2),
              )
            ],
          ),
        ),
      ),
    );
  }

///// widgets

  Text title({txt}) {
    return Text(
      txt,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Config.shade),
    );
  }
}
