
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usergroupfactory.g.dart';

typedef UserGroupFactoryCreateInfo = UserGroupInfo;

///GroupId
typedef UserGroupFactoryUpdateQueryParam = String;

@JsonSerializable(includeIfNull: false)
class UserGroupFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'group_id')
  String? groupIdPartial;
  
  @JsonKey(name: 'display_name')
  String? displayNamePartial;
  
  @JsonKey(name: 'description')
  String? descriptionPartial;
  
  @JsonKey(name: 'is_normal_user')
  bool? isNormalUserFilter;

  UserGroupFactorySearchClearParam({
    this.groupIdPartial,
    this.displayNamePartial,
    this.descriptionPartial,
    this.isNormalUserFilter
  });

  factory UserGroupFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$UserGroupFactorySearchClearParamFromJson(map);
  static UserGroupFactorySearchClearParam fromJson(Map<String,dynamic> json) => UserGroupFactorySearchClearParam.fromMap(json);
  static UserGroupFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$UserGroupFactorySearchClearParamToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);
}

abstract class UserGroupFactory implements
  PersistantStorageSearchable<UserGroupInfo, UserGroupFactorySearchClearParam>,
  PersistantStorageFetchable<UserGroupInfo, UserGroupFactoryUpdateQueryParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<String?> getDefaultGroupId();
  Future<UserPermissionInfo?> fetchUserGroupPermissionOverride(UserGroupFactoryUpdateQueryParam queryParam);
}

abstract class UserGroupFactoryMutable implements
  PersistantStorageCreatable<UserGroupInfo, UserGroupFactoryCreateInfo>,
  PersistantStorageModifiable<UserGroupInfo, UserGroupFactoryUpdateQueryParam, UserGroupFactorySearchClearParam>
{
  Future<void> setDefaultGroup(String? groupId);
}