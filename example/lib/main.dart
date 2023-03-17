import 'package:flutter/foundation.dart';
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
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _nativeOAuth2Plugin = NativeOAuth2();

  bool loading = false;

  final authority = '...';
  final path = '...';
  final clientId = '...';
  final redirectUri = Uri.parse('...');
  final scope = ['openid'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (kIsWeb) {
        final sameTabAuthentication = nativeOAuth2SameTabAuthResult;
        final redirect = sameTabAuthentication.redirect;
        // Check if sameTabAuthentication redirect matches redirectUri
        if (redirect.toString().startsWith(redirectUri.toString())) {
          showSimpleDialog(sameTabAuthentication);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native OAuth2 Example App'),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            if (loading) {
              return const CircularProgressIndicator();
            } else {
              return ElevatedButton(
                onPressed: () => login(context),
                child: const Text('LOGIN'),
              );
            }
          },
        ),
      ),
    );
  }

  void login(BuildContext context) async {
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
          redirectUri: redirectUri,
          scope: scope,
          codeChallenge: pkcePair.codeChallenge,
          codeChallengeMethod: 'S256',
          prompt: 'select_account',
          webMode: const WebAuthenticationMode.sameTab());

      if (!mounted) return;

      showSimpleDialog(response);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void showSimpleDialog(Object? obj) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(obj.toString()),
      ),
    );
  }
}
