import 'package:native_oauth2/authentication_result.dart';
import 'package:native_oauth2/o_auth_provider.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_oauth2_method_channel.dart';

abstract class NativeOAuth2Platform extends PlatformInterface {
  /// Constructs a NativeOAuth2Platform.
  NativeOAuth2Platform() : super(token: _token);

  static final Object _token = Object();

  static NativeOAuth2Platform _instance = MethodChannelNativeOAuth2();

  /// The default instance of [NativeOAuth2Platform] to use.
  ///
  /// Defaults to [MethodChannelNativeOAuth2].
  static NativeOAuth2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeOAuth2Platform] when
  /// they register themselves.
  static set instance(NativeOAuth2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

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
  }) {
    throw UnimplementedError('authenticate() has not been implemented.');
  }
}
