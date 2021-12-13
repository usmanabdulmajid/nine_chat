import 'dart:convert';
import 'package:nine_chat/utils/enums/message_status_type.dart';

class MessageStatus {
  final String id;
  final String messageId;
  final String to;
  final MessageStatusType messageStatusType;

  MessageStatus({
    required this.id,
    required this.messageId,
    required this.to,
    required this.messageStatusType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messageId': messageId,
      'to': to,
      'messageStatueType': messageStatusType.name
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  factory MessageStatus.fromJson(Map<String, dynamic> json) {
    return MessageStatus(
        id: json['id'],
        messageId: json['message_id'],
        to: json['to'],
        messageStatusType:
            ParseMessageStatusType.fromString(json['message_status_type']));
  }

  factory MessageStatus.fromSource(String source) =>
      MessageStatus.fromJson(jsonDecode(source));
}
