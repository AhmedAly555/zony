import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zony/modules/couriers/delivering/screens/parcel_details.screen.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../services/parcel_service.dart';
import '../../../../views/widgets/bottom_sheet/qr_scanner.dart';
import '../../../../views/widgets/toasts.dart';
import '../widgets/parcel_row.widget.dart';
import '../widgets/search_button.widget.dart';

class PudoParcelsScreen extends StatefulWidget {

  final String pudoId;

   const PudoParcelsScreen({super.key, required this.pudoId});

  @override
  State<PudoParcelsScreen> createState() => _PudoParcelsScreenState();
}

class _PudoParcelsScreenState extends State<PudoParcelsScreen> {

  late Future future;

  @override
  void initState() {
    super.initState();
    future = ParcelsService.instance.getParcelsByPudoId(widget.pudoId);
    //print('Loading parcels for Pudo ID: ${widget.pudoId}');
  }

  Future<void> _handleParcelQRScan(BuildContext context, String pudoId) async {
    final controller = MobileScannerController();

    final parcelId = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QRScannerBottomSheet(
        sheetHeight: MediaQuery.of(context).size.height * 0.9,
        controller: controller,
      ),
    );

    await controller.stop();

    if (parcelId != null && parcelId.isNotEmpty) {
      // ✅ ممكن بعد كده هنا نضيف نداء السيرفيس الجديدة
      // ParcelsService.instance.getParcelDetails(pudoId, parcelId)
      // أو نبعته مباشرة للشاشه الجديده

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ParcelDetailsScreen(
            pudoId: pudoId,
            parcelId: parcelId,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondaryAppBar(title: 'Pickup Point Parcels'),
              SizedBox(height: 28),
              //search container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
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
                    const Text(
                      'Search By',
                      style: AppTextStyles.textStyle18,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: SearchButton(
                            svgPath: 'assets/svgs/small_qr.svg',
                            text: 'Scan barCode',
                            onTap: () async{
                              await _handleParcelQRScan(context, widget.pudoId);
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
              FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final response = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: response.parcels.length,
                    itemBuilder: (context, index) {
                      final parcel = response.parcels[index];
                      return Container(
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
                                    //borderRadius: BorderRadius.circular(8),
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
                                      '${parcel.status}',
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

                            // Divider
                            Divider(
                              color: Color(0xFFF4F4F4),
                              thickness: 1,
                            ),

                            const SizedBox(height: 24),

                            // Product info text
                            const Text(
                              'Product info',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B46C1),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Info items
                            InfoItem(
                              svgPath: 'assets/svgs/profile_icon_with_background.svg',
                              text: 'Cameron Williamson',
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath: 'assets/svgs/profile_icon_with_background.svg',
                              text: 'PODU: Rahmah Pharmacy',
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath: 'assets/svgs/location_icon_with_background.svg',
                              text: '4140 Parker Rd, Allentown, New Mexico',
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath: 'assets/svgs/call_icon_with_background.svg',
                              text: '(205) 555-0100',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
