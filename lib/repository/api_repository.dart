import 'package:sunrule/models/category/category_detail_model.dart';
import 'package:sunrule/models/category/category_model.dart';
import 'package:sunrule/presentation/category/widget/widgets.dart';

class ApiRepository {
  fetchCategory() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      return {
        "status": "ok",
        "data": Categories.fromList(CategoryWidget.dummyAllCat)
      };
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }

  fetchCategoryDetails({required id}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      var subCat = CategoryWidget.dummySubCat
          .where((e) => e['category_id'] == id)
          .toList();
      var pdt =
          CategoryWidget.dummyPdt.where((e) => e['category_id'] == id).toList();
      return {
        "status":"ok",
        "data":CategoryDetail.fromJson({"sub_cat":subCat,"products":pdt})
      };
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }
}
