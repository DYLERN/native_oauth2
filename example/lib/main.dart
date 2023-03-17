import 'package:flutter/material.dart';
import 'package:native_oauth2/native_oauth2.dart';
import 'package:native_oauth2/web_config.dart';
import 'package:pkce/pkce.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _nativeOAuth2Plugin = NativeOAuth2();

  final authorityController = TextEditingController();
  final pathController = TextEditingController();
  final clientIdController = TextEditingController();
  final redirectUriController = TextEditingController();
  final scopeController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Native OAuth2 Example App'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: authorityController,
                  decoration: const InputDecoration(
                    labelText: 'Auth URI Authority',
                  ),
                ),
                TextField(
                  controller: pathController,
                  decoration: const InputDecoration(
                    labelText: 'Auth URI Path',
                  ),
                ),
                TextField(
                  controller: clientIdController,
                  decoration: const InputDecoration(
                    labelText: 'Client ID',
                  ),
                ),
                TextField(
                  controller: redirectUriController,
                  decoration: const InputDecoration(
                    labelText: 'Redirect URI',
                  ),
                ),
                TextField(
                  controller: scopeController,
                  decoration: const InputDecoration(
                    labelText: 'Scope',
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (loading) {
                      return const CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: () => login(context),
                        child: const Text('LOGIN'),
                      );
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    final authority = authorityController.text.trim();
    final path = pathController.text.trim();
    final clientId = clientIdController.text.trim();
    final redirectUri = redirectUriController.text.trim();
    final scope = scopeController.text.trim();

    final provider = OAuthProvider(
      authUrlAuthority: authority,
      authUrlPath: path,
      clientId: clientId,
    );

    final pkcePair = PkcePair.generate();

    try {
      setState(() {
        loading = true;
      });

      final response = await _nativeOAuth2Plugin.authenticate(
        provider: provider,
        redirectUri: Uri.parse(redirectUri),
        scope: scope.split(' '),
        codeChallenge: pkcePair.codeChallenge,
        codeChallengeMethod: 'S256',
        prompt: 'select_account',
        webMode: const WebAuthenticationMode.popup(
          windowName: 'Authentication Window Name',
          width: 400,
          height: 400,
          shouldCenter: true,
        ),
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(response.toString()),
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }

  }
}
