import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:native_oauth2/authentication_result.dart';
import 'package:native_oauth2/o_auth_provider.dart';

import 'native_oauth2_platform_interface.dart';

/// An implementation of [NativeOAuth2Platform] that uses method channels.
class MethodChannelNativeOAuth2 extends NativeOAuth2Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('za.drt/native_oauth2');

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
  }) async {
    final authUri = Uri.https(
      provider.authUrlAuthority,
      provider.authUrlPath,
      {
        'client_id': provider.clientId,
        'redirect_uri': redirectUri.toString(),
        'scope': scope.join(' '),
        'response_type': responseType,
        'response_mode': responseMode,
        'prompt': prompt,
        'code_challenge': codeChallenge,
        'code_challenge_method': codeChallengeMethod,
        ...otherParams
      }..removeWhere((_, value) => value == null),
    );

    final response = await methodChannel.invokeMethod(
      'authenticate',
      {
        'authUri': authUri.toString(),
        'redirectUriScheme': redirectUri.scheme,
      },
    ) as String?;

    if (response == null) {
      return null;
    }

    // TODO check format
    final resultUri = Uri.parse(response);

    return AuthenticationResult(redirect: resultUri);
  }
}
