import 'package:interactivesso_backendcore/src/BackendSettings/appsystemsettings.dart';
import 'package:interactivesso_backendcore/src/BackendSettings/usersystemsettings.dart';

class BackendSettings{
  BackendAPPSystemSettings appSystemSettings;
  BackendUserSystemSettings userSystemSettings;
  BackendSettings({
    required this.appSystemSettings,
    required this.userSystemSettings
  });
}