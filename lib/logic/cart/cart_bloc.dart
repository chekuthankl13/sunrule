import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrule/models/category/category_detail_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
