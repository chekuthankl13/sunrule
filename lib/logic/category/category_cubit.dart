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
        var data = res['data'] as List<CategoryModel>;
        var twoCat = data.sublist(0, 2);
        var topCat = data.sublist(data.length - 2, data.length);

        data.removeRange(0, 2);
        emit(CategoryLoaded(
            categories: data, twoCategories: twoCat, topcategories: topCat));
      } else {
        emit(CategoryLoadError(error: res['message']));
      }
    } catch (e) {
      emit(CategoryLoadError(error: e.toString()));
    }
  }
}
