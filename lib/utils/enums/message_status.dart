enum MessageStatus { pending, sent, deliverd, read }

extension ParseMessageStatus on MessageStatus {
  String value() {
    return toString().split('.').last;
  }

  static MessageStatus fromString(String status) {
    MessageStatus messageStatus =
        MessageStatus.values.firstWhere((element) => element.value() == status);
    return messageStatus;
  }
}
