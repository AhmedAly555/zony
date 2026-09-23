import 'package:flutter/material.dart';
import 'package:zony/generated/l10n.dart';

import '../../../models/courier_stop_model.dart';
import '../../../views/widgets/circler_icon.dart';
import '../../../views/widgets/default_appbar.dart';
import '../../../views/widgets/no_data_found.widget.dart';
import '../../../views/widgets/template_app_scaffold.widget.dart';

class CourierStopParcelsScreen extends StatelessWidget {
  final CourierStopModel stop;

  const CourierStopParcelsScreen({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    final parcels = stop.parcels;
    final placeName = stop.place?.name;
    final title = placeName != null && placeName.isNotEmpty
        ? placeName
        : S.of(context).unassignedStop;

    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarHaveArrow(title: title),
            const SizedBox(height: 24),
            Expanded(
              child: parcels.isEmpty
                  ? const Center(child: NoDataFoundWidget())
                  : ListView.separated(
                      itemCount: parcels.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final parcel = parcels[index];
                        final tracking = parcel.trackingNumber ??
                            parcel.trackingRef ??
                            parcel.barcode ??
                            '-';

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
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
                          child: Row(
                            children: [
                              const CirclerIcon(svgPath: 'assets/svgs/bag_icon.svg'),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parcel.recipientName ?? S.of(context).unknown,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF49159B),
                                      ),
                                    ),
                                    Text(
                                      '#$tracking',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF929292),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                parcel.status ?? '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
