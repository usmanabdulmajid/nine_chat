import 'dart:convert';
import 'package:nine_chat/utils/enums/message_type.dart';
import 'message_status.dart';

class Message {
  String? id;
  String? editId;
  int? replyIndex;
  String? from;
  String? to;
  String? content;
  DateTime? date;
  MessageType? messageType;
  MessageStatus? messageStatus;

  Message({
    this.id,
    this.editId,
    this.replyIndex,
    this.from,
    this.to,
    this.content,
    this.date,
    this.messageType,
    this.messageStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'editId': editId,
      'replyIndex': replyIndex,
      'from': from,
      'to': to,
      'content': content,
      'date': date,
      'messageType': messageType!.name,
      'messageStatus': messageStatus.toString(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        editId: json['editId'],
        replyIndex: json['replyIndex'],
        from: json['from'],
        to: json['to'],
        content: json['content'],
        date: json['date'],
        messageType: ParseMessageType.fromString(json['messageType']),
        messageStatus: MessageStatus.fromSource(json['messageStatus']));
  }

  factory Message.fromSource(String source) =>
      Message.fromJson(jsonDecode(source));

  Message copywith({
    String? id,
    String? editId,
    int? replyIndex,
    String? from,
    String? to,
    String? content,
    DateTime? date,
    MessageType? messageType,
    MessageStatus? messageStatus,
  }) {
    return Message(
      id: id ?? this.id,
      editId: editId ?? this.editId,
      replyIndex: replyIndex ?? this.replyIndex,
      from: from ?? this.from,
      to: to ?? this.to,
      content: content ?? this.content,
      date: date ?? this.date,
      messageType: messageType ?? this.messageType,
      messageStatus: messageStatus ?? this.messageStatus,
    );
  }
}
