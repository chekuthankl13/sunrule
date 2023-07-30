import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sunrule/config/config.dart';
import 'package:sunrule/repository/api_repository.dart';

import '../../models/cart/cart_model.dart';

part 'main_cart_state.dart';

ValueNotifier<String?> cartLoading = ValueNotifier(null);

class MainCartCubit extends Cubit<MainCartState> {
  final ApiRepository apiRepository;
  MainCartCubit({required this.apiRepository}) : super(MainCartInitial());

  fetchCart() async {
    try {
      emit(MainCartLoading());
      var snap = await apiRepository.getCartStreams(userRef: Config.userDocu);
      if (snap['status'] == "ok") {
        var cartStream = snap["data"] as Stream<List<CartModel>>;
        emit(MainCartLoaded(carts: cartStream));
      }
    } catch (e) {
      log(e.toString(), name: "stream fetch error");
    }
  }

  incrementCart({id, qty, price}) async {
    try {
      cartLoading.value = id;
      String newQty = (int.parse(qty) + 1).toString();
      String newPrice =
          (int.parse(newQty) * double.parse(price)).toStringAsFixed(2);
      await apiRepository.updateCart(id: id, price: newPrice, qty: newQty);
      cartLoading.value = null;
    } catch (e) {
      log(e.toString(), name: "error on stream increment");
      cartLoading.value = null;
    }
  }

  decrementCart({id, qty, price}) async {
    try {
      if (qty == "1") {
        cartLoading.value = id;
        await apiRepository.deleteCart(id: id);
        cartLoading.value = null;
      } else {
        cartLoading.value = id;
        String newQty = (int.parse(qty) - 1).toString();
        String newPrice =
            (int.parse(newQty) * double.parse(price)).toStringAsFixed(2);
        await apiRepository.updateCart(id: id, price: newPrice, qty: newQty);
        cartLoading.value = null;
      }
    } catch (e) {
      log(e.toString(), name: "error on decrement stream");
    }
  }
}
