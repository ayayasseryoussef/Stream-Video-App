import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_video_app/screen/video_call_screen.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Call? call;

  @override
  void initState() {
    super.initState();
    requestPermissions;
    initVideo();
  }

  Future<void> initVideo() async {
    final client = StreamVideo(
      '2cqxtr9wg7fr',
      user: User.guest(userId: 'guest_${DateTime.now().millisecondsSinceEpoch}'),
    );
    await client.connect();

    final newCall = client.makeCall(
      callType: StreamCallType.defaultType(),
      id: 'TestRoom',
    );
    await newCall.join();

    setState(() {
      call = newCall;
    });
  }
  Future<void> requestPermissions() async {
  await Permission.camera.request();
  await Permission.microphone.request();
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: call == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : VideoCallScreen(call: call!),
    );
  }
}

