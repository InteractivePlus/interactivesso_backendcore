import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appinfofactory.g.dart';

@JsonSerializable(includeIfNull: false)
class AppInfoFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'app_group')
  String belongedAPPGroupId;

  @JsonKey(required: true, name: 'client_secret')
  String clientSecret;

  @JsonKey(required: true, name: 'display_name')
  String displayName;

  @JsonKey(required: true, name: 'description')
  String description;

  @JsonKey(required: true, name: 'permission')
  APPPermissionInfo permissionOverride;

  @JsonKey(required: true, name: 'creation_info')
  ApplicationCreationInfo creationInfo;

  @JsonKey(required: true, name: 'manage_info')
  ApplicationManagementInfo manageInfo;

  @JsonKey(name: 'avatar_hash')
  String? avatarHash;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$AppInfoFactoryCreateInfoToJson(this);

  @override
  Map<String,dynamic> toJson() => serialize(null);

  AppInfoFactoryCreateInfo({ 
    required this.clientSecret, 
    required this.displayName, 
    required this.description, 
    required this.permissionOverride, 
    required this.creationInfo, 
    required this.manageInfo,
    required this.belongedAPPGroupId
  });

  factory AppInfoFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$AppInfoFactoryCreateInfoFromJson(map);
  static AppInfoFactoryCreateInfo fromJson(Map<String,dynamic> json) => AppInfoFactoryCreateInfo.fromMap(json);
  static AppInfoFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

///client_id
typedef AppInfoFactoryUpdateQueryParam = String;

@JsonSerializable(includeIfNull: false)
class AppInfoFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'related_manage_username')
  String? searchManageUsername;

  @JsonKey(name: 'related_create_username')
  String? searchCreateUsername;

  @JsonKey(name: 'display_name')
  String? displayNamePartial;

  @JsonKey(name: 'description')
  String? descriptionPartial;
  
  @override
  Map<String, dynamic> serialize([String? locale]) => _$AppInfoFactorySearchClearParamToJson(this);
  @override
  Map<String, dynamic> toJson() => serialize(null);
  
  AppInfoFactorySearchClearParam({this.searchManageUsername,this.searchCreateUsername, this.descriptionPartial, this.displayNamePartial});
  factory AppInfoFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$AppInfoFactorySearchClearParamFromJson(map);
  static AppInfoFactorySearchClearParam fromJson(Map<String,dynamic> json) => AppInfoFactorySearchClearParam.fromMap(json);
  static AppInfoFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

abstract class AppInfoFactory implements
  PersistantStorageCreatable<ApplicationInfo,AppInfoFactoryCreateInfo>,
  PersistantStorageModifiable<ApplicationInfo,AppInfoFactoryUpdateQueryParam,AppInfoFactorySearchClearParam>,
  PersistantStorageSearchable<ApplicationInfo,AppInfoFactorySearchClearParam>,
  PersistantStorageFetchable<ApplicationInfo,AppInfoFactoryUpdateQueryParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<void> migrateAllAppUnderGroupToNewGroup(String groupId, String newGroupId);
  Future<APPPermissionInfo?> getAppPermissionOverride(AppInfoFactoryUpdateQueryParam queryParam);
}