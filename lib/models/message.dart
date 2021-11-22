import 'dart:convert';

class Message {
  String? id;
  String? from;
  String? to;
  String? content;
  DateTime? date;

  Message({
    this.id,
    this.from,
    this.to,
    this.content,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
        from: json['from'],
        to: json['to'],
        content: json['content'],
        date: json['date']);
  }

  factory Message.fromSource(String source) =>
      Message.fromJson(jsonDecode(source));

  Message copywith({
    String? id,
    String? from,
    String? to,
    String? content,
    DateTime? date,
  }) {
    return Message(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
