// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:native_oauth2/native_oauth2.dart';

import 'native_oauth2_platform_interface.dart';

/// A web implementation of the NativeOauth2Platform of the NativeOauth2 plugin.
class NativeOAuth2Web extends NativeOAuth2Platform {
  /// Constructs a NativeOauth2Web
  NativeOAuth2Web();

  static void registerWith(Registrar registrar) {
    NativeOAuth2Platform.instance = NativeOAuth2Web();
  }

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
  }) {
    return super.authenticate(
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
