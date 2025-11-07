import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/modules/podu/inventory/screens/shipment_details.screen.dart';
import 'package:zony/services/extensions/parcel_status_extension.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/default_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../models/get_parcels_response_model.dart';
import '../../../../services/enums/parcel_status_type.dart';
import '../../../../services/parcel_service.dart';
import '../../../../services/shered_preferences/pudos_storage.dart';
import '../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../views/widgets/toasts.dart';
import '../../../../views/widgets/no_data_found.widget.dart';
import '../../../../views/widgets/loading.widget.dart';
import '../../../couriers/delivering/widgets/parcel_row.widget.dart';
import '../../../couriers/delivering/widgets/search_button.widget.dart';


class ShipmentReadyMenuScreen extends StatefulWidget {
  const ShipmentReadyMenuScreen({super.key});

  @override
  State<ShipmentReadyMenuScreen> createState() => _ShipmentReadyMenuScreenState();
}

class _ShipmentReadyMenuScreenState extends State<ShipmentReadyMenuScreen> {
  late Future<ParcelsResponse> _parcelsFuture;

  String? _pudoId;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final pudosList = await PudosStorage.loadPudos();

      if (pudosList.isEmpty) {
        setState(() {
          _parcelsFuture = Future.error('No PUDO found in local storage');
        });
        return;
      }

      _pudoId = pudosList.first.id.toString();
      //print('PUDO ID loaded: $_pudoId');

      _loadParcels();
    } catch (e) {
      setState(() {
        _parcelsFuture = Future.error('Failed to load PUDO data: $e');
      });
    }
  }

  void _loadParcels() {
    if (_pudoId == null) {
      setState(() {
        _parcelsFuture = Future.error('PUDO ID not loaded yet');
      });
      return;
    }

    setState(() {
      _parcelsFuture = ParcelsService.instance.getParcelsByStatus(
        status: ParcelStatusType.pudoReceived.apiValue,
        pudoId: _pudoId!,
      );
    });
  }

  Future<void> _handleParcelQRScan(BuildContext context) async {
    if (_pudoId == null) {
      showErrorToast(message: '❗ PUDO ID not loaded yet');
      return;
    }

    final controller = MobileScannerController();

    final barcode = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QRScannerBottomSheet(
        sheetHeight: MediaQuery.of(context).size.height * 0.9,
        controller: controller,
      ),
    );

    await controller.stop();

    if (barcode != null && barcode.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ShipmentDetailsScreen(
            pudoId: _pudoId!,
            barcode: barcode,
          ),
        ),
      );
    } else {
      showErrorToast(message: '⚠️ No Parcel QR detected!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: _pudoId == null
            ? const Center(child: LoadingWidget())
            :FutureBuilder<ParcelsResponse>(
          future: _parcelsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
            }
            if (snapshot.hasError) {
              return Center(child: NoDataFoundWidget());
            }

            final response = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  AppBarHaveArrow(title: 'Ready to Deliver'),
                  SizedBox(height: 28),
                  //search container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Search By', style: AppTextStyles.textStyle16),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: SearchButton(
                                svgPath: 'assets/svgs/small_qr.svg',
                                text: 'Scan barCode',
                                onTap: () async {
                                  await _handleParcelQRScan(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SearchButton(
                                svgPath: 'assets/svgs/small_qr.svg',
                                text: 'code Number',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  //podu parcels
                  if (response.parcels.isEmpty)
                    Center(
                      child: NoDataFoundWidget(),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: response.parcels.length,
                      itemBuilder: (context, index) {
                        final parcel = response.parcels[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F4F6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svgs/bag_icon.svg',
                                        color: Theme.of(context).primaryColor,
                                        width: 19.5,
                                        height: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            parcel.clientName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF49159B),
                                            ),
                                          ),
                                          Text(
                                            '${parcel.id}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF929292),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF16A34A),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Received",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF16A34A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Divider(color: Color(0xFFF4F4F4), thickness: 1),

                                const SizedBox(height: 24),

                                const Text(
                                  'Product info',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6B46C1),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                InfoItem(
                                  svgPath: 'assets/svgs/profile_icon_with_background.svg',
                                  text: parcel.clientName,
                                ),
                                const SizedBox(height: 12),
                                InfoItem(
                                  svgPath: 'assets/svgs/profile_icon_with_background.svg',
                                  text: parcel.zoneName ?? 'Unknown Zone',
                                ),
                                const SizedBox(height: 12),
                                InfoItem(
                                  svgPath: 'assets/svgs/location_icon_with_background.svg',
                                  text: parcel.cityName ?? 'Unknown Address',
                                ),
                                const SizedBox(height: 12),
                                InfoItem(
                                  svgPath: 'assets/svgs/call_icon_with_background.svg',
                                  text: parcel.cityName ?? 'Unknown Phone',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}