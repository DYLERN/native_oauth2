import 'package:flutter_test/flutter_test.dart';
import 'package:native_oauth2/native_oauth2.dart';
import 'package:native_oauth2/native_oauth2_platform_interface.dart';
import 'package:native_oauth2/native_oauth2_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeOauth2Platform
    with MockPlatformInterfaceMixin
    implements NativeOauth2Platform {
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
  }) async =>
      AuthenticationResult(code: 'abc');
}

void main() {
  final NativeOauth2Platform initialPlatform = NativeOauth2Platform.instance;

  test('$MethodChannelNativeOauth2 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeOauth2>());
  });

  test('authenticate', () async {
    NativeOauth2 nativeOauth2Plugin = NativeOauth2();
    MockNativeOauth2Platform fakePlatform = MockNativeOauth2Platform();
    NativeOauth2Platform.instance = fakePlatform;

    final authenticationResult = await nativeOauth2Plugin.authenticate(
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
