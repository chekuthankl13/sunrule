import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/presentation/widget/error.dart';
import 'package:sunrule/presentation/widget/loading.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
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
          return body(state);
        }

        return const Loading();
      },
    );
  }

  Scaffold body(DetailsLoaded state) {
    return Scaffold(
          body: Center(child: Text("data loaded"),),
        );
  }
}
