import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_publive/tools/publive_log.dart';

abstract class RtcEngineListener {

  ///
  /// Reports a warning during SDK runtime.
  /// Occurs when a warning occurs during SDK runtime. In most cases, the app can ignore the warnings reported by the SDK because the SDK can usually fix the issue and resume running. For example, when losing connection with the server, the SDK may report WARN_LOOKUP_CHANNEL_TIMEOUT and automatically try to reconnect.
  ///
  /// Param [warn] Warning codes.
  ///
  /// Param [msg] Warning description.
  ///
  void warning(WarningCode warn) {
    PubLiveLog.v('warning $warn');
  }

  void error(ErrorCode err) {
    PubLiveLog.v('err $err');
  }

  ///
  /// Occurs when a user joins a channel.
  /// This callback notifies the application that a user joins a specified channel.
  ///
  /// Param [channel] The name of the channel.
  ///
  /// Param [uid] The ID of the user who joins the channel.
  ///
  /// Param [elapsed] The time elapsed (ms) from the local user calling joinChannel until the SDK triggers this callback.
  ///
  void joinChannelSuccess(String channel, int uid, int elapsed) {
    PubLiveLog.v('joinChannelSuccess $channel $uid $elapsed');
  }

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) joins the channel.
  /// In a communication channel, this callback indicates that a remote user joins the channel. The SDK also triggers this callback to report the existing users in the channel when a user joins the channel.
  ///  In a live-broadcast channel, this callback indicates that a host joins the channel. The SDK also triggers this callback to report the existing hosts in the channel when a host joins the channel. Agora recommends limiting the number of hosts to 17. The SDK triggers this callback under one of the following circumstances:
  ///  A remote user/host joins the channel by calling the joinChannel method.
  ///  A remote user switches the user role to the host after joining the channel.
  ///  A remote user/host rejoins the channel after a network interruption.
  ///
  /// Param [uid] The ID of the user or host who joins the channel.
  ///
  /// Param [elapsed] Time delay (ms) from the local user calling joinChannel
  ///  until this callback is triggered.
  ///
  void userJoined(int uid, int elapsed) {
    PubLiveLog.v('userJoined  $uid $elapsed');
  }

  ///
  /// Occurs when a remote user (COMMUNICATION)/ host (LIVE_BROADCASTING) leaves the channel.
  /// There are two reasons for users to become offline:
  ///  Leave the channel: When a user/host leaves the channel, the user/host sends a goodbye message. When this message is received, the SDK determines that the user/host leaves the channel.
  ///  Drop offline: When no data packet of the user or host is received for a certain period of time (20 seconds for the communication profile, and more for the live broadcast profile), the SDK assumes that the user/host drops offline. A poor network connection may lead to false detections. It's recommended to use the Agora RTM SDK for reliable offline detection.
  ///
  /// Param [uid] The ID of the user who leaves the channel or goes offline.
  ///
  /// Param [reason] Reasons why the user goes offline: UserOfflineReason .
  ///
  void userOffline(int uid, UserOfflineReason reason) {
    PubLiveLog.v('userOffline  $uid $reason');
  }

  ///
  /// Occurs when a user leaves a channel.
  /// This callback notifies the app that the user leaves the channel by calling leaveChannel . From this callback, the app can get information such as the call duration and quality statistics.
  ///
  /// Param [stats] The statistics of the call, see RtcStats .
  ///
  void leaveChannel(RtcStats stats) {
    PubLiveLog.v('leaveChannel ${stats.toJson()}');
  }

}