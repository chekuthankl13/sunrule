import 'package:hive/hive.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 0)
class UserHiveModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String psw;
  @HiveField(4)
  final String address;

  UserHiveModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.psw,
      required this.address});
}
