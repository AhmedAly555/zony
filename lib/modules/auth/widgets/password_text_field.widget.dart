import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;

  const PasswordTextField({
    super.key,
    this.hintText,
    this.controller,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Enter Password',
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
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 1,
              height: 20,
              color: Color(0xFF929292),
              //margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
            IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ],
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }
}