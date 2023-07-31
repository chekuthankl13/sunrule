part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoadError extends AuthState {
  final String error;

  const AuthLoadError({required this.error});
  @override
  List<Object> get props => [error];
}

class AuthLoadSuccess extends AuthState {
  final UserHiveModel data;

  const AuthLoadSuccess({required this.data});
    @override
  List<Object> get props => [data];
}
