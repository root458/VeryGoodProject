import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_reads_app/models/_index.dart';
import 'package:good_reads_app/services/_index.dart';
import 'package:logger/logger.dart';

part 'google_sign_in_state.dart';
part 'google_sign_in_cubit.freezed.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit({
    required AuthService authService,
  }) : super(const GoogleSignInState.initial()) {
    _authService = authService;
  }

  late AuthService _authService;

  Future<void> signInWithGoogle() async {
    emit(const GoogleSignInState.loading());
    try {
      final _result = await _authService.signInWithGoogle();

      emit(GoogleSignInState.loaded(_result));
    } on Failure catch (err) {
      emit(GoogleSignInState.error(['Failed', err.message]));
    } catch (e) {
      Logger().e(e);
      emit(const GoogleSignInState.error(['An unexepected error occured']));
    }
  }
}