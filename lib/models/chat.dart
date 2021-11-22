import 'dart:convert';

class Chat {
  String? id;
  String? chatId;
  String? chatName;
  String? imageUrl;
  String? lastmessage;

  Chat({
    this.id,
    this.chatId,
    this.chatName,
    this.imageUrl,
    this.lastmessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'chatName': chatName,
      'imageUrl': imageUrl,
      'lastmessage': lastmessage,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        id: json['id'],
        chatId: json['chatId'],
        chatName: json['chatName'],
        imageUrl: json['imageUrl'],
        lastmessage: json['lastmessage']);
  }

  factory Chat.fromSource(String source) => Chat.fromJson(jsonDecode(source));

  Chat copywith(
    String? id,
    String? chatId,
    String? chatName,
    String? imageUrl,
    String? lastmessage,
  ) {
    return Chat(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      chatName: chatName ?? this.chatName,
      imageUrl: imageUrl ?? this.imageUrl,
      lastmessage: lastmessage ?? this.lastmessage,
    );
  }
}
