library native_oauth2;

import 'authentication_result.dart';
import 'native_oauth2_platform_interface.dart';
import 'o_auth_provider.dart';
import 'web_config.dart';

export 'authentication_result.dart';
export 'o_auth_provider.dart';
export 'web_config.dart';

/// The initial page load url. Used with sameTab authentication on web, after redirecting back to application.
/// IMPORTANT: This will only have a value when running flutter on web, be sure to check that
/// kIsWeb is true before trying to reference this value
late final AuthenticationResult nativeOAuth2SameTabAuthResult;

class NativeOAuth2 {
  /// Authenticate a user with some OAuth 2.0 provider.
  Future<AuthenticationResult?> authenticate({
    required OAuthProvider provider,
    required Uri redirectUri,
    required List<String> scope,
    String responseType = 'code',
    String responseMode = 'query',
    String? prompt,
    String? codeChallenge,
    String? codeChallengeMethod,
    Map<String, dynamic> otherParams = const {},
    WebAuthenticationMode webMode = const WebAuthenticationMode.sameTab(),
  }) {
    return NativeOAuth2Platform.instance.authenticate(
      provider: provider,
      redirectUri: redirectUri,
      scope: scope,
      responseType: responseType,
      responseMode: responseMode,
      prompt: prompt,
      codeChallenge: codeChallenge,
      codeChallengeMethod: codeChallengeMethod,
      otherParams: otherParams,
      webMode: webMode,
    );
  }
}
