import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import 'podu_details.dart';
import 'podu_parcels.dart';

class PudoDetailsAndParceis extends StatefulWidget {
  final String pudoId;
  const PudoDetailsAndParceis({super.key, required this.pudoId});

  @override
  _PudoDetailsAndParceisState createState() => _PudoDetailsAndParceisState();
}

class _PudoDetailsAndParceisState extends State<PudoDetailsAndParceis> {
  int selectedTabIndex = 0;


  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Column(
        children: [

          // Top Navigation Tabs
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedTabIndex == 0
                            ? Color(0xFF49159B)
                            : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).poduDetails,
                          style: TextStyle(
                            color: selectedTabIndex == 0
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedTabIndex == 1
                            ? Color(0xFF49159B)
                            : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).poduParcels,
                          style: TextStyle(
                            color: selectedTabIndex == 1
                                ? Color(0xFFFFFFFF)
                                : Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: selectedTabIndex == 0
                ? PODUDetails(pudoId: widget.pudoId)
                : PudoParcels(pudoId: widget.pudoId),
          ),
        ],
      ),
    );
  }

}