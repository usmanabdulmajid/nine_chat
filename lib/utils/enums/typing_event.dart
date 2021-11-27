enum TypingEvent { start, stop }

extension ParseTyping on TypingEvent {
  String value() {
    return toString().split('.').last;
  }

  static TypingEvent fromString(String event) {
    TypingEvent typingEvent =
        TypingEvent.values.firstWhere((element) => element.value() == event);
    return typingEvent;
  }
}
