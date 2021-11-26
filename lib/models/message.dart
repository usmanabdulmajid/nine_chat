import 'dart:convert';

class Message {
  int? id;
  int? editId;
  int? replyIndex;
  String? from;
  String? to;
  String? content;
  DateTime? date;

  Message({
    this.id,
    this.editId,
    this.replyIndex,
    this.from,
    this.to,
    this.content,
    this.date,
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
        date: json['date']);
  }

  factory Message.fromSource(String source) =>
      Message.fromJson(jsonDecode(source));

  Message copywith({
    int? id,
    int? editId,
    int? replyIndex,
    String? from,
    String? to,
    String? content,
    DateTime? date,
  }) {
    return Message(
      id: id ?? this.id,
      editId: editId ?? this.editId,
      replyIndex: replyIndex ?? this.replyIndex,
      from: from ?? this.from,
      to: to ?? this.to,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
