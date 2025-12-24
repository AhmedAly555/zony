import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UsernameTextField extends StatefulWidget {
  final String? title;
  final String? hintTitle;
  final bool needEditing;
  const UsernameTextField({super.key, this.title, this.hintTitle, this.needEditing = false});

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? 'Username Or Phone Number',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintTitle ?? 'Enter Username Or Phone Number',
            hintStyle: const TextStyle(color: Color(0xFF929292), fontSize: 14.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.purple),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 15.0,
            ),
            suffixIcon: widget.needEditing
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 1,
                  height: 20,
                  color: const Color(0xFF929292),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/svgs/editing_pen.svg',
                    width: 17,
                    height: 16.5,
                    color: const Color(0xFF49159B),
                  ),
                ),
              ],
            )
                : null,
          ),
          keyboardType: TextInputType.text,
          //obscureText: widget.needEditing ? !_isPasswordVisible : false,
        ),
      ],
    );
  }
}