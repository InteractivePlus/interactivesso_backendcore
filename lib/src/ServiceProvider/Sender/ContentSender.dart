
import 'package:interactivesso_datatypes/interactivesso_datatypes.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

abstract class ContentSender<ReceiveAddressType, ContentType>{
  Future<void> sendContent(ReceiveAddressType recipient, ContentType content);
  Future<void> sendContentToUser(UserInfo user, ContentType content);
}

typedef EmailSender = ContentSender<String, String>;
typedef SMSSender = ContentSender<PhoneNumber, String>;
typedef PhoneCallSender = ContentSender<PhoneNumber, String>;