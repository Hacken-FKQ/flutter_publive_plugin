import 'package:flutter/foundation.dart';
import 'package:flutter_publive/publive_im/manager/chat_message_manager.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

class ChatManager {
  static final ChatManager _instance = ChatManager._init();
  // //连接状态管理器
  // static final ChatConnectionManager connectionManager =
  //     ChatConnectionManager.init();
  // //联系人管理器
  // static final ChatContactManager contactManager = ChatContactManager.init();
  // //聊天房间管理器
  // static final ChatRoomManager chatRoomManager = ChatRoomManager.init();
  // //群组管理器
  // static final ChatGroupManager groupManager = ChatGroupManager.init();
  // //用户相关管理器
  // static final ChatUserManager userManager = ChatUserManager.init();
  // //会话管理器
  // static final ChatConversationManager conversationManager =
  //     ChatConversationManager.init();
  // //聊天消息管理器
  static final ChatMessageManager messageManager = ChatMessageManager.init();
  factory ChatManager() {
    return _instance;
  }
  ChatManager._init() {}

  static Future<bool> configure(String? appKey) async {
    if (kIsWeb) {
      return true;
    }
    if (appKey == null) {
      return false;
    }
    try {
      if (EMClient.getInstance.options != null) {
        await EMClient.getInstance.changeAppKey(newAppKey: appKey);
      } else {
        final options =
            EMOptions(appKey: appKey, autoLogin: false, debugModel: true);
        await EMClient.getInstance.init(options);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> createAccount(String username, String password) async {
    await EMClient.getInstance.createAccount(username, password);
  }

  Future<void> login(String username, String pwdOrToken,
      [bool isPassword = true]) async {
    await EMClient.getInstance.login(username, pwdOrToken, isPassword);
  }

  Future<void> logout([
    bool unbindDeviceToken = true,
  ]) async {
    await EMClient.getInstance.logout(unbindDeviceToken);
  }

  EMMessage createTxtSendMessage({
    required String username,
    required String content,
  }) {
    return EMMessage.createTxtSendMessage(
      username: username,
      content: content,
    );
  }

  Future<EMMessage> sendMessage(EMMessage message) async {
    return EMClient.getInstance.chatManager.sendMessage(message);
  }

  sendMsg() {
    var msg = EMMessage.createTxtSendMessage(
      username: 'fkq1',
      content: 'fkqlllcontent',
    );
    msg.setMessageStatusCallBack(MessageStatusCallBack(
      onSuccess: () {
        print("send message: ---");
      },
      onError: (e) {
        print(
          "send message failed, code: ${e.code}, desc: ${e.description}",
        );
      },
    ));
    EMClient.getInstance.chatManager.sendMessage(msg);
  }


}
