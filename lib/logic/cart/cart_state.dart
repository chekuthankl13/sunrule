part of 'cart_bloc.dart';

 class CartState extends Equatable {
  final List<CartModel?> cart;
  const CartState({this.cart = const []});

  @override
  List<Object> get props => [cart];
  
    CartState copyWith({
    required final List<CartModel?> cart
  }) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }

}

// class CartInitial extends CartState {}
