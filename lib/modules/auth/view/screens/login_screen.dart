import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zony/generated/l10n.dart';


import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../services/size_config.dart';
import '../../../../views/widgets/custom_container_icon.widget.dart';
import '../../../../views/widgets/default_text_filed.dart';
import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../views/widgets/toasts.dart';
import '../../../couriers/views/screens/main_home/screen/courier_main_home_screen.dart';

import '../../../podu/views/screens/main_home/screen/podu_main_home_screen.dart';
import '../../../../views/widgets/default_button.widget.dart';
import '../../cubit/login_cubit.dart';
import '../../cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return TemplateAppScaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            showErrorToast(message: state.message);
            //debugPrint("❌ Error in login: ${state.message}");
          }

          if (state is LoginSuccess) {
            showCorrectToast(message: state.message);

            if (state.role == "courier") {
              AppNavigator.replaceWith(
                context,
                () =>  const CourierMainHomeScreen(),
              );
            } else if (state.role == "responsible") {
              AppNavigator.replaceWith(
                context,
                () => const PoduMainHomeScreen(),
              );
            }
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            //const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 16),
              child: Row(
                children: [
                  const CustomContainerIcon(svgPath: 'assets/svgs/svg_language.svg',),
                  const Spacer(),

                  Text(
                    S.of(context).logIn,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 25,
                      blurRadius: 50,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).enterYourPersonalInfo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1, color: Color(0xFFF4F4F4)),
                      const SizedBox(height: 20),
                      Text(
                        S.of(context).usernameOrPhoneNumber,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      DefaultTextField(
                        hintText: S.of(context).enterUsernameOrPhoneNumber,
                        controller: _emailController,
                        fieldType: DefaultTextFieldType.email,
                      ),

                      const SizedBox(height: 20.0),
                      Text(
                        S.of(context).password,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      DefaultTextField(
                        controller: _passwordController,
                        hintText: S.of(context).enterPassword,
                        fieldType: DefaultTextFieldType.password,
                      ),
                      const SizedBox(height: 20),
                      /*Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _rememberMe = newValue!;
                                });
                              },
                              activeColor: Colors.deepPurple,
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),

                          Text(
                            S.of(context).rememberMe,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF92929D),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          *//*TextButton(
                          onPressed: () {
                            AppNavigator.navigateTo(
                              context,
                                  () => const ForgetPasswordScreen(),
                            );
                          },
                          child: const Text(
                            'Forgot Password',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),*//*
                        ],
                      ),
                      const SizedBox(height: 10),*/
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          final isLoading = state is LoginLoading;

                          return DefaultButton(
                            onTap: () {
                              if (isLoading) return;

                              context.read<LoginCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                                rememberMe: _rememberMe,
                              );
                            },
                            child:
                                isLoading
                                    ? LoadingAnimationWidget.threeArchedCircle(
                                      color: Colors.white,
                                      size: 30,
                                    )
                                    : Text(
                                      S.of(context).confirm,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
