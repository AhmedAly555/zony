/*
import '../models/parcels_response_model.dart';
import 'api_service.dart';

class ParcelsService {
  static final ParcelsService instance = ParcelsService._internal();
  ParcelsService._internal();

  /// Fetch parcels for a specific PUDO ID
  Future<ParcelsResponse> getParcelsByPudoId(String pudoId) async {
    try {
      final response = await ApiService.instance.get('/pudos/$pudoId/parcels');
      return ParcelsResponse.fromJson(response);
    } catch (e) {
      // Log error for debug
      //print('Error in ParcelService: $e');
      rethrow; // Pass the error to FutureBuilder for display
    }
  }
}
*/

import '../models/get_parcel_response_model.dart';
import '../models/get_parcels_response_model.dart';
import 'api_service.dart';

class ParcelsService {
  static final ParcelsService instance = ParcelsService._internal();

  ParcelsService._internal();

  /// Fetch parcels for a specific PUDO ID
  Future<ParcelsResponse> getParcelsByPudoId(String pudoId) async {
    try {
      final response = await ApiService.instance.get('/pudos/$pudoId/parcels');
      return ParcelsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch detailed info for a specific parcel inside a PUDO
  Future<ParcelResponse> getParcelDetails(
    String pudoId,
    String parcelId,
  ) async {
    try {
      final response = await ApiService.instance.get(
        '/pudos/$pudoId/parcels/$parcelId',
      );
      return ParcelResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
