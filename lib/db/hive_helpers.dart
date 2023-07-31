import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunrule/db/hivemodels/user_hive_model.dart';

class HiveHelpers {
  static const user = 'user';

  static Box<UserHiveModel> userBox = Hive.box<UserHiveModel>(user);

  
 //// add 
 
 setUser({required UserHiveModel user}) async {
    await userBox.add(user);
    log("user credentials inserted to db", name: "hive helpers");
  }

  UserHiveModel? getCredentials() {
    return userBox.get(0);
  }

  clearUserBox() async {
    await userBox.clear();
    log("user credentials cleared from db", name: "hive helpers");
  }

}