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

  addToCart({required CartModel cart,required userId}) async {
    try {
      var cartSnapId = await userCollection
          .doc(userId)
          .collection(Config.cartRef)
          .add(cart.toJson());
      await userCollection
          .doc(userId)
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

  updateCart({qty, price, id,required userId}) async {
    try {
      await userCollection
          .doc(userId)
          .collection(Config.cartRef)
          .doc(id)
          .update({"qty": qty, "total_amount": price});
      var snap = await userCollection
          .doc(userId)
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

  /// delete

  deleteCart({id,required userId}) async {
    try {
      await userCollection
          .doc(userId)
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

  intialLoadCart({required userId}) async {
    try {
      var snap = await userCollection
          .doc(userId)
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

////// cartStream

  getCartStreams({required userRef}) async {
    try {
      var snap =
          userCollection.doc(userRef).collection(Config.cartRef).snapshots();
      var res = snap.map((event) =>
          event.docs.map((e) => CartModel.fromJson(e.data())).toList());
      return {"status": "ok", "data": res};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

  /// user register

  registerUser(
      {required email, required psw, required name, required address}) async {
    try {
      var snap = await userCollection.add({
        "name": name,
        "email": email,
        "address": address,
        "password": psw,
        "id": ""
      });
      await userCollection.doc(snap.id).update({"id": snap.id});
      var data = await userCollection.doc(snap.id).get();
      return {"status": "ok", "data": data};
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

  loginUser({required email, required psw}) async {
    try {
      var snap = await userCollection
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: psw)
          .get();
      if (snap.docs.isNotEmpty) {
        return {"status": "ok", "data": snap.docs[0]};
      } else {
        return {"status": "failed", "message": "Invalid credentials.."};
      }
    } on FirebaseException catch (e) {
      return {"status": "failed", "message": e.toString()};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }
}
