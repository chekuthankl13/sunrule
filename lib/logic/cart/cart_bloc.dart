import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sunrule/models/cart/cart_model.dart';
import 'package:sunrule/models/category/category_detail_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

ValueNotifier<String?> loading = ValueNotifier(null);

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cart: [])) {
    on<CartEvent>((event, emit) {});
    on<CartAddEvent>(_cartAddEvent);
    on<CartdecrementEvent>(_cartDecrementEvent);
    on<CartIncrementEvent>(_cartIncrementEvent);
  }

  FutureOr<void> _cartAddEvent(CartAddEvent event, Emitter<CartState> emit) {
    try {
      List<CartModel?> currentList = List.from(state.cart);
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
          totalAmount: (double.parse(total) * int.parse(event.qty)).toString());

      emit(state.copyWith(cart: [...currentList, cart]));
    } catch (e) {
      log(e.toString(), name: "add event error");
    }
  }

  FutureOr<void> _cartDecrementEvent(
      CartdecrementEvent event, Emitter<CartState> emit) async {
    try {
      loading.value = event.id;
      await Future.delayed(const Duration(seconds: 1));
      List<CartModel?> currentList = List.from(state.cart);
      CartModel? productToUpdate =
          currentList.firstWhere((element) => element!.product.id == event.id);
      if (productToUpdate != null) {
        if (productToUpdate.qty == "1") {
          var newState = currentList.removeWhere(
              (element) => element!.product.id == productToUpdate.product.id);
          emit(state.copyWith(cart: [...currentList]));
        } else {
          productToUpdate.qty = (int.parse(productToUpdate.qty) - 1).toString();

          // Emit the updated state with the modified cart list
          emit(state.copyWith(cart: [...currentList, productToUpdate]));
        }
      }
      loading.value = null;
    } catch (e) {
      log(e.toString(), name: "increment event error");
      loading.value = null;
    }
  }

  FutureOr<void> _cartIncrementEvent(
      CartIncrementEvent event, Emitter<CartState> emit) async {
    try {
      loading.value = event.id;
      await Future.delayed(const Duration(seconds: 1));
      List<CartModel?> currentList = List.from(state.cart);

      // Find the product in the currentList by its id
      CartModel? productToUpdate =
          currentList.firstWhere((element) => element!.product.id == event.id);

      // Check if the product was found before updating the quantity
      if (productToUpdate != null) {
        // Increment the quantity of the product
        productToUpdate.qty = (int.parse(productToUpdate.qty) + 1).toString();

        // Emit the updated state with the modified cart list
        emit(state.copyWith(cart: [...currentList, productToUpdate]));
      }
      loading.value = null;
    } catch (e) {
      log(e.toString(), name: "increment event error");
      loading.value = null;
    }
  }
}
