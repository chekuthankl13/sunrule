part of 'details_cubit.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoadError extends DetailsState {
  final String error;

  const DetailsLoadError({required this.error});

  @override
  List<Object> get props => [error];
}

class DetailsLoaded extends DetailsState {
  final List<Subcategories?> subcat;
  final List<Product?> pdt;

 const DetailsLoaded({required this.subcat, required this.pdt});

   @override
  List<Object> get props => [subcat,pdt];
}
