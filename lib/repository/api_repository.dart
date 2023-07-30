import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/models/cart/cart_model.dart';
import 'package:sunrule/models/category/category_detail_model.dart';
import 'package:sunrule/models/category/category_model.dart';
import 'package:sunrule/presentation/category/widget/widgets.dart';

class ApiRepository {
  /// firestore refs

  var categoryCollection =
      FirebaseFirestore.instance.collection(Config.categoryRef);

  var productCollection =
      FirebaseFirestore.instance.collection(Config.productRef);

  var subCategoryCollection =
      FirebaseFirestore.instance.collection(Config.subCategoryRef);

  var userCollection = FirebaseFirestore.instance.collection(Config.userRef);

  /////////

  Future fetchCategory() async {
    try {
      //  var snap = categoryCollection.snapshots();
      //  var res = snap.map((event) =>
      //  event.docs.map((e) => CategoryModel.fromJson(e.data())).toList()
      //  );

      var snap = await categoryCollection.get();
      var res = snap.docs.map((e) => CategoryModel.fromJson(e.data())).toList();

      return {"status": "ok", "data": res};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

  fetchCategoryDetails({required id}) async {
    try {
      var subCatSnap = await subCategoryCollection
          .where('category_id', isEqualTo: id)
          .get()
          .then((value) =>
              value.docs.map((e) => Subcategories.fromJson(e.data())).toList());

      var pdtSnap = await productCollection
          .where("category_id", isEqualTo: id)
          .get()
          .then((value) =>
              value.docs.map((e) => Product.fromJson(e.data())).toList());

      return {
        "status": "ok",
        "data": {"sub_cat": subCatSnap, "products": pdtSnap}
      };
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

///////// cart ///////////

  /// add to cart

  addToCart({required CartModel cart}) async {
    try {
      var cartSnapId = await userCollection
          .doc(Config.userDocu)
          .collection(Config.cartRef)
          .add(cart.toJson());
      await userCollection
          .doc(Config.userDocu)
          .collection(Config.cartRef)
          .doc(cartSnapId.id)
          .update({"id": cartSnapId.id});

      return {"status": "200", "id": cartSnapId.id};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

//// update

  updateCart({qty, price, id}) async {
    try {
      await userCollection
          .doc(Config.userDocu)
          .collection(Config.cartRef)
          .doc(id)
          .update({"qty": qty, "total_amount": price});
      return {"status": "ok"};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

  /// delete

  deleteCart({id}) async {
    try {
      await userCollection
          .doc(Config.userDocu)
          .collection(Config.cartRef)
          .doc(id)
          .delete();
      return {"status": "ok"};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

  // inital load

  intialLoadCart() async {
    try {
      var snap = await userCollection
          .doc(Config.userDocu)
          .collection(Config.cartRef)
          .get()
          .then((value) =>
              value.docs.map((e) => CartModel.fromJson(e.data())).toList());
      return {"status": "ok", "data": snap};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }
}
