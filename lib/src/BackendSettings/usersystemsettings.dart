import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

class BackendUserSystemSettings{
  final UserPermissionInfo userBasePermission;
  final int verificationCodeAvailableDuration;
  final int accessTokenAvailableDuration;
  final int refreshTokenAvailableDuration;

  BackendUserSystemSettings({
    required this.userBasePermission,
    required this.verificationCodeAvailableDuration,
    required this.accessTokenAvailableDuration,
    required this.refreshTokenAvailableDuration
  });
}