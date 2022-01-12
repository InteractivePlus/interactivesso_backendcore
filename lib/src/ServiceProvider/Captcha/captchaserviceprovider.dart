import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

abstract class CaptchaServiceProvider<CaptchaType extends CaptchaSubmitInfo>{
  Future<bool> verifyCaptcha(CaptchaType submitInfo);
}