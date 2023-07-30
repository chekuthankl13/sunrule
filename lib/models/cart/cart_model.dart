class CartModel {
  final CartPdt product;
  String qty;
  final String totalAmount;
   String id;

  CartModel(
      {required this.product, required this.qty, required this.totalAmount,required this.id});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      product: CartPdt.fromJson(json['product']),
      id: json['id'],
      qty: json['qty'],
      totalAmount: json['total_amount']);

  Map<String, dynamic> toJson() =>
      {"product": product.toJson(), "qty": qty, "total_amount": totalAmount,"id":id};
}

class CartPdt {
  final String catId;
  final String subCatId;
  final String id;
  final String txt;
  final String img;
  final String price;
  final String qty;

  CartPdt(
      {required this.catId,
      required this.subCatId,
      required this.id,
      required this.txt,
      required this.img,
      required this.price,
      required this.qty});

  factory CartPdt.fromJson(Map<String, dynamic> json) => CartPdt(
        catId: json['category_id'],
        subCatId: json['subcategory_id'],
        id: json['id'],
        txt: json['txt'],
        img: json['img'],
        qty: json['qty'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        "category_id": catId,
        "subcategory_id": subCatId,
        "id": id,
        "txt": txt,
        "img": img,
        "qty": qty,
        "price": price
      };
}
