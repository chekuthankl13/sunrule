import 'package:equatable/equatable.dart';
import 'package:sunrule/logic/bloc_export.dart';
import 'package:sunrule/models/category/category_detail_model.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final ApiRepository apiRepository;
  DetailsCubit({required this.apiRepository}) : super(DetailsInitial());

  loadDetails({required id}) async {
    try {
      emit(DetailsLoading());
      var res = await apiRepository.fetchCategoryDetails(id: id);
      if (res['status'] == 'ok') {
        var data = res['data'] as Map<String, dynamic>;
        var subCat = data['sub_cat'] as List<Subcategories>;
        var pdts = data['products'] as List<Product>;
        emit(DetailsLoaded(subcat: subCat, pdt: pdts));
      } else {
        emit(DetailsLoadError(error: res['message']));
      }
    } catch (e) {
      emit(DetailsLoadError(error: e.toString()));
    }
  }
}
