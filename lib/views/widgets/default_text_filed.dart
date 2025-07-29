import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum DefaultTextFieldType { text, email, password, phone, name }

class DefaultTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final DefaultTextFieldType fieldType;
  final bool isReadOnly;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool filled;
  final int? maxLines;
  final int? maxLength;

  const DefaultTextField({
    super.key,
    this.hintText,
    this.controller,
    this.fieldType = DefaultTextFieldType.text,
    this.isReadOnly = false,
    this.showEditIcon = false,
    this.onEditPressed,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.fillColor,
    this.filled = false,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool _isPasswordVisible = false;
  late bool _isEditable;

  @override
  void initState() {
    super.initState();
    _isEditable = !widget.isReadOnly;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
          widget.fieldType == DefaultTextFieldType.password &&
          !_isPasswordVisible,
      readOnly: !_isEditable,
      keyboardType: _getKeyboardType(),
      inputFormatters: _getInputFormatters(),
      validator: widget.validator,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText ?? _getDefaultHintText(),
        hintStyle: const TextStyle(
          color: Color(0xFF929292),
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIcon,
        filled: widget.filled,
        fillColor: widget.fillColor ?? (_isEditable ? null : Colors.grey[100]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _isEditable ? Color(0xFFAFAFAF) : Color(0xFFC4C3C3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.purple),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 15.0,
        ),
        suffixIcon: _buildSuffixIcon(),
        counterText: widget.maxLength != null ? null : "",
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    List<Widget> suffixWidgets = [];

    // Virtical devider
    if (widget.fieldType == DefaultTextFieldType.password ||
        widget.showEditIcon) {
      suffixWidgets.add(
        Container(
          width: 1,
          height: 22,
          color: const Color(0xFF929292),
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
      );
    }

    // Password icon
    if (widget.fieldType == DefaultTextFieldType.password) {
      suffixWidgets.add(
        IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      );
    }

    // Edit icon أ
    if (widget.showEditIcon) {
      suffixWidgets.add(
        GestureDetector(
          child:
              _isEditable
                  ? Icon(Icons.check)
                  : SvgPicture.asset(
                    'assets/svgs/editing_pen.svg',
                    width: 17,
                    height: 16.5,
                    color: const Color(0xFF49159B),
                  ),
          onTap: () {
            if (_isEditable) {
              if (widget.onEditPressed != null) {
                widget.onEditPressed!();
              }
              setState(() {
                _isEditable = false;
              });
            } else {
              setState(() {
                _isEditable = true;
              });
            }
          },
        ),
        /*IconButton(
          icon: Icon(
            _isEditable ? Icons.check : Icons.edit,
            color: _isEditable ? Colors.green : Colors.grey,
            size: 20,
          ),
          onPressed: () {
            if (_isEditable) {
              // حفظ التغييرات
              if (widget.onEditPressed != null) {
                widget.onEditPressed!();
              }
              setState(() {
                _isEditable = false;
              });
            } else {
              // تفعيل وضع التعديل
              setState(() {
                _isEditable = true;
              });
            }
          },
        ),*/
      );
    }

    if (suffixWidgets.isEmpty) {
      return null;
    }

    return Row(mainAxisSize: MainAxisSize.min, children: suffixWidgets);
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case DefaultTextFieldType.email:
        return TextInputType.emailAddress;
      case DefaultTextFieldType.phone:
        return TextInputType.phone;
      case DefaultTextFieldType.password:
        return TextInputType.visiblePassword;
      case DefaultTextFieldType.name:
      case DefaultTextFieldType.text:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.fieldType) {
      case DefaultTextFieldType.phone:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ];
      case DefaultTextFieldType.name:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zأ-ي\s]'))];
      default:
        return null;
    }
  }

  String _getDefaultHintText() {
    switch (widget.fieldType) {
      case DefaultTextFieldType.email:
        return 'أدخل البريد الإلكتروني';
      case DefaultTextFieldType.password:
        return 'أدخل كلمة المرور';
      case DefaultTextFieldType.phone:
        return 'أدخل رقم الهاتف';
      case DefaultTextFieldType.name:
        return 'أدخل الاسم';
      case DefaultTextFieldType.text:
      default:
        return 'أدخل النص';
    }
  }
}

/*

// EX
class ExampleUsage extends StatefulWidget {
  @override
  State<ExampleUsage> createState() => _ExampleUsageState();
}

class _ExampleUsageState extends State<ExampleUsage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Text Fields')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // للتسجيل/تسجيل الدخول
            const Text('نموذج التسجيل:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _nameController,
              fieldType: CustomTextFieldType.name,
              hintText: 'الاسم الكامل',
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _emailController,
              fieldType: CustomTextFieldType.email,
              hintText: 'البريد الإلكتروني',
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _passwordController,
              fieldType: CustomTextFieldType.password,
              hintText: 'كلمة المرور',
              prefixIcon: const Icon(Icons.lock),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _phoneController,
              fieldType: CustomTextFieldType.phone,
              hintText: 'رقم الهاتف',
              prefixIcon: const Icon(Icons.phone),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // للملف الشخصي
            const Text('الملف الشخصي:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            CustomTextField(
              controller: TextEditingController(text: 'أحمد محمد'),
              fieldType: CustomTextFieldType.name,
              hintText: 'الاسم',
              showEditIcon: true,
              isReadOnly: true,
              filled: true,
              fillColor: Colors.grey[100],
              onEditPressed: () {
                print('تم الضغط على حفظ التغييرات');
              },
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: TextEditingController(text: 'ahmed@example.com'),
              fieldType: CustomTextFieldType.email,
              hintText: 'البريد الإلكتروني',
              showEditIcon: true,
              isReadOnly: true,
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}*/
