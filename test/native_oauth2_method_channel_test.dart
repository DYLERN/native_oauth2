import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_oauth2/native_oauth2.dart';
import 'package:native_oauth2/native_oauth2_method_channel.dart';

void main() {
  MethodChannelNativeOAuth2 platform = MethodChannelNativeOAuth2();
  const MethodChannel channel = MethodChannel('za.drt/native_oauth2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'https://example.com?code=abc';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('authenticate', () async {
    final result = await platform.authenticate(
      provider: const OAuthProvider(
          authUrlAuthority: 'authUrlAuthority',
          authUrlPath: 'authUrlPath',
          clientId: 'clientId'),
      redirectUri: Uri.parse(''),
      scope: [],
      responseType: 'responseType',
      responseMode: 'responseMode',
      prompt: 'prompt',
      codeChallenge: 'codeChallenge',
      codeChallengeMethod: 'codeChallengeMethod',
      otherParams: {},
      webMode: const WebAuthenticationMode.sameTab(),
    );

    expect(result?.code, 'abc');
  });
}
