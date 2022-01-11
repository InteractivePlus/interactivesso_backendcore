
import 'package:json_annotation/json_annotation.dart';

import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

part 'oauthvericodefactory.g.dart';

@JsonSerializable()
class OAuthVeriCodeFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'is_short_id')
  bool isShortId;
  
  @JsonKey(required: true, name: 'user_unique_id')
  String userUniqueId;

  @JsonKey(required: true, name: 'client_id')
  String appClientId;

  @JsonKey(required: true, name: 'expires')
  ExpirableInfo expires;

  @JsonKey(name: 'sent_method', toJson: Serializable.convertToDynamicSerializedWithNullable, fromJson: CommunicationMethod.fromJsonNullable)
  CommunicationMethod? sentMethod;

  @JsonKey(name: 'use_scope')
  String? useScope;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$OAuthVeriCodeFactoryCreateInfoToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  OAuthVeriCodeFactoryCreateInfo({required this.isShortId, required this.userUniqueId, required this.appClientId, required this.expires, this.sentMethod, this.useScope});
  factory OAuthVeriCodeFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$OAuthVeriCodeFactoryCreateInfoFromJson(map);
  static OAuthVeriCodeFactoryCreateInfo fromJson(Map<String,dynamic> json) => OAuthVeriCodeFactoryCreateInfo.fromMap(json);
  static OAuthVeriCodeFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json){
    if(json == null){
      return null;
    }else{
      return fromJson(json);
    }
  }
}

@JsonSerializable()
class OAuthVericodeFactoryUpdateQueryParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(required:true, name:'is_short_id')
  bool isShortId;

  @JsonKey(required:true, name:'vericode_id')
  String veriCodeId;

  @override
  Map<String, dynamic> serialize([String? locale]) => _$OAuthVericodeFactoryUpdateQueryParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);

  OAuthVericodeFactoryUpdateQueryParam({
    required this.isShortId,
    required this.veriCodeId
  });
  factory OAuthVericodeFactoryUpdateQueryParam.fromMap(Map<String,dynamic> map) => _$OAuthVericodeFactoryUpdateQueryParamFromJson(map);
  static OAuthVericodeFactoryUpdateQueryParam fromJson(Map<String,dynamic> json) => OAuthVericodeFactoryUpdateQueryParam.fromMap(json);
  static OAuthVericodeFactoryUpdateQueryParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

@JsonSerializable(includeIfNull: false)
class OAuthVericodeFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'is_short_id')
  bool? isShortIdFilter;
  
  @JsonKey(name: 'user_unique_id')
  String? userUniqueId;

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

  @JsonKey(name: 'sent_method', toJson: Serializable.convertToDynamicSerializedWithNullable, fromJson: CommunicationMethod.fromJsonNullable)
  CommunicationMethod? sentMethodFilter;

  @JsonKey(name: 'use_scope')
  String? useScopePartial;

  OAuthVericodeFactorySearchClearParam({
    this.isShortIdFilter,
    this.userUniqueId,
    this.appClientId,
    this.createTimeMin,
    this.createTimeMax,
    this.expireTimeMin,
    this.expireTimeMax,
    this.sentMethodFilter,
    this.useScopePartial
  });
  factory OAuthVericodeFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$OAuthVericodeFactorySearchClearParamFromJson(map);
  static OAuthVericodeFactorySearchClearParam fromJson(Map<String,dynamic> json) => OAuthVericodeFactorySearchClearParam.fromMap(json);
  static OAuthVericodeFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$OAuthVericodeFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class OAuthVeriCodeFactory implements
  PersistantStorageCreatable<OAuthVeriCode, OAuthVeriCodeFactoryCreateInfo>,
  PersistantStorageModifiable<OAuthVeriCode, OAuthVericodeFactoryUpdateQueryParam, OAuthVericodeFactorySearchClearParam>,
  PersistantStorageSearchable<OAuthVeriCode, OAuthVericodeFactoryUpdateQueryParam, OAuthVericodeFactorySearchClearParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<bool> verifyVeriCode(String vericodeId, bool isShortId, String userUniqueId, String appClientId, int currentTime);
}