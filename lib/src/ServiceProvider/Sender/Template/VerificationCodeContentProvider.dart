import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

abstract class VerificationCodeContentProvider<ContentType>{
  Future<ContentType> getContentForVerificationCode(VerificationCode code, UserInfo user, AvatarInfo? userAvatar, [String? locale]);
  Future<ContentType> getContentForOAuthVerificationCode(OAuthVeriCode code, UserInfo user, ApplicationInfo app, AvatarInfo? userAvatar, AvatarInfo? appAvatar, [String? locale]);
}