part of 'main_cart_cubit.dart';

abstract class MainCartState extends Equatable {
  const MainCartState();

  @override
  List<Object> get props => [];
}

class MainCartInitial extends MainCartState {}

class MainCartLoading extends MainCartState {}

class MainCartLoaded extends MainCartState {
  final Stream<List<CartModel>> carts;

const  MainCartLoaded({required this.carts});

@override
  List<Object> get props => [carts];
}
