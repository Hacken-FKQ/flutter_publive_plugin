import 'package:flutter_publive/publive_live/listener/rtc_engine_listener.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

class RtcEngineManager {
  static late final RtcEngineManager _instance = RtcEngineManager._init();
  final List<RtcEngineListener> _listeners = [];
  factory RtcEngineManager() => _instance;

  RtcEngineManager._init() {}
  RtcEngine? _engine;

  void addListener(RtcEngineListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RtcEngineListener listener) {
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  Future<void> initEngine(String appId) async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();

    await _engine!.enableVideo();
    await _engine!.startPreview();
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine!.setClientRole(ClientRole.Broadcaster);
  }

  Future<void> joinChannel(
      String? token, String channelName, String? optionalInfo, int optionalUid,
      [ChannelMediaOptions? options]) async {
    await _engine!.joinChannel(token, channelName, optionalInfo, optionalUid, options);
  }

  Future<void> leaveChannel() async {
    await _engine!.leaveChannel();
  }

  Future<void> startPreview() async {
    await _engine!.startPreview();
  }

  Future<void> enableVideo() async {
    await _engine!.enableVideo();
  }

  ///
  /// Switches between front and rear cameras.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel ).
  ///
  Future<void> switchCamera() async {
    await _engine!.switchCamera();
  }

  Future<void> destroy() async {
    _engine?.destroy();
    _engine = null;
  }

  void _addListeners() {
    _engine!.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        _listeners.forEach((element) {
          element.warning(warningCode);
        });
      },
      error: (errorCode) {
        _listeners.forEach((element) {
          element.error(errorCode);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        _listeners.forEach((element) {
          element.joinChannelSuccess(channel, uid, elapsed);
        });
      },
      userJoined: (uid, elapsed) {
        _listeners.forEach((element) {
          element.userJoined(uid, elapsed);
        });
      },
      userOffline: (uid, reason) {
        _listeners.forEach((element) {
          element.userOffline(uid, reason);
        });
      },
      leaveChannel: (stats) {
        _listeners.forEach((element) {
          element.leaveChannel(stats);
        });
      },
    ));
  }

}