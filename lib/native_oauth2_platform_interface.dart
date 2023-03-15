import 'package:native_oauth2/authentication_response.dart';
import 'package:native_oauth2/o_auth_provider.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_oauth2_method_channel.dart';

abstract class NativeOauth2Platform extends PlatformInterface {
  /// Constructs a NativeOauth2Platform.
  NativeOauth2Platform() : super(token: _token);

  static final Object _token = Object();

  static NativeOauth2Platform _instance = MethodChannelNativeOauth2();

  /// The default instance of [NativeOauth2Platform] to use.
  ///
  /// Defaults to [MethodChannelNativeOauth2].
  static NativeOauth2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeOauth2Platform] when
  /// they register themselves.
  static set instance(NativeOauth2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<AuthenticationResponse?> authenticate({
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
