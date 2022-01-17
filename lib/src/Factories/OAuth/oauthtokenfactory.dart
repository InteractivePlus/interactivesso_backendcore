
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauthtokenfactory.g.dart';

@JsonSerializable()
class OAuthTokenFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required:true, name: 'access_token_expires')
  ExpirableInfo accessTokenExpires;

  @JsonKey(required: true, name: 'refresh_token_expires')
  ExpirableInfo refreshTokenExpires;

  @JsonKey(required:true, name: 'exchange_method', toJson: Serializable.convertToDynamicSerialized, fromJson: ExchangeMethod.fromJson)
  ExchangeMethod exchangeMethod;

  @JsonKey(required: true, name: 'user_unique_id')
  String userUniqueId;

  @JsonKey(required: true, name: 'client_id')
  String appClientId;

  @JsonKey(required: true, name: 'valid')
  bool valid;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$OAuthTokenFactoryCreateInfoToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  OAuthTokenFactoryCreateInfo({
    required this.userUniqueId, 
    required this.appClientId, 
    required this.accessTokenExpires,
    required this.refreshTokenExpires,
    required this.exchangeMethod,
    required this.valid
  });
  factory OAuthTokenFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$OAuthTokenFactoryCreateInfoFromJson(map);
  static OAuthTokenFactoryCreateInfo fromJson(Map<String,dynamic> json) => OAuthTokenFactoryCreateInfo.fromMap(json);
  static OAuthTokenFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

@JsonEnum()
enum OAuthTokenFetchMethod{
  @JsonValue('access_token')
  accessToken,
  @JsonValue('refresh_token')
  refreshToken
}

@JsonSerializable()
class OAuthTokenFactoryUpdateQueryParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(required:true,name:'fetch_method')
  OAuthTokenFetchMethod fetchMethod;
  @JsonKey(required:true, name:'token')
  String token;
  OAuthTokenFactoryUpdateQueryParam({
    required this.fetchMethod,
    required this.token
  });
  factory OAuthTokenFactoryUpdateQueryParam.fromMap(Map<String,dynamic> map) => _$OAuthTokenFactoryUpdateQueryParamFromJson(map);
  static OAuthTokenFactoryUpdateQueryParam fromJson(Map<String,dynamic> json) => OAuthTokenFactoryUpdateQueryParam.fromMap(json);
  static OAuthTokenFactoryUpdateQueryParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);


  @override
  Map<String, dynamic> serialize([String? locale]) => _$OAuthTokenFactoryUpdateQueryParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

@JsonSerializable(includeIfNull: false)
class OAuthTokenFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name:'create_time_min')
  int? createTimeMin;
  @JsonKey(name:'create_time_max')
  int? createTimeMax;
  @JsonKey(name:'access_expire_min')
  int? accessTokenExpireMin;
  @JsonKey(name:'access_expire_max')
  int? accessTokenExpireMax;
  @JsonKey(name:'refresh_expire_min')
  int? refreshTokenExpireMin;
  @JsonKey(name:'refresh_expire_max')
  int? refreshTokenExpireMax;
  @JsonKey(name:'user_unique_id')
  String? userUniqueId;
  @JsonKey(name:'client_id')
  String? appClientId;
  @JsonKey(required:false, name:'exchange_method', toJson: Serializable.convertToDynamicSerializedWithNullable, fromJson: ExchangeMethod.fromJsonNullable)
  ExchangeMethod? exchangeMethod;
  @JsonKey(name:'valid')
  bool? validFilter;
  OAuthTokenFactorySearchClearParam({
    this.createTimeMin,
    this.createTimeMax,
    this.accessTokenExpireMin,
    this.accessTokenExpireMax,
    this.refreshTokenExpireMin,
    this.refreshTokenExpireMax,
    this.userUniqueId,
    this.appClientId,
    this.exchangeMethod,
    this.validFilter
  });
  factory OAuthTokenFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$OAuthTokenFactorySearchClearParamFromJson(map);
  static OAuthTokenFactorySearchClearParam fromJson(Map<String,dynamic> json) => OAuthTokenFactorySearchClearParam.fromMap(json);
  static OAuthTokenFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$OAuthTokenFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class OAuthTokenFactory implements
  PersistantStorageCreatable<OAuthToken, OAuthTokenFactoryCreateInfo>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<bool> checkAcessTokenValid(String accessToken, String appClientId, bool appSecretValidated, String userUniqueId, int currentTime);
  Future<void> tryMakeAccessRelatedTokenInvalid(String accessToken);
  Future<bool> checkRefreshTokenValid(String refreshToken, String appClientId, bool appSecretValidated, String userUniqueId, int currentTime);
  Future<void> tryMakeRefreshRelatedTokenInvalid(String refreshToken);
}

abstract class OAuthTokenFactorySearchable implements
  PersistantStorageSearchable<OAuthToken, OAuthTokenFactorySearchClearParam>,
  PersistantStorageFetchable<OAuthToken, OAuthTokenFactoryUpdateQueryParam>
{

}

abstract class OAuthTokenFactoryMutable implements
  PersistantStorageModifiable<OAuthToken, OAuthTokenFactoryUpdateQueryParam, OAuthTokenFactorySearchClearParam>
{

}