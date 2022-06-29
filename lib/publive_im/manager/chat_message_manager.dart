import 'package:flutter_publive/publive_im/listener/chat_message_listener.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

class ChatMessageManager implements EMChatManagerListener {
  final List<ChatMessageListener> _messageListeners = [];

  ChatMessageManager.init() {
    EMClient.getInstance.chatManager.removeChatManagerListener(this);
    EMClient.getInstance.chatManager.addChatManagerListener(this);
  }

  void addListener(ChatMessageListener listener) {
    if (!_messageListeners.contains(listener)) {
      _messageListeners.add(listener);
    }
  }

  void removeListener(ChatMessageListener listener) {
    if (_messageListeners.contains(listener)) {
      _messageListeners.remove(listener);
    }
  }



  /* ============================ ChatManagerListener ============================*/
  @override
  void onCmdMessagesReceived(List<EMMessage> messages) {
    for (var listener in _messageListeners) {
      listener.onCmdMessagesReceived(messages);
    }
  }

  @override
  void onConversationRead(String from, String to) {
    for (var listener in _messageListeners) {
      listener.onConversationRead(from, to);
    }
  }

  @override
  void onConversationsUpdate() {
    for (var listener in _messageListeners) {
      listener.onConversationsUpdate();
    }
  }

  @override
  void onGroupMessageRead(List<EMGroupMessageAck> groupMessageAcks) {
    for (var listener in _messageListeners) {
      listener.onGroupMessageRead(groupMessageAcks);
    }
  }

  @override
  void onMessagesDelivered(List<EMMessage> messages) {
    for (var listener in _messageListeners) {
      listener.onMessagesDelivered(messages);
    }
  }

  @override
  void onMessagesRead(List<EMMessage> messages) {
    for (var listener in _messageListeners) {
      listener.onMessagesRead(messages);
    }
  }

  @override
  void onMessagesRecalled(List<EMMessage> messages) {
    for (var listener in _messageListeners) {
      listener.onMessagesRecalled(messages);
    }
  }

  @override
  void onMessagesReceived(List<EMMessage> messages) {
    for (var listener in _messageListeners) {
      listener.onMessagesReceived(messages);
    }
  }

  void _messageSendSuccess(EMMessage message) {
    for (var listener in _messageListeners) {
      listener.onMessageSendSuccess(message);
    }
  }
}
