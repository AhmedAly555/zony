import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../views/widgets/default_text_filed.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../views/widgets/secondary_appbar.dart';
import '../../../auth/screens/login_screen.dart';


class AccountSettingsScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              children: [
                /*Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/svgs/arrow_back.svg',
                          width: 17,
                          height: 16.5,
                          color: const Color(0xFF49159B),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Account Settings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),*/
                SecondaryAppBar(title: 'Account Settings',),

                // Profile Card
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      //Profile Image with Edit Icon
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(
                              'assets/images/user.jpg',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.edit, size: 16),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ==== Name ====
                      const Text(
                        "Ahmed M. Aly",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // ==== Username ====
                      const Text(
                        "ahmaly555@gmail.com",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                //personal information
                Container(
                  width: double.infinity,
                  //height: widget.height,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Personal Information'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(height: 1, color: Color(0xFFF4F4F4)),
                        ),
                        DefaultTextField(
                          controller: _nameController,
                          fieldType: DefaultTextFieldType.name,
                          showEditIcon: true,
                          isReadOnly: true,
                          hintText: 'Ahmed M. Aly',
                          onEditPressed: () {},
                        ),
                        SizedBox(height: 20),
                        DefaultTextField(
                          controller: _emailController,
                          fieldType: DefaultTextFieldType.email,
                          showEditIcon: true,
                          isReadOnly: true,
                          hintText: 'ahmaly555@gmail.com',
                          onEditPressed: () {},
                        ),
                        SizedBox(height: 20),
                        DefaultTextField(
                          controller: _phoneController,
                          fieldType: DefaultTextFieldType.phone,
                          showEditIcon: true,
                          isReadOnly: true,
                          hintText: '+201206543069',
                          onEditPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  //height: widget.height,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Change Password'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(height: 1, color: Color(0xFFF4F4F4)),
                        ),
                        DefaultTextField(
                          controller: _passwordController,
                          fieldType: DefaultTextFieldType.password,
                          //showEditIcon: true,
                          isReadOnly: true,
                          hintText: 'Ahmed M. Aly',
                          onEditPressed: () {},
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF49159B),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 85,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => {},

                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
