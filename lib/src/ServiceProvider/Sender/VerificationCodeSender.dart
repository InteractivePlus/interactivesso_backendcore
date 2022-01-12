import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

abstract class VerificationCodeSender{
  Future<void> sendVerificationCode(VerificationCode code, UserInfo user, AvatarInfo? userAvatar, [String? locale]);
  Future<void> sendOAuthVerificationCode(OAuthVeriCode code, UserInfo user, ApplicationInfo app, AvatarInfo? userAvatar, AvatarInfo? appAvatar, [String? locale]);
}