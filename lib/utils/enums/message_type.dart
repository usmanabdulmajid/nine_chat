enum MessageType { text, audio, video, image }

extension ParseMessageType on MessageType {
  static MessageType fromString(String type) {
    MessageType messageType =
        MessageType.values.firstWhere((element) => element.name == type);
    return messageType;
  }
}
