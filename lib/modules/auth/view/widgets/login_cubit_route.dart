import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/api_service.dart';
import '../../cubit/login_cubit.dart';
import '../screens/login_screen.dart';


class LoginCubitRoute extends StatelessWidget {
  const LoginCubitRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(ApiService()),
      child: const LoginScreen(),
    );
  }
}