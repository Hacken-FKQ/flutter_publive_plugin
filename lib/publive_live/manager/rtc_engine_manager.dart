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

  ///
  /// Initializes RtcEngine.
  ///  The SDK supports creating only one RtcEngineinstance for an app.
  ///
  Future<void> initEngine(String appId) async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();

    // await _engine!.enableVideo();
    // await _engine!.startPreview();
    // await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // await _engine!.setClientRole(ClientRole.Broadcaster);
  }

  ///
  /// Joins a channel with the user ID, and configures whether to automatically subscribe to the audio or video streams.
  /// This method enables the local user to join a real-time audio and video interaction channel. With the same App ID, users in the same channel can talk to each other, and multiple users in the same channel can start a group chat.
  ///  A successful call of this method triggers the following callbacks:
  ///  The local client: The joinChannelSuccess and connectionStateChanged callbacks.
  ///  The remote client: userJoined , if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile. When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the rejoinChannelSuccess callback on the local client.
  ///
  /// Param [token] The token generated on your server for authentication. See Authenticate Your Users with Token.
  ///  Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  /// Param [channelName] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  The 10 numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// Param [optionalInfo] Reserved for future use.
  ///
  ///
  /// Param [optionalUid] User ID This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to
  ///  232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the joinChannelSuccess callback. Your app must maintain the returned user ID, because the SDK
  ///  does not do so.
  ///
  /// Param [options] The channel media options.
  ///
  ///
  Future<void> joinChannel(
      String? token, String channelName, String? optionalInfo, int optionalUid,
      [ChannelMediaOptions? options]) async {
    await _engine!.joinChannel(token, channelName, optionalInfo, optionalUid, options);
  }

  ///
  /// Leaves a channel.
  /// This method releases all resources related to the session. This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel.
  ///  After joining the channel, you must call this method to end the call; otherwise, you cannot join the next call.
  ///  After joining the channel, you must call this method or to end the call; otherwise, you cannot join the next call.
  ///  A successful call of this method triggers the following callbacks:
  ///  The local client: leaveChannel .
  ///  The remote client: userOffline , if the user joining the channel is in the Communication profile, or is a host in the Live-broadcasting profile.
  ///  If you call destroy immediately after calling this method, the SDK does not trigger the leaveChannel callback.
  ///  If you call this method during a CDN live streaming, the SDK automatically calls the removePublishStreamUrl method.
  ///
  Future<void> leaveChannel() async {
    await _engine!.leaveChannel();
  }

  ///
  /// Sets the user role and level in an interactive live streaming channel.
  /// In the interactive live streaming profile, the SDK sets the user role as audience by default. You can call this method to set the user role as host.
  ///  You can call this method either before or after joining a channel. If you call this method to switch the user role after joining a channel, the SDK automatically does the following:
  ///  Calls muteLocalAudioStream and muteLocalVideoStream to change the publishing state.
  ///  Triggers clientRoleChanged on the local client.
  ///  Triggers userJoined or userOffline on the remote client. This method applies to the interactive live streaming profile (the profile parameter of setChannelProfile is LiveBroadcasting) only.
  ///
  /// Param [role] The user role in the interactive live streaming. See ClientRole .
  ///
  /// Param [options] The detailed options of a user, including the user level. See ClientRoleOptions for details.
  ///
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]) async {
    await _engine!.setClientRole(role, options);
  }

  ///
  /// Sets the channel profile.
  /// After initializing the SDK, the default channel profile is the communication profile. After initializing the SDK, the default channel profile is the live streaming profile. You can call this method to set the usage scenario of Agora channel. The Agora SDK differentiates channel profiles and applies optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call and prioritizes video quality for interactive live video streaming. To ensure the quality of real-time communication, Agora recommends that all users in a channel use the same channel profile.
  ///  This method must be called and set before joinChannel, and cannot be set again after joining the channel.
  ///
  /// Param [profile] The channel profile. See ChannelProfile for details.
  ///
  ///
  Future<void> setChannelProfile(ChannelProfile profile) async {
    await _engine!.setChannelProfile(profile);
  }

  ///
  /// Enables the local video preview.
  /// This method starts the local video preview before joining the channel. Before calling this method, ensure that you do the following: Call enableVideo to enable the video.
  ///  The local preview enables the mirror mode by default.
  ///  After the local video preview is enabled, if you call leaveChannel to exit the channel, the local preview remains until you call stopPreview to disable it.
  ///
  Future<void> startPreview() async {
    await _engine!.startPreview();
  }

  ///
  /// Enables the video module.
  /// Call this method either before joining a channel or during a call. If this method is called before joining a channel, the call starts in the video mode. Call disableVideo to disable the video mode.A successful call of this method triggers the remoteVideoStateChanged callback on the remote client. This method enables the internal engine and is valid after leaving the channel.
  ///  This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  ///  enableLocalVideo : Whether to enable the camera to create the local video stream.
  ///  muteLocalVideoStream : Whether to publish the local video stream.
  ///  muteRemoteVideoStream : Whether to subscribe to and play the remote video stream.
  ///  muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  ///
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

  ///
  /// Releases the RtcEngine instance.
  /// This method releases all resources used by the Agora SDK. Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources for other operations.
  ///  If you want to create a new RtcEngine instance after destroying the current one, ensure that you wait till the destroy method execution to complete.
  ///
  Future<void> destroy() async {
    _engine?.destroy();
    _engine = null;
  }

  /// RtcEngineListener
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