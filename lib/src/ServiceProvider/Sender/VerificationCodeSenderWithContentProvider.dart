import 'package:interactivesso_backendcore/src/ServiceProvider/Sender/ContentSender.dart';
import 'package:interactivesso_backendcore/src/ServiceProvider/Sender/Template/VerificationCodeContentProvider.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

import 'VerificationCodeSender.dart';

class VerificationCodeSenderWithContentProvider<RecipientType, ContentType> implements VerificationCodeSender, ContentSender<RecipientType, ContentType>{
  final ContentSender<RecipientType, ContentType> contentSender;
  final VerificationCodeContentProvider<ContentType> contentProvider;
  
  VerificationCodeSenderWithContentProvider({required this.contentSender, required this.contentProvider});

  @override
  Future<void> sendContent(RecipientType recipient, ContentType content) => contentSender.sendContent(recipient, content);

  @override
  Future<void> sendContentToUser(UserInfo user, ContentType content) => contentSender.sendContentToUser(user, content);

  @override
  Future<void> sendOAuthVerificationCode(OAuthVeriCode code, UserInfo user, ApplicationInfo app, AvatarInfo? userAvatar, AvatarInfo? appAvatar, [String? locale]) async {
    ContentType contentToSend = await contentProvider.getContentForOAuthVerificationCode(code, user, app, userAvatar, appAvatar, locale);
    await sendContentToUser(user, contentToSend);
  }

  @override
  Future<void> sendVerificationCode(VerificationCode code, UserInfo user, AvatarInfo? userAvatar, [String? locale]) async {
    ContentType contentToSend = await contentProvider.getContentForVerificationCode(code, user, userAvatar, locale);
    await sendContentToUser(user,contentToSend);
  }
} 