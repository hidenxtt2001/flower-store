import 'dart:convert';
import 'dart:io';

import 'package:flower_store/src/models/staff.dart';
import 'package:flower_store/src/services/base/api_request.dart';
import 'package:flower_store/src/services/base/api_response.dart';
import 'package:flower_store/src/utils/themes/app_constant.dart';
import 'package:http/http.dart' as http;

abstract class AuthService {
  final String endPoint = 'staff';

  /// [email] Email of account.
  ///
  /// [password] Password of account.
  ///
  /// [Map] return the token auth vs token refesh.
  Future<APIResponse<Map<String, dynamic>?>> login({
    required String email,
    required String password,
  });

  /// [accessToken]
  Future<APIResponse<Staff?>> getProfile({
    required String accessToken,
  });

  /// [refeshToken] the token need to get new token access to use rest api.
  Future<APIResponse<Map<String, dynamic>?>> logout({
    required String accessToken,
  });
}

class AuthServiceImpl extends AuthService {
  AuthServiceImpl();

  @override
  Future<APIResponse<Map<String, dynamic>?>> login({
    required String email,
    required String password,
  }) async {
    return await apiRequest(
      '$endPoint/login',
      RequestMethod.POST,
      (json) => json,
      body: {
        'email': email,
        'password': password,
      },
    );
  }

  @override
  Future<APIResponse<Map<String, dynamic>?>> logout({
    required String accessToken,
  }) async {
    return await apiRequest(
      '$endPoint/logout',
      RequestMethod.POST,
      (json) => json,
      body: {'accessToken': accessToken},
    );
  }

  @override
  Future<APIResponse<Staff?>> getProfile({required String accessToken}) async {
    return await apiRequest(
      '$endPoint/profile',
      RequestMethod.GET,
      (json) => Staff.fromJson(json),
      token: accessToken,
    );
  }
}
