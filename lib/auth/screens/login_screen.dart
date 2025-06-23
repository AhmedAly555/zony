import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/svgs/arrow_back.svg",
                  /* width: 7.18,
                  height: 4.59, */
                ),
              ),
            ),
          ],
        ),
        //leading: LanguageWidget(),
        //centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: SizeConfig.heightPercent(0.55),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your personal information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Divider(height: 1, color: Color(0xFFF4F4F4)),
                SizedBox(height: 20),
                const Text(
                  'Username Or Phone Number',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Username Or Phone Number',
                    hintStyle: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // لون الحدود لما الحقل يكون غير مفعل
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // لون الحدود لما الحقل يكون مفعل
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.purple,
                      ), // أو أي لون تفضله
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 15.0,
                    ),
                  ),
                  keyboardType: TextInputType.text, // نوع الكيبورد
                ),
                SizedBox(height: 20),
                const SizedBox(height: 20.0), // مسافة بين الحقلين
                // ------------------ حقل كلمة المرور ------------------
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  obscureText: !_isPasswordVisible, // لإخفاء الباسورد
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
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
                    suffixIcon: IconButton(
                      // أيقونة إظهار/إخفاء الباسورد
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween, // يوزع العناصر على الأطراف
                  children: [
                    // Remember me
                    Row(
                      children: [
                        SizedBox(
                          width: 24.0, // لتثبيت عرض الـ Checkbox
                          height: 24.0, // لتثبيت ارتفاع الـ Checkbox
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _rememberMe = newValue!;
                              });
                            },
                            activeColor:
                                Colors
                                    .deepPurple, // لون الـ Checkbox لما يكون متعلم
                            checkColor: Colors.white, // لون علامة الصح
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                4.0,
                              ), // لجعل الزوايا مدورة قليلاً
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ), // مسافة بين الـ Checkbox والنص
                        const Text(
                          'Remember me',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // هنا الكود اللي هيشتغل لما المستخدم يضغط على "Forgot Password"
                        print('Forgot Password clicked!');
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.deepPurple, // لون بنفسجي زي الصورة
                          fontSize: 15.0,
                          decoration:
                              TextDecoration.underline, // لو عايز خط تحت الكلمة
                        ),
                      ),
                    ),
                  ],
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                    /* (_selectedIndex == 0 || _selectedIndex == 1)
                            ? 1.0
                            : 0.0, */
                  ),
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF49159B),
                            Color.lerp(
                              Color(0xFF49159B),
                              Color(0xFFF4F4F4),
                              1 - value,
                            )!,
                          ],
                          stops: [0.0, value.clamp(0.0, 1.0)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        /* (_selectedIndex == 0 || _selectedIndex == 1)
                                ? () {
                                  //
                                }
                                : null, */
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
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
    );
  }
}
