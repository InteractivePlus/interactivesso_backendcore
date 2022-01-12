import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

part 'usertokenfactory.g.dart';

@JsonSerializable()
class UserTokenFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'access_token_expires')
  ExpirableInfo accessTokenExpires;

  @JsonKey(required: true, name: 'refresh_token_expires')
  ExpirableInfo refreshTokenExpires;

  @JsonKey(required: true, name: 'user_unique_id')
  String userUniqueId;

  @JsonKey(required: true, name: 'required')
  bool valid;

  @JsonKey(name: 'issued_ip')
  String? issuedIP;

  @JsonKey(name: 'renewed_ip')
  String? renewedIP;

  @override
  Map<String, dynamic> serialize([String? locale]) => _$UserTokenFactoryCreateInfoToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);

  UserTokenFactoryCreateInfo({
    required this.accessTokenExpires, 
    required this.refreshTokenExpires, 
    required this.userUniqueId, 
    required this.valid, 
    this.issuedIP, 
    this.renewedIP
  });
  factory UserTokenFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$UserTokenFactoryCreateInfoFromJson(map);
  static UserTokenFactoryCreateInfo fromJson(Map<String,dynamic> json) => UserTokenFactoryCreateInfo.fromMap(json);
  static UserTokenFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

@JsonEnum()
enum UserTokenFetchMethod{
  @JsonValue('access_token')
  accessToken,
  @JsonValue('refresh_token')
  refreshToken
}

@JsonSerializable()
class UserTokenFactoryUpdateQueryParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(required:true,name:'fetch_method')
  UserTokenFetchMethod fetchMethod;
  @JsonKey(required:true, name:'token')
  String token;
  UserTokenFactoryUpdateQueryParam({
    required this.fetchMethod,
    required this.token
  });
  factory UserTokenFactoryUpdateQueryParam.fromMap(Map<String,dynamic> map) => _$UserTokenFactoryUpdateQueryParamFromJson(map);
  static UserTokenFactoryUpdateQueryParam fromJson(Map<String,dynamic> json) => UserTokenFactoryUpdateQueryParam.fromMap(json);
  static UserTokenFactoryUpdateQueryParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);


  @override
  Map<String, dynamic> serialize([String? locale]) => _$UserTokenFactoryUpdateQueryParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

@JsonSerializable(includeIfNull: false)
class UserTokenFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
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
  @JsonKey(name:'valid')
  bool? validFilter;

  UserTokenFactorySearchClearParam({
    this.createTimeMin,
    this.createTimeMax,
    this.accessTokenExpireMin,
    this.accessTokenExpireMax,
    this.refreshTokenExpireMin,
    this.refreshTokenExpireMax,
    this.userUniqueId,
    this.validFilter
  });
  factory UserTokenFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$UserTokenFactorySearchClearParamFromJson(map);
  static UserTokenFactorySearchClearParam fromJson(Map<String,dynamic> json) => UserTokenFactorySearchClearParam.fromMap(json);
  static UserTokenFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$UserTokenFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class UserTokenFactory implements
  PersistantStorageCreatable<UserToken,UserTokenFactoryCreateInfo>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<bool> checkAcessTokenValid(String accessToken, String userUniqueId, int currentTime);
  Future<void> tryMakeAccessRelatedTokenInvalid(String accessToken);
  Future<bool> checkRefreshTokenValid(String refreshToken, String userUniqueId, int currentTime);
  Future<void> tryMaskRefreshRelatedTokenInvalid(String refreshToken);
}

abstract class UserTokenFactorySearchable implements
  PersistantStorageSearchable<UserToken, UserTokenFactorySearchClearParam>,
  PersistantStorageFetchable<UserToken, UserTokenFactoryUpdateQueryParam>
{

}

abstract class UserTokenFactoryMutable implements
  PersistantStorageModifiable<UserToken, UserTokenFactoryUpdateQueryParam, UserTokenFactorySearchClearParam>
{

}