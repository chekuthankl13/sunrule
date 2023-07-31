import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/db/hive_helpers.dart';
import 'package:sunrule/models/cart/cart_model.dart';
import 'package:sunrule/models/category/category_detail_model.dart';
import 'package:sunrule/repository/api_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

ValueNotifier<String?> loading = ValueNotifier(null);
ValueNotifier<String?> loading2 = ValueNotifier(null);

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiRepository apiRepository;
  CartBloc({required this.apiRepository}) : super(const CartState(cart: [])) {
    on<CartEvent>((event, emit) {});
    on<CartAddEvent>(_cartAddEvent);
    on<CartdecrementEvent>(_cartDecrementEvent);
    on<CartIncrementEvent>(_cartIncrementEvent);
    on<CartLoadEvent>(_cartLoadEvent);
  }

  FutureOr<void> _cartAddEvent(
      CartAddEvent event, Emitter<CartState> emit) async {
    try {
      loading.value = event.pdt.id;
      CartPdt cartPdt = CartPdt(
          catId: event.pdt.catId,
          subCatId: event.pdt.subCatId,
          id: event.pdt.id,
          txt: event.pdt.txt,
          img: event.pdt.img,
          price:
              event.pdt.offPrice.isEmpty ? event.pdt.price : event.pdt.offPrice,
          qty: event.pdt.qty);
      var total =
          event.pdt.offPrice.isEmpty ? event.pdt.price : event.pdt.offPrice;

      CartModel cart = CartModel(
          product: cartPdt,
          qty: event.qty,
          id: "",
          totalAmount: (double.parse(total) * int.parse(event.qty)).toString());

      var res = await apiRepository.addToCart(cart: cart,userId: HiveHelpers().getCredentials()!.id);

      if (res['status'] == "200") {
        cart.id = res['id'];
        List<CartModel?> currentList = List.from(state.cart);

        emit(state.copyWith(cart: [...currentList, cart]));
        loading.value = null;
      } else {
        log(res['message'], name: "add error");
        loading.value = null;
      }
    } catch (e) {
      log(e.toString(), name: "add event error");
      loading.value = null;
    }
  }

  FutureOr<void> _cartDecrementEvent(
      CartdecrementEvent event, Emitter<CartState> emit) async {
    try {
      loading.value = event.id;

      List<CartModel?> currentList = List.from(state.cart);
      CartModel? productToUpdate =
          currentList.firstWhere((element) => element!.product.id == event.id);
      if (productToUpdate != null) {
        if (productToUpdate.qty == "1") {
          var res = await apiRepository.deleteCart(id: productToUpdate.id,userId: HiveHelpers().getCredentials()!.id);
          if (res['status'] == "ok") {
            currentList.removeWhere(
                (element) => element!.product.id == productToUpdate.product.id);
            emit(state.copyWith(cart: [
              ...currentList,
            ]));
            loading.value = null;
          } else {
            log(res['message'], name: "error on delete");
            loading.value = null;
          }
        } else {
          productToUpdate.qty = (int.parse(productToUpdate.qty) - 1).toString();
          productToUpdate.totalAmount =
              ((double.parse(productToUpdate.product.price) *
                      int.parse(productToUpdate.qty)))
                  .toString();

          var res = await apiRepository.updateCart(
            userId: HiveHelpers().getCredentials()!.id,
              id: productToUpdate.id,
              qty: productToUpdate.qty,
              price: ((double.parse(productToUpdate.product.price) *
                      int.parse(productToUpdate.qty)))
                  .toString());
          if (res['status'] == "ok") {
            // currentList
            //     .removeWhere((element) => element!.id == productToUpdate.id);
            // emit(state.copyWith(
            //     cart: [...currentList, productToUpdate])); //[...currentList,]

            var snap = res['data'] as List<CartModel>;
            emit(state.copyWith(cart: [...snap]));
            loading.value = null;
          } else {
            log(res['message'], name: "error on update");
            loading.value = null;
          }
        }
      }
    } catch (e) {
      log(e.toString(), name: "decrement event error");
      loading.value = null;
    }
  }

  FutureOr<void> _cartIncrementEvent(
      CartIncrementEvent event, Emitter<CartState> emit) async {
    try {
      loading.value = event.id;

      List<CartModel?> currentList = List.from(state.cart);

      CartModel? productToUpdate =
          currentList.firstWhere((element) => element!.product.id == event.id);

      if (productToUpdate != null) {
        int newQty = int.parse(productToUpdate.qty) + 1;
        double newTotalAmount =
            double.parse(productToUpdate.product.price) * newQty;

        var res = await apiRepository.updateCart(
          userId: HiveHelpers().getCredentials()!.id,
            id: productToUpdate.id,
            qty: newQty.toString(),
            price: newTotalAmount.toString());
        if (res['status'] == "ok") {
          // productToUpdate.qty = newQty.toString();
          // productToUpdate.totalAmount = newTotalAmount.toString();
          // log(currentList.map((e) => e).toString(), name: "current list");

          var snap = res['data'] as List<CartModel>;

          emit(state.copyWith(cart: [...snap]));

          log("₹ ${state.cart.map((e) => double.parse(e!.totalAmount)).toList().reduce((value, element) => value + element).toString()}",
              name: "total amount");
          loading.value = null;
        } else {
          log(res['message'], name: "update cart error");
          loading.value = null;
        }
      }
    } catch (e) {
      log(e.toString(), name: "increment event error");
      loading.value = null;
    }
  }

  FutureOr<void> _cartLoadEvent(
      CartLoadEvent event, Emitter<CartState> emit) async {
    try {
      // List<CartModel?> currentList = List.from(state.cart);
      var res = await apiRepository.intialLoadCart(userId: HiveHelpers().getCredentials()!.id);

      if (res['status'] == "ok") {
        var data = res['data'] as List<CartModel>;
        emit(state.copyWith(cart: data));
      }
    } catch (e) {
      log(e.toString(), name: "cart load error");
    }
  }
}
