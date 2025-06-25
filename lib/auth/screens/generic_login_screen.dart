import 'package:flutter/material.dart';

import '../../services/size_config.dart';
import '../widgets/custom_appbar.dart';
import 'login_screen.dart';

class GenericLoginScreen extends StatefulWidget {
  const GenericLoginScreen({super.key});

  @override
  State<GenericLoginScreen> createState() => _GenericLoginScreenState();
}

class _GenericLoginScreenState extends State<GenericLoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: SizeConfig.heightPercent(0.52),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LoginScreen(),
          ),
        ),
      ),
    );
  }
}
