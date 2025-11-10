import 'package:flutter/material.dart';

import '../../../../views/widgets/default_appbar.dart';
import '../../../../views/widgets/default_button.widget.dart';
import '../../../../views/widgets/default_text_filed.dart';
import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../widgets/total_parcels_approved.widget.dart';

class Revenue extends StatelessWidget {
  const Revenue({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            const AppBarHaveArrow(title: 'Revenue',),
            const SizedBox(height: 32,),
            TotalParcelsCounter(title: 'Total Shipments', value: '5',),
            const SizedBox(height: 24,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(24),

              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select the period",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Divider(height: 1, color: Color(0xFFF4F4F4)),
                    SizedBox(height: 20),
                    Text(
                      "From",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DefaultTextField(
                      hintText: '22/7',
                      controller: TextEditingController(),
                      //fieldType: DefaultTextFieldType.email,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "To",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DefaultTextField(
                      controller: TextEditingController(),
                      hintText: '22/7',
                      //fieldType: DefaultTextFieldType.email,
                      //fieldType: DefaultTextFieldType.password,
                    ),
                    SizedBox(height: 20),

                    DefaultButton(
                      onTap: () {},
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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
    );
  }
}
