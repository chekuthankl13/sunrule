import 'package:sunrule/models/category/category_model.dart';
import 'package:sunrule/presentation/category/widget/widgets.dart';

class ApiRepository {
  fetchCategory() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      return {"status":"ok", "data":Categories.fromList(CategoryWidget.dummyAllCat)};
    } catch (e) {
      return {"status": "failed", "message": e.toString()};
    }
  }
}
