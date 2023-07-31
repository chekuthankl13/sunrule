part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadError extends CategoryState {
  final String error;

  const CategoryLoadError({required this.error});
  @override
  List<Object> get props => [error];
}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final List<CategoryModel> topcategories;

  final List<CategoryModel> twoCategories;


 const CategoryLoaded({required this.categories,required this.twoCategories,required this.topcategories});

  @override
  List<Object> get props => [categories,twoCategories,topcategories];
}
