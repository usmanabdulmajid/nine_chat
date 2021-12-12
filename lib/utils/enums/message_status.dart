enum MessageStatus { pending, sent, deliverd, read }

extension ParseMessageStatus on MessageStatus {
  static MessageStatus fromString(String status) {
    MessageStatus messageStatus =
        MessageStatus.values.firstWhere((element) => element.name == status);
    return messageStatus;
  }
}
