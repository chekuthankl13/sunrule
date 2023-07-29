class CategoryDetail {
  final List<Subcategories?> subCategories;
  final List<Product?> products;

  CategoryDetail({required this.subCategories, required this.products});

  factory CategoryDetail.fromJson(Map<String, dynamic> json) =>
      CategoryDetail(
        subCategories:(json['sub_cat'] as List).isEmpty?[]: List<Subcategories>.from((json['sub_cat'] as List).map((e) => Subcategories.fromJson(e))),
       products:(json['products'] as List).isEmpty?[]:  List<Product>.from((json['products'] as List).map((e) => Product.fromJson(e)))
       );
}

class Subcategories {
  final String catId;
  final String id;
  final String txt;
  final String img;

  Subcategories(
      {required this.catId,
      required this.id,
      required this.txt,
      required this.img});

  factory Subcategories.fromJson(Map<String, dynamic> json) => Subcategories(
      catId: json['category_id'],
      id: json['id'],
      txt: json['txt'],
      img: json['img']);
}

class Product {
  final String catId;
  final String subCatId;
  final String id;
  final String txt;
  final String img;
  final String price;
  final String offPrice;
  final String offPercen;

  Product(
      {required this.catId,
      required this.subCatId,
      required this.id,
      required this.txt,
      required this.img,
      required this.price,
      required this.offPrice,
      required this.offPercen});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      catId: json['category_id'],
      subCatId: json['subcategory_id'],
      id: json['id'],
      txt: json['txt'],
      img: json['img'],
      price: json['price'],
      offPrice: json['off_price'],
      offPercen: json['off_percen']);
}
