import 'dart:convert';

class Message {
  int? id;
  int? editId;
  int? messageId;
  String? from;
  String? to;
  String? content;
  DateTime? date;

  Message({
    this.id,
    this.editId,
    this.messageId,
    this.from,
    this.to,
    this.content,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'editId': editId,
      'messageId': messageId,
      'from': from,
      'to': to,
      'content': content,
      'date': date,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        editId: json['editId'],
        messageId: json['messageId'],
        from: json['from'],
        to: json['to'],
        content: json['content'],
        date: json['date']);
  }

  factory Message.fromSource(String source) =>
      Message.fromJson(jsonDecode(source));

  Message copywith({
    int? id,
    int? editId,
    int? messageId,
    String? from,
    String? to,
    String? content,
    DateTime? date,
  }) {
    return Message(
      id: id ?? this.id,
      editId: editId ?? this.editId,
      messageId: messageId ?? this.messageId,
      from: from ?? this.from,
      to: to ?? this.to,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
