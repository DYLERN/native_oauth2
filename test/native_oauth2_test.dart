import 'package:flutter_test/flutter_test.dart';
import 'package:native_oauth2/native_oauth2.dart';
import 'package:native_oauth2/native_oauth2_platform_interface.dart';
import 'package:native_oauth2/native_oauth2_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeOAuth2Platform
    with MockPlatformInterfaceMixin
    implements NativeOAuth2Platform {
  @override
  Future<AuthenticationResult?> authenticate({
    required OAuthProvider provider,
    required Uri redirectUri,
    required List<String> scope,
    required String responseType,
    required String responseMode,
    required String? prompt,
    required String? codeChallenge,
    required String? codeChallengeMethod,
    required Map<String, dynamic> otherParams,
    required WebAuthenticationMode webMode,
  }) async =>
      AuthenticationResult(
        redirect: Uri.parse('scheme://host.name/path?code=abc'),
      );
}

void main() {
  final NativeOAuth2Platform initialPlatform = NativeOAuth2Platform.instance;

  test('$MethodChannelNativeOAuth2 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeOAuth2>());
  });

  test('authenticate', () async {
    NativeOAuth2 nativeOAuth2Plugin = NativeOAuth2();
    MockNativeOAuth2Platform fakePlatform = MockNativeOAuth2Platform();
    NativeOAuth2Platform.instance = fakePlatform;

    final authenticationResult = await nativeOAuth2Plugin.authenticate(
      provider: const OAuthProvider(
        authUrlAuthority: 'authUrlAuthority',
        authUrlPath: 'authUrlPath',
        clientId: 'clientId',
      ),
      redirectUri: Uri.parse(''),
      scope: [],
    );

    expect(authenticationResult?.code, 'abc');
  });
}
