// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:native_oauth2/native_oauth2.dart';
import 'package:native_oauth2/web_config.dart';

import 'native_oauth2_platform_interface.dart';

/// A web implementation of the NativeOauth2Platform of the NativeOauth2 plugin.
class NativeOAuth2Web extends NativeOAuth2Platform {
  /// Constructs a NativeOauth2Web
  NativeOAuth2Web();

  static void registerWith(Registrar registrar) {
    NativeOAuth2Platform.instance = NativeOAuth2Web();
    nativeOAuth2SameTabAuthResult = AuthenticationResult(redirect: Uri.base);
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
    required WebAuthenticationMode webMode,
  }) async {
    final authUri = provider.getAuthUri(
      redirectUri: redirectUri,
      scope: scope,
      responseType: responseType,
      responseMode: responseMode,
      prompt: prompt,
      codeChallenge: codeChallenge,
      codeChallengeMethod: codeChallengeMethod,
      otherParams: otherParams,
    );

    final completer = Completer<Uri?>();

    webMode.when(
      sameTab: (sameTab) {
        html.window.location.href = authUri.toString();
      },
      popup: (popup) async {
        final screen = html.window.screen;
        final screenWidth = screen?.width;
        final screenHeight = screen?.height;
        final ScreenDimensions? screenDimensions;
        if (screenWidth != null && screenHeight != null) {
          screenDimensions = ScreenDimensions(
            width: screenWidth,
            height: screenHeight,
          );
        } else {
          screenDimensions = null;
        }

        final window = html.window.open(
          authUri.toString(),
          popup.windowName,
          popup.constructSpecs(screenDimensions: screenDimensions),
        );

        html.window.onMessage.first.then(
          (value) {
            final redirect = Uri.parse(value.data['redirect']);
            completer.complete(redirect);
          },
        );

        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (completer.isCompleted) {
            timer.cancel();
          } else if (window.closed == true) {
            completer.complete(null);
            timer.cancel();
          }
        });
      },
    );

    final redirect = await completer.future;
    if (redirect != null) {
      return AuthenticationResult(redirect: redirect);
    } else {
      return null;
    }
  }
}
