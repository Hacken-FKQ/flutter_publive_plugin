import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_publive/publive_live/listener/rtc_engine_listener.dart';
import 'package:flutter_publive/publive_live/manager/rtc_engine_manager.dart';
import 'package:flutter_publive/publive_live/manager/rtc_local_view.dart';
import 'package:flutter_publive/publive_live/manager/rtc_remote_view.dart';
import 'package:flutter_publive_example/config/publive.config.dart' as config;
import 'package:flutter_publive_example/log_sink.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelLive extends StatefulWidget {
  /// Construct the [JoinChannelVideo]
  const JoinChannelLive({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelLive> with RtcEngineListener {
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];
  late TextEditingController _controller;
  bool _isRenderSurfaceView = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    RtcEngineManager().removeListener(this);
    RtcEngineManager().destroy();
  }

  @override
  void warning(dynamic warn) {
    logSink.log('warning $warn');
  }

  @override
  void error(dynamic err) {
    logSink.log('err $err');
  }

  Future<void> _initEngine() async {
    RtcEngineManager().initEngine(config.appId);

    RtcEngineManager().addListener(this);
    // RtcEngineManager().enableVideo();
    // RtcEngineManager().startPreview();
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    // await _engine.joinChannel(config.token, _controller.text, null, config.uid);

    RtcEngineManager().joinChannel(config.token, _controller.text, null, config.uid);
  }

  _leaveChannel() async {
    RtcEngineManager().leaveChannel();
  }

  _switchCamera() {
    RtcEngineManager().switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      // logSink.log('switchCamera $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS))
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                      'Rendered by SurfaceView \n(default TextureView): '),
                  Switch(
                    value: _isRenderSurfaceView,
                    onChanged: isJoined
                        ? null
                        : (changed) {
                            setState(() {
                              _isRenderSurfaceView = changed;
                            });
                          },
                  )
                ],
              ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: isJoined ? _leaveChannel : _joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
            _renderVideo(),
          ],
        ),
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _switchCamera,
                  child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
                ),
              ],
            ),
          )
      ],
    );
  }

  _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            child: (kIsWeb || _isRenderSurfaceView)
                ? PubLiveLocalView.getPubLiveLocalSurfaceView(
                    zOrderMediaOverlay: true,
                    zOrderOnTop: true,
                  )
                : PubLiveLocalView.getPubLiveLocalTextureView(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(remoteUid.map(
                  (e) => GestureDetector(
                    onTap: _switchRender,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: (kIsWeb || _isRenderSurfaceView)
                          ? PubLiveRemoteView.getPubLiveRemoteSurfaceView(
                              uid: e,
                              channelId: _controller.text,
                            )
                          : PubLiveRemoteView.getPubLiveRemoteTextureView(
                              uid: e,
                              channelId: _controller.text,
                            ),
                    ),
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
