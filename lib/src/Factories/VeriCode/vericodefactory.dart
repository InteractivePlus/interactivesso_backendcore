
import 'package:json_annotation/json_annotation.dart';

import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

part 'vericodefactory.g.dart';

@JsonSerializable()
class VeriCodeFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: "vericode_id")
  String vericodeId;

  @JsonKey(required: true, name: 'is_short_id')
  bool isShortId;

  @JsonKey(required: true, name: 'username')
  String relatedUsername;

  @JsonKey(required: true, name: 'expires')
  ExpirableInfo expires;

  @JsonKey(required: true, name: 'issue_ip')
  String issueTimeRemoteIp;

  @JsonKey(name: 'sent_method', toJson: Serializable.convertToDynamicSerializedWithNullable, fromJson: CommunicationMethod.fromJsonNullable)
  CommunicationMethod? sentMethod;

  @JsonKey(name: 'use_scope')
  String? useScope;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$VeriCodeFactoryCreateInfoToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  VeriCodeFactoryCreateInfo({required this.vericodeId, required this.isShortId, required this.relatedUsername, required this.expires, required this.issueTimeRemoteIp, required this.sentMethod, this.useScope});
  factory VeriCodeFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$VeriCodeFactoryCreateInfoFromJson(map);
  static VeriCodeFactoryCreateInfo fromJson(Map<String,dynamic> json) => VeriCodeFactoryCreateInfo.fromMap(json);
  static VeriCodeFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json){
    if(json == null){
      return null;
    }else{
      return fromJson(json);
    }
  }
}

@JsonSerializable()
class VericodeFactoryUpdateQueryParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(required:true, name:'is_short_id')
  bool isShortId;

  @JsonKey(required:true, name:'vericode_id')
  String veriCodeId;

  @override
  Map<String, dynamic> serialize([String? locale]) => _$VericodeFactoryUpdateQueryParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);

  VericodeFactoryUpdateQueryParam({
    required this.isShortId,
    required this.veriCodeId
  });
  factory VericodeFactoryUpdateQueryParam.fromMap(Map<String,dynamic> map) => _$VericodeFactoryUpdateQueryParamFromJson(map);
  static VericodeFactoryUpdateQueryParam fromJson(Map<String,dynamic> json) => VericodeFactoryUpdateQueryParam.fromMap(json);
  static VericodeFactoryUpdateQueryParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

@JsonSerializable(includeIfNull: false)
class VericodeFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'is_short_id')
  bool? isShortIdFilter;
  
  @JsonKey(name: 'user_unique_id')
  String? userUniqueId;

  @JsonKey(name: 'create_time_min')
  int? createTimeMin;

  @JsonKey(name: 'create_time_max')
  int? createTimeMax;

  @JsonKey(name: 'expire_time_min')
  int? expireTimeMin;

  @JsonKey(name: 'expire_time_max')
  int? expireTimeMax;

  @JsonKey(name: 'issue_ip')
  String? issueTimeRemoteIpPartial;

  @JsonKey(name: 'sent_method', toJson: Serializable.convertToDynamicSerializedWithNullable, fromJson: CommunicationMethod.fromJsonNullable)
  CommunicationMethod? sentMethodFilter;

  @JsonKey(name: 'use_scope')
  String? useScopePartial;

  VericodeFactorySearchClearParam({
    this.isShortIdFilter,
    this.userUniqueId,
    this.createTimeMin,
    this.createTimeMax,
    this.expireTimeMin,
    this.expireTimeMax,
    this.issueTimeRemoteIpPartial,
    this.sentMethodFilter,
    this.useScopePartial
  });
  factory VericodeFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$VericodeFactorySearchClearParamFromJson(map);
  static VericodeFactorySearchClearParam fromJson(Map<String,dynamic> json) => VericodeFactorySearchClearParam.fromMap(json);
  static VericodeFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$VericodeFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class VeriCodeFactory implements
  PersistantStorageCreatable<VerificationCode, VeriCodeFactoryCreateInfo>,
  PersistantStorageModifiable<VerificationCode, VericodeFactoryUpdateQueryParam, VericodeFactorySearchClearParam>,
  PersistantStorageSearchable<VerificationCode, VericodeFactoryUpdateQueryParam, VericodeFactorySearchClearParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<bool> verifyVeriCode(String vericodeId, bool isShortId, String userUniqueId, int currentTime);
}