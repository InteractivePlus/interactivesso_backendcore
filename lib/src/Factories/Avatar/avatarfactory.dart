
import 'dart:convert';
import 'dart:math';

import 'package:image/image.dart';
import 'package:interactiveplus_shared_dart/interactiveplus_shared_dart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';

part 'avatarfactory.g.dart';

@JsonSerializable()
class AvatarFactoryCreateType implements Serializable<Map<String,dynamic>>{
  @JsonKey(required: true, name: 'encoded_data', toJson: base64Encode, fromJson: base64Decode)
  List<int> anyFormatEncoded;
  
  AvatarFactoryCreateType({required this.anyFormatEncoded});
  factory AvatarFactoryCreateType.fromMap(Map<String,dynamic> map) => _$AvatarFactoryCreateTypeFromJson(map);
  static AvatarFactoryCreateType fromJson(Map<String,dynamic> json) => AvatarFactoryCreateType.fromMap(json);
  static AvatarFactoryCreateType? fromJsonNullable(Map<String,dynamic>? json) => json == null ? null : fromJson(json);

  @override
  Map<String, dynamic> serialize([String? locale]) => _$AvatarFactoryCreateTypeToJson(this);
  @override
  Map<String, dynamic> toJson() => serialize(null);
}

///AvatarHash
typedef AvatarFactoryUpdateQueryParam = String;

abstract class AvatarFactory implements
  PersistantStorageCreatable<AvatarInfo,AvatarFactoryCreateType>,
  PersistantStorageFetchable<AvatarInfo, AvatarFactoryUpdateQueryParam>,
  PersistantStorageModifiable<AvatarInfo, AvatarFactoryUpdateQueryParam, void>,
  PersistantStorageInstallable,
  PersistantStorageUninstallable
{
  final int oneSidePixelLimit;
  final int pngCompressionLevel;

  ///pngCompression Level from [0,9] => 9 being very very compressed.
  AvatarFactory({required this.oneSidePixelLimit, this.pngCompressionLevel = 6});
  
  String hashFunc(List<int> pngEncoded);

  Future<int> getTotalStoredAvatars();
  Future<SearchResult<String>> listExistingAvatarHashs({int offset = 0, int? limit});
  @override
  Future<AvatarInfo> createNew(AvatarFactoryCreateType createInfo) async {
    late AvatarInfo avatarInfo;
    late String hash;
    late List<int> pngEncoded;

    {
      Image? decodedImage = decodeImage(createInfo.anyFormatEncoded);
      if(decodedImage == null){
        throw InnerParseException(([locale]) => 'Could not parse image.', SingleItemRelatedParams(item: 'createInfo'));
      }
      

      if(decodedImage.width > oneSidePixelLimit || decodedImage.height > oneSidePixelLimit){
        decodedImage = copyResizeCropSquare(decodedImage, oneSidePixelLimit);
      }else if(decodedImage.width != decodedImage.height){
        decodedImage = copyResizeCropSquare(decodedImage, min(decodedImage.width, decodedImage.height));
      }
      pngEncoded = encodePng(decodedImage,level: pngCompressionLevel);
      hash = hashFunc(pngEncoded);
      avatarInfo = AvatarInfoWithRawData(avatarHash: hash, pngEncoded: pngEncoded, sizePx: decodedImage.width);
    }
    if(await doesExist(hash)){
      throw ItemAlreadyExistException(([locale]) => 'Avatar already exists.', SingleItemRelatedParams(item: 'createInfo'));
    }
    return await _uploadAvatar(avatarInfo);
  }
  Future<AvatarInfo> _uploadAvatar(AvatarInfo avatar);
}