import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zony/modules/couriers/recieve_expired/screens/successful_recieve.screen.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/custom_parcel_details.dart';
import '../../../../../views/widgets/default_button.widget.dart';
import '../../../../../views/widgets/secondary_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../services/enums/parcel_image_type.dart';
import '../../../../services/enums/parcel_status_type.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../services/size_config.dart';
import '../../../../services/upload_parsel_image_service.dart';
import '../../../../views/screens/custom_camera_screen.dart';
import '../../../../views/widgets/bottom_sheet/delivery_confirmation_bottom_sheet.dart';
import '../../../../views/widgets/bottom_sheet/photo_confirmation_bottom_sheet.dart';
import '../../../../views/widgets/loading.widget.dart';
import '../../../../views/widgets/toasts.dart';
import '../../delivering/widgets/parcel_row.widget.dart';

class ParcelDetailsScreen extends StatefulWidget {
  final String parcelId;
  final String pudoId;

  const ParcelDetailsScreen({
    super.key,
    required this.parcelId,
    required this.pudoId,
  });

  @override
  State<ParcelDetailsScreen> createState() => _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends State<ParcelDetailsScreen> {
  String? _uploadedImagePublicUrl;

  // Image Preview Bottom Sheet (modified for await and result)
  void _showImagePreviewBottomSheet(
    BuildContext context,
    File imageFile,
  ) async {
    final result = await showModalBottomSheet<bool>(
      // Added <bool> for the return type
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        SizeConfig.init(context);
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: SizeConfig.heightPercent(0.95),
            minHeight: SizeConfig.heightPercent(0.90),
          ),
          child: IntrinsicHeight(
            child: PhotoConfirmarionBottomSheet(
              imageFile: imageFile,
              onConfirm: () async {
                await _uploadImageToCloudflare(
                  context: context,
                  parcelId: widget.parcelId,
                  imageFile: imageFile,
                  onPublicUrlSet: (publicUrl) {
                    setState(() {
                      _uploadedImagePublicUrl = publicUrl;
                    });
                  },
                );
              },
            ),
          ),
        );
      },
    );

    // After closing the first bottom sheet, check the result and show the second one
    if (result == true) {
      _showDeliveryConfirmationBottomSheet(); // This automatically opens the second one
    }
  }

  //helper function to upload image to cloudflare
  Future<void> _uploadImageToCloudflare({
    required BuildContext context,
    required String parcelId,
    required File imageFile,
    required Function(String) onPublicUrlSet,
  }) async {
    try {
      // Show a simple loading indicator so the user knows something is happening
      showDialog(
        context: context, // The context here is for the builder
        barrierDismissible: false,
        builder: (_) => const Center(child: LoadingWidget()),
      );

      // 1️⃣ Call the service
      final uploadResponse = await ParcelImageService.instance.createSignedUrl(
        parcelId: parcelId,
        imageType:
            ParcelImageType
                .warehouseImage
                .apiValue, // This changes based on the flow
      );
      //print('✅ Step 1 Done -> uploadUrl: ${uploadResponse.uploadUrl}',);
      //print('✅ Step 1 Done -> publicUrl: ${uploadResponse.publicUrl}',);

      // 2️⃣ Upload the image to Cloudflare using the uploadUrl
      final bytes = await imageFile.readAsBytes();

      await ParcelImageService.instance.uploadToSignedUrl(
        uploadUrl: uploadResponse.uploadUrl,
        fileBytes: bytes,
        contentType: 'image/jpeg',
      );

      debugPrint('✅ Step 2 Done -> Image uploaded successfully');

      // 3️⃣ Store the publicUrl temporarily for the third request later
      onPublicUrlSet(uploadResponse.publicUrl);

      // Close the loading indicator
      Navigator.pop(
        context,
      ); // Closes the loading dialog (context here is for the dialog)

      showCorrectToast(message: '✅ Image uploaded successfully!');

      // Finally, close the first bottom sheet and return true for success
      Navigator.pop(context, true); // pop the bottom sheet and return true
    } catch (e, s) {
      if (Navigator.canPop(context)) {
        // Ensure the loading dialog is open before closing
        Navigator.pop(context); // Close the loading indicator in case of error
      }
      //debugPrint('❌ Error uploading parcel image: $e');
      debugPrintStack(stackTrace: s);
      showErrorToast(message: 'Failed to upload image: $e');

      // In case of error, close the bottom sheet and return false
      Navigator.pop(context, false);
    }
  }

  // helper function to handle parcel confirmation
  Future<void> _handleParcelConfirmation({
    required BuildContext context,
    required String parcelId,
    required String uploadedImagePublicUrl,
  }) async {
    try {
      // Show a simple loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: LoadingWidget()),
      );

      if (uploadedImagePublicUrl.isEmpty) {
        Navigator.pop(context);
        showErrorToast(message: '❗ Please upload image first');
        return;
      }

      // 1️⃣ Call the PATCH request to update the Parcel status
      await ParcelImageService.instance.updateParcelAfterUpload(
        parcelId: parcelId,
        status: ParcelStatusType.courierReceived.apiValue,
        // This changes based on the flow
        imageFieldName: ParcelImageType.warehouseImage.apiValue,
        // This also changes based on the flow
        imageUrl: uploadedImagePublicUrl,
        latitude: 24.7136,
        longitude: 46.6753,
      );

      // ✅ Update successful
      Navigator.pop(context); // Closes the loading indicator
      Navigator.pop(context); // Closes the bottom sheet
      showCorrectToast(message: '✅ Parcel Recieve successfully!');
      AppNavigator.navigateAndRemoveUntil(context, () => const SuccessfulRecieve());
    } catch (e, s) {
      Navigator.pop(context); // Closes the loading indicator in case of error
      debugPrint('❌ Error updating parcel: $e');
      debugPrintStack(stackTrace: s);
      showErrorToast(message: 'Failed to update parcel: $e');
    }
  }

  // Delivery Confirmation Bottom Sheet
  void _showDeliveryConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        SizeConfig.init(context);
        return Container(
          constraints: BoxConstraints(
            maxHeight: SizeConfig.heightPercent(0.75),
            minHeight: SizeConfig.heightPercent(0.45),
          ),
          child: IntrinsicHeight(
            child: DeliveryConfirmationBottomSheet(
              onConfirm: () async {
                if (_uploadedImagePublicUrl == null ||
                    _uploadedImagePublicUrl!.isEmpty) {
                  showErrorToast(message: '❗ Please upload image first');
                  return;
                }

                await _handleParcelConfirmation(
                  context: context,
                  parcelId: widget.parcelId,
                  uploadedImagePublicUrl: _uploadedImagePublicUrl!,
                );
              },
            ),
          ),
        );
      },
    );
  }

  // function to open camera screen
  void _openCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CustomCameraScreen(
              // This is the key: the onPictureTaken function
              onPictureTaken: (File image) {
                // 1. Close the camera screen first
                // (Since the camera screen was opened using push, we use pop to close it)
                Navigator.pop(context);

                // 2. Show the Bottom Sheet to display the image
                _showImagePreviewBottomSheet(context, image);
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
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
                  Text(
                    'PUDO ID: ${widget.pudoId}',
                    style: AppTextStyles.textStyle16LightPurple,
                  ),
                  Text(
                    'Parcel ID: ${widget.parcelId}',
                    style: AppTextStyles.textStyle16LightPurple,
                  ),
                  const SizedBox(height: 18),

                  // Info items
                  InfoItem(
                    svgPath: 'assets/svgs/profile_icon_with_background.svg',
                    text: 'Cameron Williamson',
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
            ),
            Spacer(),
            DefaultButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
