import 'package:flutter/material.dart';


import '../../../../services/size_config.dart';
import 'login_screen.dart';

class GenericLoginScreen extends StatefulWidget {

  final PreferredSizeWidget appBar;
  final Widget child;
  final double height;
  const GenericLoginScreen({super.key,
    required this.child,
    required this.height, required this.appBar,});

  @override
  State<GenericLoginScreen> createState() => _GenericLoginScreenState();
}

class _GenericLoginScreenState extends State<GenericLoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: widget.appBar,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 25,
                blurRadius: 50,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
