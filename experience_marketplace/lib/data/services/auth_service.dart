import 'package:experience_marketplace/data/services/serverpod_service.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class AuthService {
  AuthService(ServerpodService client)
      : _isMock = false,
        _client = client,
        _sessionManager = SessionManager(caller: client.modules.auth) {
    _sessionManager!.initialize();
  }

  AuthService.mock()
      : _client = null,
        _isMock = true,
        _sessionManager = null;

  final ServerpodService? _client;
  final bool _isMock;
  final SessionManager? _sessionManager;

  Future<bool> authenticate(String email, String password) async {
    if (_isMock) {
      await Future.delayed(const Duration(milliseconds: 200));
      return true;
    }
    try {
      final response =
          await _client!.modules.auth.email.authenticate(email, password);
      if (response.success &&
          response.userInfo != null &&
          response.keyId != null &&
          response.key != null) {
        await _sessionManager!.registerSignedInUser(
          response.userInfo!,
          response.keyId!,
          response.key!,
        );
        return true;
      }
    } catch (exception, stackTrace) {
      debugPrint('$exception');
      debugPrint('$stackTrace');
    }
    return false;
  }

  Future<bool> unauthenticate() async {
    if (_isMock) {
      await Future.delayed(const Duration(milliseconds: 150));
      return true;
    }
    try {
      final success = await _sessionManager!.signOutDevice();
      return success;
    } catch (exception, stackTrace) {
      debugPrint('$exception');
      debugPrint('$stackTrace');
    }
    return false;
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    if (_isMock) {
      await Future.delayed(const Duration(milliseconds: 250));
      return true;
    }
    try {
      final success = await _client!.modules.auth.email.createAccountRequest(
        name,
        email,
        password,
      );
      return success;
    } catch (exception, stackTrace) {
      debugPrint('$exception');
      debugPrint('$stackTrace');
    }
    return false;
  }

  Future<bool> confirmAccount(
    String email,
    String verificationCode,
  ) async {
    if (_isMock) {
      await Future.delayed(const Duration(milliseconds: 200));
      return true;
    }
    try {
      final success = await _client!.modules.auth.email.createAccount(
        email,
        verificationCode,
      );
      return success?.id != null;
    } catch (exception, stackTrace) {
      debugPrint('$exception');
      debugPrint('$stackTrace');
    }
    return false;
  }
}
