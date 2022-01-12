import 'Factories/APP/appinfofactory.dart';
import 'Factories/APP/appgroupfactory.dart';
import 'Factories/Avatar/avatarfactory.dart';
import 'Factories/OAuth/authcodefactory.dart';
import 'Factories/OAuth/oauthtokenfactory.dart';
import 'Factories/OAuth/oauthvericodefactory.dart';
import 'Factories/User/usergroupfactory.dart';
import 'Factories/User/userinfofactory.dart';
import 'Factories/User/usertokenfactory.dart';
import 'Factories/VeriCode/vericodefactory.dart';
import 'ServiceProvider/Captcha/captchaserviceprovider.dart';

class InteractiveSSOBackendCore{
  final APPGroupFactory appGroupFactory;
  final AppInfoFactory appInfoFactory;
  final AvatarFactory avatarFactory;
  final AuthCodeFactory oAuthAuthCodeFactory;
  final OAuthTokenFactory oAuthTokenFactory;
  final OAuthVeriCodeFactory oAuthVericodeFactory;
  final UserGroupFactory userGroupFactory;
  final UserInfoFactory userInfoFactory;
  final UserTokenFactory userTokenFactory;
  final VeriCodeFactory veriCodeFactory;
  final CaptchaServiceProvider captchaServiceProvider;
  InteractiveSSOBackendCore({
    required this.appGroupFactory,
    required this.appInfoFactory,
    required this.avatarFactory,
    required this.captchaServiceProvider,
    required this.oAuthAuthCodeFactory,
    required this.oAuthTokenFactory,
    required this.oAuthVericodeFactory,
    required this.userGroupFactory,
    required this.userInfoFactory,
    required this.userTokenFactory,
    required this.veriCodeFactory
  });
}