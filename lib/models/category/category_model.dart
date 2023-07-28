class Categories {
  final List<CategoryModel> category;

  Categories({required this.category});

  factory Categories.fromList(List<dynamic> list) => Categories(
        category: List<CategoryModel>.from(
          list.map((e) => CategoryModel.fromJson(e)),
        ),
      );
}

class CategoryModel {
  final String txt;
  final String id;
  final String img;

  CategoryModel({required this.txt, required this.id, required this.img});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(txt: json['txt'], id: json['id'], img: json['img']);
}
