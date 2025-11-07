import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zony/modules/podu/deliver_customer/screens/successful_delivering.screen.dart';
import 'package:zony/services/extensions/parcel_status_extension.dart';
import 'package:zony/views/widgets/loading.widget.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../views/widgets/custom_parcel_details.dart';
import '../../../../../views/widgets/default_button.widget.dart';
import '../../../../../views/widgets/default_appbar.dart';
import '../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../models/get_parcels_response_model.dart';
import '../../../../models/parcel_model.dart';
import '../../../../services/enums/parcel_image_type.dart';
import '../../../../services/enums/parcel_status_type.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../services/parcel_service.dart';
import '../../../../services/shered_preferences/pudos_storage.dart';
import '../../../../services/size_config.dart';
import '../../../../services/upload_parsel_image_service.dart';
import '../../../../views/screens/custom_camera_screen.dart';
import '../../../../views/widgets/bottom_sheet/delivery_confirmation_bottom_sheet.dart';
import '../../../../views/widgets/bottom_sheet/photo_confirmation_bottom_sheet.dart';
import '../../../../views/widgets/toasts.dart';
import '../../../couriers/delivering/widgets/parcel_row.widget.dart';
import '../../../../views/widgets/no_data_found.widget.dart';

class ParcelDetailsScreen extends StatefulWidget {
  final String receivingCode;

  const ParcelDetailsScreen({super.key, //required this.pudoId,
    required this.receivingCode});

  @override
  State<ParcelDetailsScreen> createState() => _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends State<ParcelDetailsScreen> {

  late Future<ParcelsResponse> _parcelFuture;
  Parcel? _currentParcel;
  String? _pudoId;
  @override
  void initState() {
    super.initState();
    _initParcelFuture();
  }

  //get pudo id from local storage and get parcel by receiving code
  Future<void> _initParcelFuture() async {
    try {
      final pudosList = await PudosStorage.loadPudos();

      if (pudosList.isEmpty) {
        setState(() {
          _parcelFuture = Future.error('No PUDO found in local storage');
        });
        return;
      }

      _pudoId = pudosList.first.id.toString();
      //print('PUDO ID: $pudoId');
      //print('Receiving Code: ${widget.receivingCode}');

      // get parcel by receiving code
      setState(() {
        _parcelFuture = ParcelsService.instance.getParcelByReceivingCode(
          _pudoId!,
          widget.receivingCode,
        );
      });
    } catch (e) {
      //debugPrint('❌ Error while initializing parcel data: $e');
      setState(() {
        _parcelFuture = Future.error('Failed to load parcel data');
      });
    }
  }

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
                if (_currentParcel == null) {
                  showErrorToast(message: '❗ Parcel data not loaded yet.');
                  return;
                }
                await _uploadImageToCloudflare(
                  context: context,
                  parcelId: _currentParcel!.id,
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
        builder:
            (_) => const Center(child: LoadingWidget()),
      );

      // 1️⃣ Call the service
      final uploadResponse = await ParcelImageService.instance
          .createSignedUrl(
        parcelId: parcelId,
        imageType:
        ParcelImageType
            .customerImage
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

      //print('✅ Step 2 Done -> Image uploaded successfully');

      // 3️⃣ Store the publicUrl temporarily for the third request later
      onPublicUrlSet(uploadResponse.publicUrl);

      // Close the loading indicator
      Navigator.pop(
        context,
      ); // Closes the loading dialog (context here is for the dialog)

      showCorrectToast(message: '✅ Image uploaded successfully!');

      // Finally, close the first bottom sheet and return true for success
      Navigator.pop(
        context,
        true,
      ); // pop the bottom sheet and return true
    } catch (e, s) {
      if (Navigator.canPop(context)) {
        // Ensure the loading dialog is open before closing
        Navigator.pop(context); // Close the loading indicator in case of error
      }
      //print('❌ Error uploading parcel image: $e');
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
      await ParcelImageService.instance.updateParcelWithPudoidAfterUpload(
        parcelId: parcelId,
        status: ParcelStatusType.customerReceived.apiValue, // This changes based on the flow
        imageFieldName: ParcelImageType.customerImage.apiValue, // This also changes based on the flow
        imageUrl: uploadedImagePublicUrl,
        latitude: 24.7136,
        longitude: 46.6753,
        pudoId: _pudoId!,
      );

      // ✅ Update successful
      Navigator.pop(context); // Closes the loading indicator
      Navigator.pop(context); // Closes the bottom sheet
      showCorrectToast(message: '✅ Parcel Delivered successfully!');
      AppNavigator.navigateAndRemoveUntil(context, () => SuccessfulPoduDelivering(
          //pudoId: _pudoId!
      ));

    } catch (e, s) {
      Navigator.pop(context); // Closes the loading indicator in case of error
      //debugPrint('❌ Error updating parcel: $e');
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
                if (_uploadedImagePublicUrl == null || _uploadedImagePublicUrl!.isEmpty) {
                  showErrorToast(message: '❗ Please upload image first');
                  return;
                }

                await _handleParcelConfirmation(
                  context: context,
                  parcelId: _currentParcel!.id,
                  uploadedImagePublicUrl: _uploadedImagePublicUrl!,
                );
              },),
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
            AppBarHaveArrow(title: 'Parcel Details'),

            const SizedBox(height: 24),

            Expanded(
              child: FutureBuilder<ParcelsResponse>(
                future: _parcelFuture,
                builder: (context, snapshot) {
                  //Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: LoadingWidget());
                  }

                  // Error state
                  if (snapshot.hasError) {
                    return Center(child: NoDataFoundWidget());
                    //print(snapshot.error);
                  }

                  // Data state
                  if (snapshot.hasData) {
                    final parcels = snapshot.data!.parcels;
                    if (parcels.isEmpty) return const NoDataFoundWidget();
                    final parcel = parcels.first;

                    if (_currentParcel == null || _currentParcel!.id != parcel.id) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _currentParcel = parcel;
                        });
                      });
                    }

                    return SingleChildScrollView(
                      child: CustomParcelDetails(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageContainer(),

                            const SizedBox(height: 24),
                            // Divider
                            const Divider(
                              color: Color(0xFFF4F4F4),
                              thickness: 1,
                            ),
                            const SizedBox(height: 12),

                            // Product info text
                            const Text(
                              'Product info',
                              style: AppTextStyles.textStyle16LightPurple,
                            ),

                            const SizedBox(height: 18),

                            InfoItem(
                              svgPath: 'assets/svgs/profile_icon_with_background.svg',
                              text: parcel.id,
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath: 'assets/svgs/location_icon_with_background.svg',
                              text: parcel.zoneName ?? 'Unknown Zone',
                            ),
                            const SizedBox(height: 12),
                            InfoItem(
                              svgPath: 'assets/svgs/call_icon_with_background.svg',
                              text: parcel.cityName ?? 'Unknown City',
                            ),

                          ],
                        ),
                      ),
                    );
                  }

                  return const NoDataFoundWidget();
                },
              ),
            ),

            DefaultButton(
              onTap: () {
                _openCamera(context);

              },
              child: const Text(
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
