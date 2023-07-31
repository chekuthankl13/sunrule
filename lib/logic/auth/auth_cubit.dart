import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrule/db/hive_helpers.dart';
import 'package:sunrule/db/hivemodels/user_hive_model.dart';
import 'package:sunrule/repository/api_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiRepository apiRepository;
  AuthCubit({required this.apiRepository}) : super(AuthInitial());

  registerUser({email, psw, name, address}) async {
    try {
      emit(AuthLoading());
      var res = await apiRepository.registerUser(
          email: email, psw: psw, name: name, address: address);
      if (res['status'] == "ok") {
        var data = res['data'] as DocumentSnapshot<Map<String, dynamic>>;
        UserHiveModel user = UserHiveModel(
            id: data['id'],
            name: data['name'],
            email: data['email'],
            psw: data['password'],
            address: data['address']);
        await HiveHelpers().setUser(user: user);
        emit(AuthLoadSuccess(data: user));
      } else {
        emit(AuthLoadError(error: res['message']));
      }
    } catch (e) {
      emit(AuthLoadError(error: e.toString()));
    }
  }

  loginUser({email, psw}) async {
    try {
      emit(AuthLoading());
      var res = await apiRepository.loginUser(email: email, psw: psw);
      if (res['status'] == "ok") {
        var data = res['data'] as DocumentSnapshot<Map<String, dynamic>>;
        UserHiveModel user = UserHiveModel(
            id: data['id'],
            name: data['name'],
            email: data['email'],
            psw: data['password'],
            address: data['address']);
             await HiveHelpers().setUser(user: user);
        emit(AuthLoadSuccess(data: user));
      } else {
        emit(AuthLoadError(error: res['message']));
        
      }
    } catch (e) {
      emit(AuthLoadError(error: e.toString()));
    }
  }
}
