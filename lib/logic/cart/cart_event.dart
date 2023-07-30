part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddEvent extends CartEvent {
  final Product pdt;
  final String qty;

  const CartAddEvent({required this.pdt, required this.qty});

  @override
  List<Object> get props => [pdt, qty];
}

class CartIncrementEvent extends CartEvent {
  final String id;
  final String qty;

  const CartIncrementEvent({required this.id, required this.qty});
   @override
  List<Object> get props => [id, qty];
}

class CartdecrementEvent extends CartEvent {
  final String id;
  final String qty;

  const CartdecrementEvent({required this.id, required this.qty});
   @override
  List<Object> get props => [id, qty];
}
