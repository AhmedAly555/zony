
import 'api_service.dart';

class ParcelStatusService {
  static final ParcelStatusService instance = ParcelStatusService._internal();
  ParcelStatusService._internal();

  final _api = ApiService.instance;

  Future<void> updateParcelStatus({
    required String parcelId,
    required String pudoId,
    required String status,
  }) async {

    final reqBody = {
      'status': status,
    };

    //print('Request body: $reqBody');

    await _api.patchJson("/pudos/$pudoId/parcels/$parcelId", reqBody);
  }

}
