import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zony/generated/l10n.dart';

import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../views/widgets/default_appbar.dart';
import '../../../views/widgets/loading.widget.dart';
import '../../../views/widgets/no_data_found.widget.dart';
import '../../../views/widgets/template_app_scaffold.widget.dart';
import 'courier_stop_parcels.screen.dart';
import 'cubit/courier_places_cubit.dart';
import 'cubit/courier_places_state.dart';
import 'widgets/courier_stop_card.widget.dart';

class DeliveryPointsScreen extends StatelessWidget {
  const DeliveryPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourierPlacesCubit()..fetchPlaces(direction: 'deliver'),
      child: const _DeliveryPointsScreenBody(),
    );
  }
}

class _DeliveryPointsScreenBody extends StatelessWidget {
  const _DeliveryPointsScreenBody();

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarHaveArrow(title: S.of(context).myParcels),
            const SizedBox(height: 28),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context
                    .read<CourierPlacesCubit>()
                    .fetchPlaces(direction: 'deliver'),
                child: BlocBuilder<CourierPlacesCubit, CourierPlacesState>(
                  builder: (context, state) {
                    if (state is CourierPlacesLoading || state is CourierPlacesInitial) {
                      return const Center(child: LoadingWidget());
                    }

                    if (state is CourierPlacesFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              S.of(context).failedToLoadStops,
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<CourierPlacesCubit>()
                                  .fetchPlaces(direction: 'deliver'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF49159B),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                S.of(context).tryAgain,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final stops = (state as CourierPlacesSuccess).stops;

                    if (stops.isEmpty) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 80),
                          NoDataFoundWidget(),
                        ],
                      );
                    }

                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: stops.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final stop = stops[index];
                        return CourierStopCard(
                          stop: stop,
                          onTap: () {
                            AppNavigator.navigateTo(
                              context,
                              () => CourierStopParcelsScreen(stop: stop),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
