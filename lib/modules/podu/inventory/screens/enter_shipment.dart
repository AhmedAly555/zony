import 'package:flutter/material.dart';
import 'package:zony/services/extensions/parcel_status_extension.dart';

import '../../../../services/enums/parcel_status_type.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../services/parcel_service.dart';
import '../../../../services/shered_preferences/pudos_storage.dart';
import '../../../../views/widgets/loading.widget.dart';
import '../../../../views/widgets/default_appbar.dart';
import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../views/widgets/total_parcels_approved.widget.dart';
import '../widgets/parcel_status_item.dart';
import 'shipment_expired_menu.dart';
import 'shipments_ready_menu.dart';

class EnterShipment extends StatefulWidget {
  const EnterShipment({super.key});

  @override
  State<EnterShipment> createState() => _EnterShipmentState();
}

class _EnterShipmentState extends State<EnterShipment> {
  int selectedIndex = 0;
  bool isLoading = true;

  int totalParcelsOverall = 0;
  int totalPUDOReceivedParcels = 0;
  int totalExpiredParcels = 0;

  @override
  void initState() {
    super.initState();
    fetchwaitingAndExpiredParcels();
  }

  // helper function to fetch parcels
  Future<void> fetchwaitingAndExpiredParcels() async {
    try {
      // get all pudos

      final pudosList = await PudosStorage.loadPudos();
      //print('PUDOs loaded. Count: ${pudosList.length}');


      // get the first pudo id and check if it is not empty
      String pudoId;
      if (pudosList.isNotEmpty) {

        //get the first pudo id
        pudoId = pudosList.first.id.toString();

      } else {
        // if
        setState(() => isLoading = false);
        //print('No PUDOs found, showing NotFoundWidget.');
        return;
      }

      // use the pudoId to get the parcels(PUDO_received)
      final responsePUDOReceived = await ParcelsService.instance
          .getParcelsByStatus(
            pudoId: pudoId,
            status: ParcelStatusType.pudoReceived.apiValue,
          );

      // use the pudoId to get the parcels(expired_received)
      final responseExpiredReceived = await ParcelsService.instance
          .getParcelsByStatus(
            pudoId: pudoId,
            status: ParcelStatusType.expired.apiValue,
          );
      //print('Parcels API call succeeded.');

      //print('courierReceived total::::: ${responsePUDOReceived.totalParcels}');
      //print('pending total:::::::::::: ${responseExpiredReceived.totalParcels}');
      setState(() {
        totalPUDOReceivedParcels = responsePUDOReceived.totalParcels;
        totalExpiredParcels = responseExpiredReceived.totalParcels;
        totalParcelsOverall = totalPUDOReceivedParcels + totalExpiredParcels;
        isLoading = false;
      });
    } catch (e, st) {
      //print('🚨 ERROR in fetchParcels: $e');
      //print('🚨 ERROR in fetchwaitingConfirmationParcels: $e');
      //print('STACK TRACE:\n$st');

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: isLoading
          ? const Center(child: LoadingWidget())
          :RefreshIndicator(
            onRefresh: () => fetchwaitingAndExpiredParcels(),
            color: Color(0xFF49159B),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                      child: Column(
              children: [
                const AppBarHaveArrow(title: 'Inventory'),
                const SizedBox(height: 70),
                TotalParcelsCounter(
                  title: 'Total Approved',
                  value: totalParcelsOverall.toString() ?? '0',
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      ParcelStatusItem(
                        iconPath: 'assets/svgs/ready_to_deliver.svg',
                        title: 'Ready to deliver',
                        count: totalPUDOReceivedParcels ?? 0,
                        isSelected: selectedIndex == 0,
                        onTap: () {
                          setState(() => selectedIndex = 0);
                          AppNavigator.navigateTo(context, () => ShipmentReadyMenuScreen());
                        },
                      ),
                      const SizedBox(height: 20),
                      ParcelStatusItem(
                        iconPath: 'assets/svgs/transfer.svg',
                        title: 'Transfer',
                        count: 0,
                        isSelected: selectedIndex == 1,
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      ParcelStatusItem(
                        iconPath: 'assets/svgs/expired.svg',
                        title: 'Expired',
                        count: totalExpiredParcels ?? 0,
                        isSelected: selectedIndex == 2,
                        onTap: () {
                          setState(() => selectedIndex = 2);
                          AppNavigator.navigateTo(context, () => ShipmentExpiredMenuScreen());
                        },
                      ),
                    ],
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
