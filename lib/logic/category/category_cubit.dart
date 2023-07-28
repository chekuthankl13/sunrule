import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrule/models/category/category_model.dart';
import 'package:sunrule/repository/api_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ApiRepository apiRepository;
  CategoryCubit({required this.apiRepository}) : super(CategoryInitial());

  fetchCat() async {
    try {
      emit(CategoryLoading());

      var res = await apiRepository.fetchCategory();
      if (res['status'] == "ok") {
        var data = res['data'] as Categories;
        var twoCat = data.category.sublist(0, 2);
        data.category.removeRange(0, 2);
        emit(CategoryLoaded(categories: data.category,twoCategories: twoCat));
      } else {
        emit(CategoryLoadError(error: res['message']));
      }
    } catch (e) {
      emit(CategoryLoadError(error: e.toString()));
    }
  }
}
