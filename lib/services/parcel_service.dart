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

  /// Fetch parcels for a specific PUDO ID with a specific status
  Future<ParcelsResponse> getParcelsByStatus({
    required String pudoId,
    required String status,
  }) async {
    try {
      // Build the URL with query parameters
      final url = '/pudos/$pudoId/parcels?status=$status';

      final response = await ApiService.instance.get(url);
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
