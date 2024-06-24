import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppleMusicAuthPage extends StatefulWidget {
  const AppleMusicAuthPage({super.key});

  @override
  _AppleMusicAuthPageState createState() => _AppleMusicAuthPageState();
}

class _AppleMusicAuthPageState extends State<AppleMusicAuthPage> {
  late final WebViewController _controller;

  Future<void> init() async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('generateDeveloperToken');

      final result = await callable.call();

      final developerToken = result.data['token'];

      final String htmlContent = await _loadHtmlFromAssets(developerToken);

      await _controller.loadHtmlString(htmlContent);
    } catch (e) {
      debugPrint("ERROR : ${e.toString()}");
    }
  }

  Future<String> _loadHtmlFromAssets(String developerToken) async {
    String fileText =
        await rootBundle.loadString('assets/apple_music_auth.html');

    final replace = fileText.replaceAll('YOUR_DEVELOPER_TOKEN', developerToken);

    return replace;
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Flutter',
        onMessageReceived: (JavaScriptMessage message) {
          final userToken = message.message;
          debugPrint('Music User Token: $userToken');
        },
      )
      ..enableZoom(false);

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Music Auth'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
