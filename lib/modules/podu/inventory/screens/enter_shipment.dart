import 'package:flutter/material.dart';

import '../../../../views/widgets/secondary_appbar.dart';
import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../views/widgets/total_parcels_approved.widget.dart';
import '../widgets/parcel_status_item.dart';

class EnterShipment extends StatefulWidget {
  const EnterShipment({super.key});

  @override
  State<EnterShipment> createState() => _EnterShipmentState();
}

class _EnterShipmentState extends State<EnterShipment> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30,
        ),
        child: Column(
          children: [
            const SecondaryAppBar(title: 'Parcel Approve'),
            const SizedBox(height: 70),
            //TotalParcelsApproved(counterKey:  , title: 'Total Approved',),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  ParcelStatusItem(
                    iconPath: 'assets/svgs/ready_to_deliver.svg',
                    title: 'Ready to deliver',
                    count: 10,
                    isSelected: selectedIndex == 0,
                    onTap: () => setState(() => selectedIndex = 0),
                  ),
                  const SizedBox(height: 10),
                  ParcelStatusItem(
                    iconPath: 'assets/svgs/transfer.svg',
                    title: 'Transfer',
                    count: 0,
                    isSelected: selectedIndex == 1,
                    onTap: () => setState(() => selectedIndex = 1),
                  ),
                  const SizedBox(height: 10),
                  ParcelStatusItem(
                    iconPath: 'assets/svgs/expired.svg',
                    title: 'Expired',
                    count: 1,
                    isSelected: selectedIndex == 2,
                    onTap: () => setState(() => selectedIndex = 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
