import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/get_courier_pudos_service.dart';
import 'courier_places_state.dart';

class CourierPlacesCubit extends Cubit<CourierPlacesState> {
  CourierPlacesCubit() : super(CourierPlacesInitial());

  Future<void> fetchPlaces({required String direction}) async {
    emit(CourierPlacesLoading());

    try {
      final response = await GetCourierPudosService.instance.getCourierPlaces(
        direction: direction,
      );
      emit(CourierPlacesSuccess(response.stops));
    } catch (e) {
      emit(CourierPlacesFailure(message: 'Failed to load stops'));
    }
  }
}
