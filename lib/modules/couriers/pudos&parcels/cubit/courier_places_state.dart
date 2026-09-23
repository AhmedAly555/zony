import '../../../../models/courier_stop_model.dart';

abstract class CourierPlacesState {}

class CourierPlacesInitial extends CourierPlacesState {}

class CourierPlacesLoading extends CourierPlacesState {}

class CourierPlacesSuccess extends CourierPlacesState {
  final List<CourierStopModel> stops;

  CourierPlacesSuccess(this.stops);
}

class CourierPlacesFailure extends CourierPlacesState {
  final String message;

  CourierPlacesFailure({required this.message});
}
