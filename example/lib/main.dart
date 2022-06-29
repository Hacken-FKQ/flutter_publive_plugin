import 'package:flutter/material.dart';
import 'package:flutter_publive_example/im/index.dart';
import 'package:flutter_publive_example/live/index.dart';
import 'package:flutter_publive_example/log_sink.dart';
import 'config/publive.config.dart' as config;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _data = [...PUBLIVE_LIVE, ...PUBLIVE_IM];

  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOKEN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PubLive Example'),
        ),
        body: _isConfigInvalid()
            ? const InvalidConfigWidget()
            : ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return _data[index]['widget'] == null
                      ? Ink(
                          color: Colors.grey,
                          child: ListTile(
                            title: Text(_data[index]['name'] as String,
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white)),
                          ),
                        )
                      : ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                                _data[index]['name'] as String),
                                            // ignore: prefer_const_literals_to_create_immutables
                                            actions: [const LogActionWidget()],
                                          ),
                                          body:
                                              _data[index]['widget'] as Widget?,
                                        )));
                          },
                          title: Text(
                            _data[index]['name'] as String,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black),
                          ),
                        );
                },
              ),
      ),
    );
  }
}

/// This widget is used to indicate the configuration is invalid
class InvalidConfigWidget extends StatelessWidget {
  /// Construct the [InvalidConfigWidget]
  const InvalidConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text(
          'Make sure you set the correct appId, token, channelId, etc.. in the lib/config/publive.config.dart file.'),
    );
  }
}
