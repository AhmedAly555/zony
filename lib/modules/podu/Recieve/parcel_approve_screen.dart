import 'package:flutter/material.dart';
import 'package:zony/views/widgets/toasts.dart';
import '../../../models/parcel_model.dart';
import '../../../services/enums/parcel_status_type.dart';
import '../../../services/parcel_service.dart';
import '../../../services/patch_parcels_status_service.dart';
import '../../../services/shered_preferences/pudos_storage.dart';
import '../../../services/size_config.dart';
import '../../../theme/app_text_styles.dart';
import '../../../views/widgets/bottom_sheet/confirm_parcel_bottom_sheet.dart';
import '../../../views/widgets/circler_icon.dart';
import '../../../views/widgets/custom_parcel_details.dart';
import '../../../views/widgets/default_button.widget.dart';
import '../../../views/widgets/loading.widget.dart';
import '../../../views/widgets/secondary_appbar.dart';
import '../../../views/widgets/template_app_scaffold.widget.dart';
import '../../couriers/delivering/widgets/parcel_row.widget.dart';
import '../../../views/widgets/no_data_found.widget.dart';
import '../views/widgets/parcel_states.widget.dart';
import '../views/widgets/total_parcels_approved.widget.dart';

class ParcelApproveScreen extends StatefulWidget {
  const ParcelApproveScreen({super.key});

  @override
  State<ParcelApproveScreen> createState() => _ParcelApproveScreenState();
}

class _ParcelApproveScreenState extends State<ParcelApproveScreen> {
  //final GlobalKey<TotalParcelsApprovedState> _counterKey = GlobalKey();
  int _approvedCount = 0;
  bool isLoading = true;
  List<Parcel> parcels = [];

  @override
  void initState() {
    super.initState();
    fetchwaitingConfirmationParcels();
  }

  // helper function to fetch parcels
  Future<void> fetchwaitingConfirmationParcels() async {
    try {
      // get all pudos
      final pudosList = await PudosStorage.loadPudos();
      //print('PUDOs loaded. Count: ${pudosList.length}');

      // get the first pudo id and check if it is not empty
      String pudoId;
      if (pudosList.isNotEmpty) {
        //get the first pudo id
        pudoId = pudosList.first.id.toString();
        //print('PUDO ID to use:::::::::::::::::::: $pudoId');
      } else {
        // if
        setState(() => isLoading = false);
        //print('No PUDOs found, showing NotFoundWidget.');
        return;
      }

      // use the pudoId to get the parcels(waiting_confirmation)
      final response = await ParcelsService.instance.getParcelsByStatus(
        pudoId: pudoId,
        status: ParcelStatusType.waitingConfirmation.apiValue,
      );

      //print('Parcels API call succeeded.');

      setState(() {
        parcels = response.parcels ?? [];
        isLoading = false;
      });
    } catch (e) {
      //print('🚨 ERROR in fetchParcels: $e');
      setState(() => isLoading = false);
    }
  }

  // helper function to get the status widget
  Widget _getStatusWidget(String status) {
    switch (status) {
      case 'waiting_confirmation':
        return const WaitingWidget();
      case 'approved':
        return const ApprovedWidget();
      default:
        return const SizedBox.shrink();
    }
  }

  // helper function to handle parcel confirmation
  Future<void> _handleParcelConfirmation({
    required BuildContext context,
    required String parcelId,
    required ParcelStatusService parcelStatusService,
    required VoidCallback fetchParcels,
    //required GlobalKey<TotalParcelsApprovedState> counterKey,
  }) async {
    try {
      final pudosList = await PudosStorage.loadPudos();
      //print('PUDOs loaded. Count: ${pudosList.length}');

      // get the first pudo id and check if it is not empty
      String pudoId;
      if (pudosList.isNotEmpty) {
        //get the first pudo id
        pudoId = pudosList.first.id.toString();
        //print('PUDO ID to use:::::::::::::::::::: $pudoId');
      } else {
        // if
        setState(() => isLoading = false);
        //print('No PUDOs found, showing NotFoundWidget.');
        return;
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: LoadingWidget()),
      );

      await parcelStatusService.updateParcelStatus(
        parcelId: parcelId,
        status: ParcelStatusType.PUDOReceived.apiValue,
        pudoId: pudoId,
      );

      //counterKey.currentState?.incrementCounter();
      setState(() {
        _approvedCount++;
      });
      fetchParcels();
      Navigator.pop(context); // Closes the loading indicator
      Navigator.pop(context); // Closes the bottom sheet

      showCorrectToast(message: 'Parcel confirmed successfully!');
    } catch (e) {
      //print('Error updating parcel status: $e');
      showErrorToast(message: 'Failed to confirm parcel. Please try again.');
    }
  }

  // helper function to show confirm parcel bottom sheet
  void showConfirmParcelBottomSheet(BuildContext context, String parcelId) {
    final parcelStatusService = ParcelStatusService.instance;

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
            minHeight: SizeConfig.heightPercent(0.35),
          ),
          child: IntrinsicHeight(
            child: ConfirmParcelBottomSheet(
              parcelId: parcelId,
              onConfirm: () async {
                await _handleParcelConfirmation(
                  context: context,
                  parcelId: parcelId,
                  parcelStatusService: parcelStatusService,
                  fetchParcels: fetchwaitingConfirmationParcels,
                  //counterKey: _counterKey,
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body:
          isLoading
              ? const Center(child: LoadingWidget())
              : parcels.isEmpty
              ? const Center(child: NoDataFoundWidget())
              : RefreshIndicator(
                onRefresh: fetchwaitingConfirmationParcels,
                color: Color(0xFF49159B),

                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        const SecondaryAppBar(title: 'Parcel Approve'),
                        const SizedBox(height: 24),
                        TotalParcelsCounter(
                          //counterKey: _counterKey,
                          title: 'Total Approved',
                          value: _approvedCount.toString(),
                        ),
                        const SizedBox(height: 24),

                        // show all parcels
                        //collection for
                        for (final parcel in parcels)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CustomParcelDetails(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CirclerIcon(
                                        svgPath: 'assets/svgs/barcode_icon.svg',
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '#${parcel.id}',
                                        style: AppTextStyles.textStyle16,
                                      ),
                                      const Spacer(),
                                      _getStatusWidget(parcel.status),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    color: Color(0xFFF4F4F4),
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 24),
                                  const ImageContainer(),
                                  const SizedBox(height: 24),

                                  const Text(
                                    'Product info',
                                    style: AppTextStyles.textStyle16LightPurple,
                                  ),
                                  const SizedBox(height: 18),

                                  InfoItem(
                                    svgPath:
                                        'assets/svgs/barcode_with_background.svg',
                                    text: '#${parcel.id}',
                                  ),
                                  const SizedBox(height: 12),

                                  InfoItem(
                                    svgPath:
                                        'assets/svgs/calender_with_background.svg',
                                    text: parcel.receivingDate ?? '-',
                                  ),
                                  const SizedBox(height: 12),

                                  InfoItem(
                                    svgPath:
                                        'assets/svgs/call_icon_with_background.svg',
                                    text: parcel.clientName ?? '-',
                                  ),

                                  const SizedBox(height: 30),

                                  DefaultButton(
                                    onTap:
                                        () => showConfirmParcelBottomSheet(
                                          context,
                                          parcel.id,
                                        ),
                                    child: const Text(
                                      'Confirm Parcel',
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
                          ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
