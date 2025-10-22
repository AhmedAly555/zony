import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/parcel_image_field_model.dart';
import '../models/update_parcel_request_model.dart';
import '../models/upload_image_response_model.dart';
import 'api_service.dart';

class ParcelImageService {
  static final ParcelImageService instance = ParcelImageService._internal();
  ParcelImageService._internal();

  final _api = ApiService.instance;

  /// 1) POST /parcels/{parcelId}/sign-image-upload
  /// imageType: e.g. "warehouse_image"
  /// fileExt: fixed "png" as you said
  Future<UploadImageResponseModel> createSignedUrl({
    required String parcelId,
    required String imageType,
    String fileExt = "jpeg",
  }) async {
    final resp = await _api.postJson(
      "parcels/$parcelId/sign-image-upload",
      {
        "image_type": imageType,
        "file_ext": fileExt,
      },
    );
    return UploadImageResponseModel.fromJson(Map<String, dynamic>.from(resp));
  }

  /// 2) PUT to the returned upload_url (Cloudflare). No auth expected here.
  Future<void> uploadToSignedUrl({
    required String uploadUrl,
    required Uint8List fileBytes,
    required String contentType,
  }) async {
    final res = await http.put(
      Uri.parse(uploadUrl),
      headers: {"Content-Type": contentType},
      body: fileBytes,
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception("Upload failed: ${res.statusCode} ${res.body}");
    }
    // Successful upload -> nothing to return
  }

  /// 3) PATCH /parcels/{parcelId}
  /// imageFieldName: the key name (e.g. "warehouse_image")
  Future<void> updateParcelAfterUpload({
    required String parcelId,
    required String status, // e.g. "courier_received" — decided by UI/flow
    required String imageFieldName,
    required String imageUrl, // public_url from step 1
    double? latitude,
    double? longitude,
  }) async {

    final now = DateTime.now().toLocal(); // استخدم local time عشان AM/PM يشتغل صح
    final timestampFormatter = DateFormat('yyyy-MM-dd hh:mm:ss a', 'en_US');
    final formattedTimestamp = timestampFormatter.format(now);

    final imageField = ParcelImageFieldModel(
      url: imageUrl,
      timestamp: formattedTimestamp,
      location: (latitude != null && longitude != null)
          ? LocationModel(latitude: latitude, longitude: longitude)
          : null,
    );

    final req = UpdateParcelRequestModel(
      status: status,
      imageFieldName: imageFieldName,
      imageField: imageField,
    );

    print('Request body: ${req.toJson()}');

    await _api.patchJson("parcels/$parcelId", req.toJson());
  }
}
