enum TypingEvent { start, stop }

extension ParseTyping on TypingEvent {
  static TypingEvent fromString(String event) {
    TypingEvent typingEvent =
        TypingEvent.values.firstWhere((element) => element.name == event);
    return typingEvent;
  }
}
