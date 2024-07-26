import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../features.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._postLogin, this._postRegister) : super(const AuthStateInit());

  final PostLogin _postLogin;
  final PostRegister _postRegister;
  Future<void> login(LoginParams params) async {
    try {
      emit(const AuthStateLoading());
      final data = await _postLogin.call(params);

      data.fold(
        (l) {
          if (l is ServerFailure) {
            emit(AuthStateFailed(error: l.message.toString()));
          }
        },
        (r) {
          emit(AuthStateSuccess());
        },
      );
    } catch (e) {
      emit(AuthStateFailed(error: e.toString()));
    }
  }

  Future<void> register(RegisterParams params) async {
    try {
      emit(const AuthStateLoading());
      final data = await _postRegister.call(params);

      data.fold(
        (l) {
          if (l is ServerFailure) {
            emit(AuthStateFailed(error: l.message.toString()));
          }
        },
        (r) => emit(AuthStateSuccess()),
      );
    } catch (e) {
      emit(AuthStateFailed(error: e.toString()));
    }
  }
}
