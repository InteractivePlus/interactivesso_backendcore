import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

class BackendAPPSystemSettings{
  final APPPermissionInfo appBasePermissionInfo;
  final int verificationCodeAvailableDuration;
  final int accessTokenAvailableDuration;
  final int refreshTokenAvailableDuration;
  final String Function() generateClientSecret;
  final bool Function(String ref, String actual) checkClientSecretMatch;
  BackendAPPSystemSettings({
    required this.appBasePermissionInfo,
    required this.generateClientSecret,
    required this.checkClientSecretMatch,
    required this.verificationCodeAvailableDuration,
    required this.accessTokenAvailableDuration,
    required this.refreshTokenAvailableDuration
  });
}