
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authcodefactory.g.dart';

@JsonSerializable()
class AuthCodeFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'challenge_type', fromJson: AuthCodeChallengeTypes.fromJson, toJson: Serializable.convertToDynamicSerialized)
  AuthCodeChallengeTypes challengeType; 

  @JsonKey(name: 'challenge')
  String? challenge;

  @JsonKey(required: true, name: 'client_id')
  String appClientId;

  @JsonKey(required: true, name: 'oauth_setting')
  OAuthPermissionInfo authorizedOAuthSetting;

  @JsonKey(required: true, name: 'time_info')
  ExpirableInfo expirableInfo;

  @JsonKey(required: true, name: 'user_unique_id')
  String userUniqueId;

  @JsonKey(required: true, name: 'exchange_method', toJson: Serializable.convertToDynamicSerialized, fromJson: ExchangeMethod.fromJson)
  ExchangeMethod exchangeMethod;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$AuthCodeFactoryCreateInfoToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  bool verifyCodeVerifier(String? verifier) => challengeType.verifyCodeVerifier(challenge,verifier);

  AuthCodeFactoryCreateInfo({
    required this.challengeType, 
    required String? challenge, 
    required this.appClientId, 
    required this.authorizedOAuthSetting, 
    required this.expirableInfo, 
    required this.userUniqueId, 
    required this.exchangeMethod}
  ){
    if(challengeType.isValidChallengeString(challenge)){
      this.challenge = challenge;
    }else{
      throw InnerParseException();
    }
  }

  factory AuthCodeFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$AuthCodeFactoryCreateInfoFromJson(map);
  static AuthCodeFactoryCreateInfo fromJson(Map<String,dynamic> json) => AuthCodeFactoryCreateInfo.fromMap(json);
  static AuthCodeFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

///AuthCodeId
typedef AuthCodeFactoryUpdateQueryParam = String;

@JsonSerializable(includeIfNull: false)
class AuthCodeFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'client_id')
  String? appClientId;
  @JsonKey(name: 'create_time_min')
  int? createTimeMin;
  @JsonKey(name: 'create_time_max')
  int? createTimeMax;
  @JsonKey(name: 'expire_time_min')
  int? expireTimeMin;
  @JsonKey(name: 'expire_time_max')
  int? expireTimeMax;
  @JsonKey(name: 'user_unique_id')
  String? userUniqueId;
  @JsonKey(name: 'exchange_method', toJson: Serializable.convertToDynamicSerializedWithNullable, fromJson: ExchangeMethod.fromJsonNullable)
  ExchangeMethod? exchangeMethod;

  AuthCodeFactorySearchClearParam({
    this.appClientId,
    this.createTimeMin,
    this.createTimeMax,
    this.expireTimeMin,
    this.expireTimeMax,
    this.userUniqueId,
    this.exchangeMethod
  });

  factory AuthCodeFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$AuthCodeFactorySearchClearParamFromJson(map);
  static AuthCodeFactorySearchClearParam fromJson(Map<String,dynamic> json) => AuthCodeFactorySearchClearParam.fromMap(json);
  static AuthCodeFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$AuthCodeFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class AuthCodeFactory implements
  PersistantStorageCreatable<AuthorizationCode, AuthCodeFactoryCreateInfo>,
  PersistantStorageSearchable<AuthorizationCode, AuthCodeFactorySearchClearParam>,
  PersistantStorageFetchable<AuthorizationCode, AuthCodeFactoryUpdateQueryParam>,
  PersistantStorageModifiable<AuthorizationCode, AuthCodeFactoryUpdateQueryParam, AuthCodeFactorySearchClearParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{

}