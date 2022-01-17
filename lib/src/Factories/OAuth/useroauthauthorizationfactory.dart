
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'useroauthauthorizationfactory.g.dart';

@JsonSerializable()
class UserOAuthAuthorizationFactoryFetchParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'client_id')
  String appClientId;
  @JsonKey(required: true, name: 'user_unique_id')
  String userUniqueId;
  UserOAuthAuthorizationFactoryFetchParam({
    required this.appClientId,
    required this.userUniqueId
  });
  factory UserOAuthAuthorizationFactoryFetchParam.fromMap(Map<String,dynamic> serialized) => _$UserOAuthAuthorizationFactoryFetchParamFromJson(serialized);
  static UserOAuthAuthorizationFactoryFetchParam fromJson(Map<String,dynamic> json) => UserOAuthAuthorizationFactoryFetchParam.fromMap(json);
  static UserOAuthAuthorizationFactoryFetchParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserOAuthAuthorizationFactoryFetchParamToJson(this);
  @override
  Map<String, dynamic> serialize([String? locale]) => toJson();
}

@JsonSerializable(includeIfNull: false)
class UserOAuthAuthorizationFactorySearchParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'client_id')
  String? searchClientId;
  @JsonKey(name: 'user_unique_id')
  String? searchUserUniqueId;
  @JsonKey(name: 'custom_role')
  int? searchCustomRole;
  UserOAuthAuthorizationFactorySearchParam({
    this.searchClientId,
    this.searchUserUniqueId,
    this.searchCustomRole
  });
  factory UserOAuthAuthorizationFactorySearchParam.fromMap(Map<String,dynamic> serialized) => _$UserOAuthAuthorizationFactorySearchParamFromJson(serialized);
  static UserOAuthAuthorizationFactorySearchParam fromJson(Map<String,dynamic> json) => UserOAuthAuthorizationFactorySearchParam.fromMap(json);
  static UserOAuthAuthorizationFactorySearchParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
  @override
  Map<String,dynamic> toJson() => _$UserOAuthAuthorizationFactorySearchParamToJson(this);
  @override
  Map<String, dynamic> serialize([String? locale]) => toJson();
}

abstract class UserOAuthAuthorizationFactory implements
  PersistantStorageCreatable<UserOAuthAuthorization, UserOAuthAuthorization>,
  PersistantStorageFetchable<UserOAuthAuthorization, UserOAuthAuthorizationFactoryFetchParam>,
  PersistantStorageSearchable<UserOAuthAuthorization, UserOAuthAuthorizationFactorySearchParam>,
  PersistantStorageModifiable<UserOAuthAuthorization, UserOAuthAuthorizationFactoryFetchParam, UserOAuthAuthorizationFactorySearchParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  
}

