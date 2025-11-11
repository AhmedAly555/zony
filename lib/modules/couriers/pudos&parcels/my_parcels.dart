import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zony/generated/l10n.dart';
import '../../../models/get_parcels_response_model.dart';
import '../../../models/parcel_model.dart';
import '../../../services/extensions/parcel_status_extension.dart';
import '../../../services/parcel_service.dart';
import '../../../views/widgets/default_appbar.dart';
import '../../../views/widgets/loading.widget.dart';
import '../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../views/widgets/toasts.dart';
import '../delivering/widgets/parcel_row.widget.dart';

class MyParcelsScreen extends StatefulWidget {
  const MyParcelsScreen({super.key});

  @override
  State<MyParcelsScreen> createState() => _MyParcelsScreenState();
}

class _MyParcelsScreenState extends State<MyParcelsScreen> {
  late Future<ParcelsResponse> _parcelsFuture;

  @override
  void initState() {
    super.initState();
    _parcelsFuture = _loadParcels();
  }

  Future<ParcelsResponse> _loadParcels() async {
    final response = await ParcelsService.instance.getGlobalAllParcel();
    return response;
  }

  Future<void> _refreshParcels() async {
    final response = await ParcelsService.instance.getGlobalAllParcel();

    if (mounted) {
      showCorrectToast(message: S.of(context).parcelsRefreshedSuccessfully);

    }

    setState(() {
      _parcelsFuture = Future.value(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: RefreshIndicator(
        onRefresh: _refreshParcels,
        child: FutureBuilder<ParcelsResponse>(
          future: _parcelsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  S.of(context).error + ': ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.parcels.isEmpty) {
              return Center(child: Text(S.of(context).noParcelsFound));
            }

            final response = snapshot.data!;
            final parcels = response.parcels;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarHaveArrow(title: S.of(context).myParcels),
                  const SizedBox(height: 28),
                  // ✅ خلي كل العناصر جوه الـ Scroll
                  ...parcels.map((parcel) {
                    final status = ParcelStatusTypeExtension.fromApiValue(
                      parcel.status ?? 'pending',
                    );

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
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF3F4F6),
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
                                        parcel.clientName ?? S.of(context).unknownClient,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF49159B),
                                        ),
                                      ),
                                      Text(
                                        '#${parcel.id ?? '-'}',
                                        style: const TextStyle(
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
                                      decoration: BoxDecoration(
                                        color: status.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      status.displayName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: status.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(color: Color(0xFFF4F4F4), thickness: 1),
                            const SizedBox(height: 24),
                            Text(
                              S.of(context).productInfo,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B46C1),
                              ),
                            ),
                            const SizedBox(height: 18),
                            InfoItem(
                              svgPath:
                              'assets/svgs/profile_icon_with_background.svg',
                              text: parcel.clientName ?? S.of(context).unknown,
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath:
                              'assets/svgs/profile_icon_with_background.svg',
                              text: parcel.zoneName ?? S.of(context).unknownZone,
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath:
                              'assets/svgs/location_icon_with_background.svg',
                              text: parcel.cityName ?? S.of(context).unknownCity,
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath:
                              'assets/svgs/call_icon_with_background.svg',
                              text: parcel.customerPhoneNumber ?? S.of(context).unknownPhone,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
