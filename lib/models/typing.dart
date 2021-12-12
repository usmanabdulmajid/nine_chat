import 'package:nine_chat/utils/enums/typing_event.dart';

class Typing {
  final String id;
  final String from;
  final String to;
  final TypingEvent typingEvent;
  Typing({
    required this.id,
    required this.from,
    required this.to,
    required this.typingEvent,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'from': from, 'to': to, 'typingEvent': typingEvent.name};
  }

  factory Typing.fromJson(Map<String, dynamic> json) {
    return Typing(
        id: json['id'],
        from: json['from'],
        to: json['to'],
        typingEvent: ParseTyping.fromString(json['typingEvent']));
  }
}
