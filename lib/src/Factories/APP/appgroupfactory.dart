
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appgroupfactory.g.dart';

typedef APPGroupFactoryCreateInfo = APPGroupInfo;

///GroupId
typedef APPGroupFactoryUpdateQueryParam = String;

@JsonSerializable(includeIfNull: false)
class APPGroupFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'group_id')
  String? groupIdPartial;

  @JsonKey(name: 'display_name')
  String? displayNamePartial;

  @JsonKey(name: 'description')
  String? descriptionPartial;

  @JsonKey(name:'is_normal_app')
  bool? isNormalAPPFilter;

  APPGroupFactorySearchClearParam({
    this.groupIdPartial,
    this.displayNamePartial,
    this.descriptionPartial,
    this.isNormalAPPFilter
  });
  factory APPGroupFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$APPGroupFactorySearchClearParamFromJson(map);
  static APPGroupFactorySearchClearParam fromJson(Map<String,dynamic> json) => APPGroupFactorySearchClearParam.fromMap(json);
  static APPGroupFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);


  @override
  Map<String, dynamic> serialize([String? locale]) => _$APPGroupFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class APPGroupFactory implements
  PersistantStorageCreatable<APPGroupInfo,APPGroupFactoryCreateInfo>,
  PersistantStorageSearchable<APPGroupInfo, APPGroupFactoryUpdateQueryParam, APPGroupFactorySearchClearParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<String?> getDefaultGroupId();
  Future<APPPermissionInfo?> fetchAPPGroupPermissionOverride(APPGroupFactoryUpdateQueryParam queryParam);
}

abstract class APPGroupFactoryMutable implements
  PersistantStorageModifiable<APPGroupInfo, APPGroupFactoryUpdateQueryParam, APPGroupFactorySearchClearParam>
{
  Future<void> setDefaultGroupId(String? groupId);
}