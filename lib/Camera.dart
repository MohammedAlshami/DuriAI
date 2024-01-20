import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';
import 'assistant.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    _openCamera();
  }

  Future<void> _openCamera() async {
    List<File>? res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WhatsappCamera(),
      ),
    );

    if (res != null && res.isNotEmpty) {
      File firstFile = res.first;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Assistant(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Page"),
      ),
      body: Container(
        child: const Center(
          child: Text("Camera Page Content"),
        ),
      ),
    );
  }
}
