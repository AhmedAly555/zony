import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/api_service.dart';
import '../../../services/get_res_pudos_service.dart';
import '../../../services/user_profile_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._apiService) : super(LoginInitial());

  final ApiService _apiService;

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoginLoading());

    try {
      final response = await _apiService.login(
        email.trim(),
        password.trim(),
        rememberMe,
      );

      // Extract role and message
      final role = response['user']['role'] as String;
      final message = response['message'] as String;


      // get courier profile information
      try {
        await UserService.instance.getProfile();
      } catch (err) {
        // log error or ignore as per old implementation which only showed a toast
      }

      // get pudo information
      try {
        await ResponsiblePudoService.instance.getResPudos();
      } catch (err) {
        // log error or ignore as per old implementation which only showed a toast
      }

      emit(LoginSuccess(
        role: role,
        message: message,
      ));
    } catch (e) {
      emit(LoginFailure(
        message: 'Login failed',
      ));
    }
  }
}
