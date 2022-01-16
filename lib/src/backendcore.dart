import 'package:interactivesso_backendcore/interactivesso_backendcore.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

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
  final List<VerificationCodeSender> vericodeSenders;

  final BackendSettings backendSettings;

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
    required this.veriCodeFactory,
    required this.vericodeSenders,
    required this.backendSettings
  });

  APPPermissionInfo getAppGroupPermission(APPGroupInfo appGroup) => _getAppGroupPermission(appGroup.permissionOverride);
  APPPermissionInfo _getAppGroupPermission(APPPermissionInfo appGroupPermissionOverride){
    if(appGroupPermissionOverride.isConcrete){
      return appGroupPermissionOverride;
    }else{
      return APPPermissionInfo
        .copy(appGroupPermissionOverride)
        ..mergePermission(backendSettings.appSystemSettings.appBasePermissionInfo)
        ..forceConcrete();
    }
  }
  Future<APPPermissionInfo> getAppPermission(ApplicationInfo appInfo) async {
    if(appInfo.permissionOverride.isConcrete){
      return appInfo.permissionOverride;
    }
    APPGroupInfo? appGroupInfo = await appGroupFactory.fetchFromRepo(appInfo.belongedAPPGroupId);
    if(appGroupInfo == null){
      return _getAppGroupPermission(appInfo.permissionOverride);
    }
    APPPermissionInfo combinedAppAndGroupPerm = APPPermissionInfo
      .copy(appInfo.permissionOverride)
      ..mergePermission(appGroupInfo.permissionOverride);
    if(combinedAppAndGroupPerm.isConcrete){
      return combinedAppAndGroupPerm;
    }else{
      return _getAppGroupPermission(combinedAppAndGroupPerm);
    }
  }
  Future<OAuthPermissionInfo> getOAuthTokenPermission(ExchangeMethod method, OAuthPermissionInfo userGrantSetting, ApplicationInfo appInfo) async{
    APPPermissionInfo appPerm = await getAppPermission(appInfo);
    OAuthPermissionInfo oAuthPermWithSettingApplied = OAuthPermissionInfo
      .copy(userGrantSetting)
      ..settingMergePermission(appPerm.oAuthPermission);
    OAuthPermissionInfo exchangeMethodMaskedPermission = OAuthPermissionInfo
      .copy(method.appPermFilter.oAuthPermission)
      ..mergePermission(oAuthPermWithSettingApplied);
    return exchangeMethodMaskedPermission;
  }
  UserPermissionInfo _getUserGroupPermission(UserPermissionInfo groupPermission){
    if(groupPermission.isConcrete){
      return groupPermission;
    }else{
      return UserPermissionInfo.combinePermission([groupPermission,backendSettings.userSystemSettings.userBasePermission]);
    }
  }
  UserPermissionInfo getUserGroupPermission(UserGroupInfo userGroup) => _getUserGroupPermission(userGroup.permissionOverride);
  Future<UserPermissionInfo> getUserPermission(UserInfo user) async{
    if(user.permissionOverride.isConcrete){
      return user.permissionOverride;
    }
    UserGroupInfo? userGroup = await userGroupFactory.fetchFromRepo(user.belongedGroupId);
    if(userGroup == null){
      return _getUserGroupPermission(user.permissionOverride);
    }
    return UserPermissionInfo.combinePermission([user.permissionOverride,getUserGroupPermission(userGroup)]);
  }
  VerificationCodeSender determineBestWayToSend({CommunicationMethod? preferredMethod, bool forcePreferredMethod = false}){
    late VerificationCodeSender ultimateSender;

    if(preferredMethod == null){
      ultimateSender = vericodeSenders[0];
    }

    VerificationCodeSender? firstPassResultForced;
    VerificationCodeSender? secondPassResult;
    for(VerificationCodeSender sender in vericodeSenders){
      if(sender.communicationMethod == preferredMethod){
        firstPassResultForced = sender;
        break;
      }
      if(preferredMethod!.verifyTarget == sender.communicationMethod.verifyTarget){
        secondPassResult = sender;
      }
    }
    if(firstPassResultForced != null){
      ultimateSender = firstPassResultForced;
    }
    if(forcePreferredMethod){
        throw UnsupportedError('Unsupported Way to send verification');
    }else if(secondPassResult != null){
      ultimateSender = secondPassResult;
    }else{
      ultimateSender = vericodeSenders[0];
    }
    return ultimateSender;
  }
  Future<void> sendVerificationCode({required VeriCodeFactoryCreateInfo veriCodeInfo, required UserInfo receiveUser, AvatarInfo? userAvatar, CommunicationMethod? preferredMethod, bool forcePreferredMethod = false, String? locale}) async{
    VerificationCode createdVeriCode = await veriCodeFactory.createNew(veriCodeInfo);
    VerificationCodeSender ultimateSender = determineBestWayToSend(preferredMethod: preferredMethod, forcePreferredMethod: forcePreferredMethod);
    await ultimateSender.sendVerificationCode(createdVeriCode, receiveUser, userAvatar, locale);
    createdVeriCode.sentMethod = ultimateSender.communicationMethod;
    await veriCodeFactory.update(VericodeFactoryUpdateQueryParam(isShortId: createdVeriCode.isShortId, veriCodeId: createdVeriCode.vericodeId), createdVeriCode);
  }
  Future<void> sendOAuthVerificationCode({required OAuthVeriCodeFactoryCreateInfo veriCodeInfo, required UserInfo receiveUser, required ApplicationInfo appInfo, required AvatarInfo? appAvatar, AvatarInfo? userAvatar, CommunicationMethod? preferredMethod, bool forcePreferredMethod = false, String? locale}) async{
    OAuthVeriCode createdVeriCode = await oAuthVericodeFactory.createNew(veriCodeInfo);
    VerificationCodeSender ultimateSender = determineBestWayToSend(preferredMethod: preferredMethod, forcePreferredMethod: forcePreferredMethod);
    await ultimateSender.sendOAuthVerificationCode(createdVeriCode, receiveUser, appInfo, userAvatar, appAvatar, locale);
    createdVeriCode.sentMethod = ultimateSender.communicationMethod;
    await oAuthVericodeFactory.update(OAuthVericodeFactoryUpdateQueryParam(isShortId: createdVeriCode.isShortId, veriCodeId: createdVeriCode.vericodeId), createdVeriCode);
  }
}