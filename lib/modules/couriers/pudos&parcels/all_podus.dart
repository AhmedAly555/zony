import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zony/views/widgets/default_appbar.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/views/widgets/loading.widget.dart';

import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../views/widgets/no_data_found.widget.dart';
import '../../../theme/app_colors.theme.dart';
import 'courier_stop_parcels.screen.dart';
import 'courier_stops_map.screen.dart';
import 'cubit/courier_places_cubit.dart';
import 'cubit/courier_places_state.dart';
import 'widgets/courier_stop_card.widget.dart';
import 'widgets/courier_stop_map_marker.widget.dart';

class AllPODUsScreen extends StatelessWidget {
  const AllPODUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourierPlacesCubit()..fetchPlaces(direction: 'pickup'),
      child: const _AllPODUsScreenBody(),
    );
  }
}

class _AllPODUsScreenBody extends StatelessWidget {
  const _AllPODUsScreenBody();

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                AppBarHaveArrow(title: S.of(context).myPodus),
                const _StopsMapButton(),
              ],
            ),
            const SizedBox(height: 28),
            /*TextField(
              decoration: InputDecoration(
                hintText: S.of(context).allParcels,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF49159B),
                  size: 24,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),*/
            const SizedBox(height: 24),
            Expanded(
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
                                .fetchPlaces(direction: 'pickup'),
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
                    return const Center(child: NoDataFoundWidget());
                  }

                  return ListView.separated(
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
          ],
        ),
      ),
    );
  }
}

/// Opens all loaded stops on one map; hidden until there is at least one plottable stop.
class _StopsMapButton extends StatelessWidget {
  const _StopsMapButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourierPlacesCubit, CourierPlacesState>(
      builder: (context, state) {
        if (state is! CourierPlacesSuccess ||
            courierStopsToMapPoints(state.stops).isEmpty) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => AppNavigator.navigateTo(
            context,
            () => CourierStopsMapScreen(
              stops: state.stops,
              title: S.of(context).myPodus,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.map_outlined,
              color: AppColors.zonyPrimary,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
