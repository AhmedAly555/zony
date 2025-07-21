import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../widgets/coustome_row_more_screen.widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'More Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ),
          //const SizedBox(height: 50),
          Spacer(),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/account.svg',
            title: 'Account Settings',
            onTap: () {
              // Navigate to Account Settings
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/svg_language.svg',
            title: 'Language',
            onTap: () {
              // Navigate to Language Settings
            },
          ),
          const SizedBox(height: 16),
          CoustomeRowMoreScreen(
            iconPath: 'assets/svgs/logout.svg',
            title: 'Logout',
            onTap: () {
              // Logout Function
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}

