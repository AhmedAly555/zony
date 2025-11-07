
import '../models/my_pudos_response.dart';
import '../models/single_pudo_response_model.dart';
import 'api_service.dart';

class GetMyPudosService {
  // Singleton pattern
  GetMyPudosService._internal();
  static final GetMyPudosService instance = GetMyPudosService._internal();

  /// Fetch all PUDOs
  Future<MyPudosResponse> getAllPudos() async {
    try {
      const url = '/pudos';
      final response = await ApiService.instance.get(url);
      return MyPudosResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch single PUDO details by ID
  Future<SinglePudoResponse> getSinglePudoById(String pudoId) async {
    try {
      final response = await ApiService.instance.get('/pudos/$pudoId');
      return SinglePudoResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
