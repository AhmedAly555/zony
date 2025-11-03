import 'package:flutter/cupertino.dart';
import 'package:zony/models/parcel_model.dart';

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
      //print('➡️ Calling URL: $url');
      //print('➡️ With params: pudoId=$pudoId, status=$status');


      final response = await ApiService.instance.get(url);
      return ParcelsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch parcel by barcode
  // deliver from courier to podu
  Future<ParcelsResponse> getParcelByBarcode({
    required String pudoId,
    required String barcode,
  }) async {
    try {
      // Build the URL with query parameters
      final url = '/pudos/$pudoId/parcels?barcode=$barcode';

      final response = await ApiService.instance.get(url);
      return ParcelsResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


  /// Fetch parcel by receiving code
  // deliver from podu to customer
  Future<ParcelsResponse> getParcelByReceivingCode(
      String pudoId,
      String receivingCode,
      ) async {
    try {
      final response = await ApiService.instance.get(
        '/pudos/$pudoId/parcels?receiving_code=$receivingCode',
      );
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

  /// Fetch parcel by barcode (global search)
  // used when searching parcel directly without pudoId
  Future<ParcelsResponse> getGlobalParcelByBarcode({
    required String barcode,
  }) async {
    try {

      // Build the URL with query parameters
      final url = '/parcels?barcode=$barcode';

      final response = await ApiService.instance.get(url);
      return ParcelsResponse.fromJson(response);
    } catch (e, s) {
      debugPrint('❌ Error inside ParcelsService: $e');
      debugPrintStack(stackTrace: s);
      rethrow;    }
  }


}
