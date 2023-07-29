part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddEvent extends CartEvent {
  final Product pdt;
  final String qty;

  const CartAddEvent({required this.pdt,required this.qty});

  @override
  List<Object> get props => [pdt,qty];
}
