import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/src/enums.dart';
import 'package:agora_rtc_engine/src/rtc_local_view.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

///
/// SurfaceView class for rendering local video. Extends from the RtcSurfaceView class.
/// This class has the following corresponding classes:
///  Android: SurfaceView (https://developer.android.com/reference/android/view/SurfaceView).
///  iOS: UIView (https://developer.apple.com/documentation/uikit/uiview) Applies to the macOS and Windows platforms only.
///
class PubLiveLocalView {
  /// Constructs the [SurfaceView].
  /// Constructs the [SurfaceView].

  static SurfaceView getPubLiveLocalSurfaceView({
    Key? key,
    String? channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    bool zOrderOnTop = false,
    bool zOrderMediaOverlay = false,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) {
    return SurfaceView(
      key: key,
      channelId: channelId,
      renderMode: renderMode,
      mirrorMode: mirrorMode,
      zOrderOnTop: zOrderOnTop,
      zOrderMediaOverlay: zOrderMediaOverlay,
      onPlatformViewCreated: onPlatformViewCreated,
      gestureRecognizers: gestureRecognizers,
    );
  }

  static TextureView getPubLiveLocalTextureView({
    Key? key,
    String? channelId,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    bool useFlutterTexture = true,
  }) {
    return TextureView(
      key: key,
      channelId: channelId,
      renderMode: renderMode,
      mirrorMode: mirrorMode,
      onPlatformViewCreated: onPlatformViewCreated,
      gestureRecognizers: gestureRecognizers,
      useFlutterTexture: useFlutterTexture,
    );
  }
}
