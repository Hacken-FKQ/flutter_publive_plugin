import 'package:flutter/material.dart';
import 'package:flutter_publive/publive_im/listener/chat_message_listener.dart';
import 'package:flutter_publive/publive_im/manager/chat_manager.dart';
import 'package:flutter_publive_example/config/publive.config.dart' as config;
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

class OneChatOne extends StatefulWidget {
  const OneChatOne({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OneChatOne> with ChatMessageListener {
  ScrollController scrollController = ScrollController();
  String _username = "";
  String _password = "";
  String _messageContent = "";
  String _chatId = "";
  final List<String> _logText = [];

  @override
  void initState() {
    super.initState();

    ChatManager.configure(config.appKey);
    ChatManager.messageManager.addListener(this);
  }

  @override
  void dispose() {
    ChatManager.messageManager.removeListener(this);
    super.dispose();
  }

  void _signIn() async {
    if (_username.isEmpty || _password.isEmpty) {
      _addLogToConsole("username or password is null");
      return;
    }

    try {
      _addLogToConsole("begin login...");
      ChatManager().login(_username, _password);
      _addLogToConsole("login succeed, username: $_username");
    } on EMError catch (e) {
      _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
    }
  }

  void _signOut() async {
    try {
      _addLogToConsole("begin logout...");
      await ChatManager().logout(true);
      _addLogToConsole("logout succeed, username: $_username");
    } on EMError catch (e) {
      _addLogToConsole(
          "logout failed, code: ${e.code}, desc: ${e.description}");
    }
  }

  void _signUp() async {
    if (_username.isEmpty || _password.isEmpty) {
      _addLogToConsole("username or password is null");
      return;
    }

    try {
      _addLogToConsole("begin create account...");
      await ChatManager().createAccount(_username, _password);
      _addLogToConsole("create account succeed, username: $_username");
    } on EMError catch (e) {
      _addLogToConsole(
          "create account failed, code: ${e.code}, desc: ${e.description}");
    }
  }

  void _sendMessage() async {
    if (_chatId.isEmpty || _messageContent.isEmpty) {
      _addLogToConsole("single chat id or message content is null");
      return;
    }

    // ChatManager().sendMsg();

    var msg = ChatManager().createTxtSendMessage(
      username: _chatId,
      content: _messageContent,
    );
    msg.setMessageStatusCallBack(MessageStatusCallBack(
      onSuccess: () {
        _addLogToConsole("send message: $_messageContent");
      },
      onError: (e) {
        _addLogToConsole(
          "send message failed, code: ${e.code}, desc: ${e.description}",
        );
      },
    ));
    ChatManager().sendMessage(msg);
  }

  void _addLogToConsole(String log) {
    _logText.add(_timeString + ": " + log);
    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  String get _timeString {
    return DateTime.now().toString().split(".").first;
  }

  @override
  void onMessagesReceived(List<EMMessage> messages) {
    for (var msg in messages) {
      switch (msg.body.type) {
        case MessageType.TXT:
          {
            EMTextMessageBody body = msg.body as EMTextMessageBody;
            _addLogToConsole(
              "receive text message: ${body.content}, from: ${msg.from}",
            );
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "Enter username"),
              onChanged: (username) => _username = username,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Enter password"),
              onChanged: (password) => _password = password,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: _signIn,
                    child: const Text("SIGN IN"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: _signOut,
                    child: const Text("SIGN OUT"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: _signUp,
                    child: const Text("SIGN UP"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Enter the username you want to send"),
              onChanged: (chatId) => _chatId = chatId,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Enter content"),
              onChanged: (msg) => _messageContent = msg,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _sendMessage,
              child: const Text("SEND TEXT"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
            ),
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (_, index) {
                  return Text(_logText[index]);
                },
                itemCount: _logText.length,
              ),
            ),
          ],
        ),
    );
  }
}
