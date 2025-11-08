import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../theme/app_text_styles.dart';

class ApprovedWidget extends StatelessWidget {
  const ApprovedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE1FEDA),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset('assets/svgs/approved_icon.svg'),
          const SizedBox(width: 5.5),
          Text(S.of(context).approved, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF008000),
          ),),
        ],
      ),
      ),
    );
  }
}

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFb6a1d7),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset('assets/svgs/waiting_approve_icon.svg'),
            const SizedBox(width: 5.5),
            Text(S.of(context).waiting, style: AppTextStyles.textStyle16),
          ],
        ),
      ),
    );
  }
}

class PendingWidget extends StatelessWidget {
  const PendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset('assets/svgs/pending_icon.svg'),
            const SizedBox(width: 5.5),
            Text(S.of(context).pending, style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF929292),
            ),),
          ],
        ),
      ),
    );
  }
}
