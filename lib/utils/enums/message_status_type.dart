enum MessageStatusType { pending, sent, deliverd, read }

extension ParseMessageStatusType on MessageStatusType {
  static MessageStatusType fromString(String status) {
    MessageStatusType messageStatus = MessageStatusType.values
        .firstWhere((element) => element.name == status);
    return messageStatus;
  }
}
