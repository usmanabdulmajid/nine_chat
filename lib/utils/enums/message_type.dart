enum MessageType { text, audio, video, image }

extension ParseMessageType on MessageType {
  String value() {
    return toString().split('.').last;
  }

  static MessageType fromString(String type) {
    MessageType messageType =
        MessageType.values.firstWhere((element) => element.value() == type);
    return messageType;
  }
}
