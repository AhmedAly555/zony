import '../models/pudo_model.dart';
import '../models/pudo_response_model.dart';
import '../services/base_api_service.dart';
import 'api_service.dart';
import 'shered_preferences/pudos_storage.dart';

/// Service responsible for handling PUDO-related API calls
/// and save them locally by using SharedPreferences
class PudoService {
  static final PudoService instance = PudoService._internal(ApiService.instance);

  final BaseApiService _api;

  PudoService._internal(this._api);

  /// Fetch PUDOs from API and save them locally
  Future<PudoResponse> getPudos() async {
    final data = await _api.get('/pudos');
    final response = PudoResponse.fromJson(data);

    // Save pudos locally in SharedPreferences
    await PudosStorage.savePudos(response.pudos);

    return response;
  }

  /// Load cached pudos (useful when offline or before API call finishes)
  Future<List<Pudo>> getCachedPudos() async {
    return await PudosStorage.loadPudos();
  }

  /// Clear saved pudos
  Future<void> clearPudos() async {
    await PudosStorage.clearPudos();
  }
}

//usege online
/*final pudoResponse = await PudoService.instance.getPudos();
print('Total PUDOs: ${pudoResponse.totalPudos}');*/

//usege offline
/*final cachedPudos = await PudoService.instance.getCachedPudos();
print('Cached PUDOs: ${cachedPudos.length}');*/

//usege clear logout
/*await PudoService.instance.clearPudos();*/

