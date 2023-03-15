library native_oauth2;

import 'package:native_oauth2/authentication_response.dart';
import 'package:native_oauth2/o_auth_provider.dart';

import 'native_oauth2_platform_interface.dart';

export 'package:native_oauth2/authentication_response.dart';
export 'package:native_oauth2/o_auth_provider.dart';

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
