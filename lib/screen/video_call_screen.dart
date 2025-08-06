import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class VideoCallScreen extends StatelessWidget {
  final Call call;
  const VideoCallScreen({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamCallContent(call: call),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.call_end),
        onPressed: () async {
          await call.leave();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      ),
    );
  }
}
