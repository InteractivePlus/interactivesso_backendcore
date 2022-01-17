import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

part 'userinfofactory.g.dart';

@JsonSerializable(includeIfNull: false)
class UserInfoFactoryCreateInfo implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'user_group')
  String belongedGroupId;

  @JsonKey(required: true, name: 'username')
  String username;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(required: true, name: 'email_verified')
  bool emailVerified;

  @JsonKey(name: 'phone')
  @NullablePhoneNumberConverter()
  PhoneNumber? phoneNumber;

  @JsonKey(required: true, name: 'phone_verified')
  bool phoneVerified;

  @JsonKey(required: true, name: 'account_status', fromJson: AccountStatus.fromJson, toJson: Serializable.convertToDynamicSerialized)
  AccountStatus accountStatus;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'password_hash')
  String? passwordHash;

  @JsonKey(name: 'area')
  String? areaAlpha2Code;

  @JsonKey(name: 'locale')
  String? localeCode;

  @JsonKey(name: 'avatar_hash')
  String? avatarHash;

  @JsonKey(required: true, name:'account_create_info', fromJson: AccountCreateInfo.fromJson, toJson: Serializable.convertToDynamicSerialized)
  AccountCreateInfo accountCreateInfo;

  @JsonKey(required: true, name:'permission')
  UserPermissionInfo permissionOverride;

  @JsonKey(ignore: true)
  String get displayName => nickname ?? username;

  @override
  Map<String, dynamic> serialize([String? locale]) => _$UserInfoFactoryCreateInfoToJson(this);

  @override
  Map<String, dynamic> toJson() => serialize(null);

  UserInfoFactoryCreateInfo({
    required this.belongedGroupId,
    required this.username, 
    this.email, 
    this.phoneNumber, 
    required this.accountCreateInfo,
    required this.permissionOverride,
    this.passwordHash,
    required this.accountStatus, 
    this.emailVerified = false,
    this.phoneVerified = false,
    this.nickname,
    this.signature,
    this.areaAlpha2Code,
    this.localeCode
  });

  factory UserInfoFactoryCreateInfo.fromMap(Map<String,dynamic> map) => _$UserInfoFactoryCreateInfoFromJson(map);

  static UserInfoFactoryCreateInfo fromJson(Map<String,dynamic> json) => UserInfoFactoryCreateInfo.fromMap(json);
  static UserInfoFactoryCreateInfo? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

///UserUniqueId
typedef UserInfoFactoryUpdateQueryParam = String;

@JsonSerializable(includeIfNull: false)
class UserInfoFactorySearchClearParam implements Serializable<Map<String,dynamic>>{
  @JsonKey(name: 'username')
  String? usernamePartial;

  @JsonKey(name: 'user_group')
  String? belongedGroupId;

  @JsonKey(name: 'email')
  String? emailPartial;

  @JsonKey(name: 'phone')
  String? phonePartial;

  @JsonKey(name: 'nickname')
  String? nicknamePartial;

  @JsonKey(name: 'signature')
  String? signaturePartial;

  @JsonKey(name: 'area')
  String? areaAlpha2Code;

  @JsonKey(name: 'locale')
  String? localeCode;

  @JsonKey(name: 'display_name')
  String? displaynamePartial;

  @override
  Map<String,dynamic> serialize([String? locale]) => _$UserInfoFactorySearchClearParamToJson(this);
  @override
  Map<String,dynamic> toJson() => serialize(null);

  UserInfoFactorySearchClearParam({this.usernamePartial, this.belongedGroupId, this.emailPartial, this.phonePartial, this.nicknamePartial, this.displaynamePartial, this.signaturePartial, this.areaAlpha2Code, this.localeCode});
  factory UserInfoFactorySearchClearParam.fromMap(Map<String,dynamic> map) => _$UserInfoFactorySearchClearParamFromJson(map);
  static UserInfoFactorySearchClearParam fromJson(Map<String,dynamic> json) => UserInfoFactorySearchClearParam.fromMap(json);
  static UserInfoFactorySearchClearParam? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);
}

abstract class UserInfoFactory implements 
  PersistantStorageCreatable<UserInfo,UserInfoFactoryCreateInfo>, 
  PersistantStorageModifiable<UserInfo,UserInfoFactoryUpdateQueryParam,UserInfoFactorySearchClearParam>, 
  PersistantStorageFetchable<UserInfo,UserInfoFactoryUpdateQueryParam>,
  PersistantStorageSearchable<UserInfo, UserInfoFactorySearchClearParam>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  Future<UserInfo?> fetchFromRepoByUsername(String username);
  Future<bool> doesExistByUsername(String username);
  Future<UserInfo?> fetchFromRepoByEmail(String email);
  Future<bool> doesExistByEmail(String email);
  Future<UserInfo?> fetchFromRepoByPhoneNumber(PhoneNumber phoneNum);
  Future<bool> doesExistByPhoneNumber(PhoneNumber phoneNum);
  Future<void> migrateAllUserUnderGroupToNewGroup(String groupId, String newGroupId);
  Future<UserPermissionInfo?> getUserPermissionOverride(UserInfoFactoryUpdateQueryParam queryParam);
  Future<int> searchAvatarHashReferenceCount(String avatarHash);
  Future<SearchResult<UserInfo>> searchUnverifiedUsers(int? createTimeMin, int? createTimeMax, {int offset = 0, int limit = -1});
  Future<int> getTotalUnverifiedUsers(int? createTimeMin, int? createTimeMax);
  Future<void> clearUnverifiedUsers(int? createTimeMin, int? createTimeMax, {int offset = 0, int limit = -1});
}