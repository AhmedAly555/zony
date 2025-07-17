/*



import 'package:zony/services/api.services/api_service.dart';
import 'package:zony/services/api.services/config_service.dart';

import 'operation_result.dart';

class ApiServiceHelper {
  /// Method to get new access & refresh tokens from the server
  static Future<OperationResult> getRefreshTokens() async {
    if (ConfigService.refreshTokenApiURL == null ||
        (ConfigService.refreshTokenApiURL?.isEmpty ?? true)) {
      return OperationResult(success: false, multiMessage: {
        "en": "refreshTokenApiURL is null or empty",
        "ar": "لا يوجد رابط للتحقق من التوكن"
      });
    }

    OperationResult result = await ApiService().httpGetDynamic(
      ConfigService.refreshTokenApiURL!,
      checkOnTokenExpiration: false,
    );

    if (result.success) {
      return result;
    } else {
      return OperationResult(success: false, multiMessage: result.multiMessage);
    }
  }

  /// Check if the access token is expired
  static bool isTokenExpired() {
    if (ConfigService.checkValueExist("accessTokenExpDate")) {
      // Check if the token expired 3 hours ago or more
      return DateTime.fromMillisecondsSinceEpoch(
          ConfigService.accessTokenExpDate * 1000)
          .isBefore(DateTime.now().subtract(const Duration(hours: 3)));
    }
    return false;
  }

  /// Refresh tokens if expired and update in ConfigService
  static Future<bool> assignNewTokens() async {
    try {
      if (!isTokenExpired()) return true;

      if (ConfigService.checkValueExist("refreshTokenExpDate")) {
        DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(
          ConfigService.refreshTokenExpDate * 1000,
        );
        DateTime now = DateTime.now();

        // If refresh token is expired
        if (expirationDate.isBefore(now)) {
          debugPrint("-----> overrides access token with refresh token");

          ConfigService.token = ConfigService.refreshToken;

          OperationResult response = await getRefreshTokens();

          if (response.success) {
            ConfigService.token = response.data['token'];
            ConfigService.refreshToken = response.data['refreshToken'];
            ConfigService.accessTokenExpDate = response.data['tokenExp'];
            ConfigService.refreshTokenExpDate = response.data['refreshTokenExp'];
            return true;
          } else {
            return false;
          }
        }
      }

      return true;
    } catch (ex) {
      return false;
    }
  }

  /// Helper method used to verify token expiration and refresh them when needed
  static Future<OperationResult<T>> checkExpirationOfTokens<T>({
    required bool checkOnTokenExpiration,
  }) async {
    if (ConfigService.checkOnTokenExpiration == true &&
        checkOnTokenExpiration == true) {
      if (ConfigService.token.isNotEmpty &&
          ConfigService.refreshToken.isNotEmpty) {
        bool isRefreshedSuccessfully = await assignNewTokens();

        if (!isRefreshedSuccessfully) {
          return OperationResult<T>(
            success: false,
            message: 'Refresh token is not valid',
          );
        }
      }
    }
    return OperationResult<T>(
      success: true,
      message: 'Token is valid',
    );
  }
}
*/
