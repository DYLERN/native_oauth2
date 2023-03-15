import 'package:flutter/material.dart';
import 'package:native_oauth2/native_oauth2.dart';
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
  final _nativeOauth2Plugin = NativeOauth2();

  final authorityController = TextEditingController();
  final pathController = TextEditingController();
  final clientIdController = TextEditingController();
  final redirectUriController = TextEditingController();
  final scopeController = TextEditingController();

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
                  ElevatedButton(
                    onPressed: () => login(context),
                    child: const Text('LOGIN'),
                  ),
                ],
              ),
            ),
          )
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

    final response = await _nativeOauth2Plugin.authenticate(
      provider: provider,
      redirectUri: Uri.parse(redirectUri),
      scope: scope.split(' '),
      codeChallenge: pkcePair.codeChallenge,
      codeChallengeMethod: 'S256',
      prompt: 'select_account',
    );

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(response.toString()),
      ),
    );
  }
}
