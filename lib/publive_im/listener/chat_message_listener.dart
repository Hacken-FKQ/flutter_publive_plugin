import 'package:im_flutter_sdk/im_flutter_sdk.dart';

abstract class ChatMessageListener {
  void onMessagesReceived(List<EMMessage> messages) {
  }

  void onCmdMessagesReceived(List<EMMessage> messages) {
  }

  void onMessagesRead(List<EMMessage> messages) {
  }

  void onGroupMessageRead(List<EMGroupMessageAck> groupMessageAcks) {
  }

  void onMessagesDelivered(List<EMMessage> messages) {
  }

  void onMessagesRecalled(List<EMMessage> messages) {
  }

  void onConversationsUpdate() {
  }

  void onConversationRead(String from, String to) {
  }

  void onMessageSendSuccess(EMMessage message) {
  }
}
