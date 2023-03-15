library native_oauth2;

import 'authentication_response.dart';
import 'native_oauth2_platform_interface.dart';
import 'o_auth_provider.dart';

export 'authentication_response.dart';
export 'o_auth_provider.dart';

class NativeOauth2 {
  Future<AuthenticationResponse?> authenticate({
    required OAuthProvider provider,
    required Uri redirectUri,
    required List<String> scope,
    String responseType = 'code',
    String responseMode = 'query',
    String? prompt,
    String? codeChallenge,
    String? codeChallengeMethod,
    Map<String, dynamic> otherParams = const {},
  }) {
    return NativeOauth2Platform.instance.authenticate(
      provider: provider,
      redirectUri: redirectUri,
      scope: scope,
      responseType: responseType,
      responseMode: responseMode,
      prompt: prompt,
      codeChallenge: codeChallenge,
      codeChallengeMethod: codeChallengeMethod,
      otherParams: otherParams,
    );
  }
}
