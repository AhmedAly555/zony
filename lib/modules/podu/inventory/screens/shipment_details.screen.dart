import 'package:flutter/material.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/custom_parcel_details.dart';
import '../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../models/parcel_model.dart';
import '../../../../services/parcel_service.dart';
import '../../../../views/widgets/loading.widget.dart';
import '../../../../views/widgets/no_data_found.widget.dart';
import '../../../../views/widgets/toasts.dart';
import '../../../couriers/delivering/widgets/parcel_row.widget.dart';

class ShipmentDetailsScreen extends StatefulWidget {
  //final String parcelId;
  final String pudoId;
  final String barcode;

  const ShipmentDetailsScreen({
    super.key,
    required this.barcode,
    //required this.parcelId,
    required this.pudoId,
  });

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  bool _isLoading = true;
  Parcel? _parcel;

  //parcel id from response getParcelByBarcode
  String? _parcelId;

  String? _uploadedImagePublicUrl;

  @override
  void initState() {
    super.initState();
    _fetchParcelDetails();
  }

  Future<void> _fetchParcelDetails() async {
    try {
      final response = await ParcelsService.instance.getGlobalParcelByBarcode(
        barcode: widget.barcode,
      );

      setState(() {
        _parcel = response.parcels.isNotEmpty
            ? response.parcels.first
            : null;
        _parcelId = _parcel?.id.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorToast(message: '❌ Failed to fetch parcel details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: _isLoading
          ? const Center(child: LoadingWidget())
          : _parcel == null
          ? const Center(child: NoDataFoundWidget())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            SecondaryAppBar(title: 'Parcel Details'),

            const SizedBox(height: 24),

            CustomParcelDetails(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageContainer(),

                  const SizedBox(height: 24),

                  // Product info text
                  const Text(
                    'Product info',
                    style: AppTextStyles.textStyle16LightPurple,
                  ),
                  const SizedBox(height: 18),

                  // Info items
                  InfoItem(
                    svgPath: 'assets/svgs/profile_icon_with_background.svg',
                    text: _parcel?.clientName ?? 'Unknown Client',
                  ),
                  const SizedBox(height: 12),
                  InfoItem(
                    svgPath: 'assets/svgs/location_icon_with_background.svg',
                    text: _parcel?.cityName ??
                        'Unknown address',                  ),
                  const SizedBox(height: 12),
                  InfoItem(
                    svgPath: 'assets/svgs/call_icon_with_background.svg',
                    text: _parcel?.customerPhoneNumber ??
                        'No phone number',                  ),
                ],
              ),
            ),
            const Spacer(),
            /*DefaultButton(
              onTap: () {
                _openCamera(context);
              },
              child: Text(
                'Capture Parcel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
