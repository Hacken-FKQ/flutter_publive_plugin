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


  ///
  /// Initializes the SDK.
  ///
  /// Param [options] The configurations: {@link EMOptions}. Ensure that you set this parameter.
  ///
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

  ///
  /// Register a new user.
  ///
  /// Param [username] The username. The maximum length is 64 characters. Ensure that you set this parameter.
  /// Supported characters include the 26 English letters (a-z), the ten numbers (0-9), the underscore (_), the hyphen (-),
  /// and the English period (.). This parameter is case insensitive, and upper-case letters are automatically changed to low-case ones.
  /// If you want to set this parameter as a regular expression, set it as ^[a-zA-Z0-9_-]+$.
  ///
  /// Param [password] The password. The maximum length is 64 characters. Ensure that you set this parameter.
  ///
  /// **Throws**  A description of the exception. See {@link EMError}.
  ///
  Future<void> createAccount(String username, String password) async {
    await EMClient.getInstance.createAccount(username, password);
  }

  ///
  /// An app user logs in to the chat server with a password or token.
  ///
  /// Param [username] The username.
  ///
  /// Param [pwdOrToken] The password or token.
  ///
  /// Param [isPassword] Whether to log in with password or token.
  /// `true`: (default) Log in with password.
  /// `false`: Log in with token.
  ///
  /// **Throws**  A description of the exception. See {@link EMError}.
  ///
  Future<void> login(String username, String pwdOrToken,
      [bool isPassword = true]) async {
    await EMClient.getInstance.login(username, pwdOrToken, isPassword);
  }

  ///
  /// An app user logs out.
  ///
  /// Param [unbindDeviceToken] Whether to unbind the token when logout.
  ///
  /// `true` (default) Yes.
  /// `false` No.
  ///
  /// **Throws**  A description of the exception. See {@link EMError}.
  ///
  Future<void> logout([
    bool unbindDeviceToken = true,
  ]) async {
    await EMClient.getInstance.logout(unbindDeviceToken);
  }

  ///
  /// Creates a text message for sending.
  ///
  /// Param [username] The ID of the message recipient.
  /// - For a one-to-one chat, it is the username of the peer user.
  /// - For a group chat, it is the group ID.
  /// - For a chat room, it is the chat room ID.
  ///
  /// Param [content] The text content.
  ///
  /// **Return** The message instance.
  ///
  EMMessage createTxtSendMessage({
    required String username,
    required String content,
  }) {
    return EMMessage.createTxtSendMessage(
      username: username,
      content: content,
    );
  }

  ///
  /// Sends a message.
  ///
  /// **Note**
  /// For attachment messages such as voice, image, or video messages, the SDK automatically uploads the attachment.
  /// You can set whether to upload the attachment to the chat sever using {@link EMOptions#serverTransfer(boolean)}.
  ///
  /// To listen for the status of sending messages, call {@link EMMessage#setMessageStatusListener(EMMessageStatusListener)}.
  ///
  /// Param [message] The message object to be sent: {@link EMMessage}.
  ///
  /// **Throws**  A description of the exception. See {@link EMError}.
  ///
  Future<EMMessage> sendMessage(EMMessage message) async {
    return EMClient.getInstance.chatManager.sendMessage(message);
  }
}
