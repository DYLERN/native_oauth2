class OAuthProvider {
  final String authUrlAuthority;
  final String authUrlPath;
  final String clientId;

  const OAuthProvider({
    required this.authUrlAuthority,
    required this.authUrlPath,
    required this.clientId,
  });

  Uri getAuthUri({
    required Uri redirectUri,
    required List<String> scope,
    required String responseType,
    required String responseMode,
    required String? prompt,
    required String? codeChallenge,
    required String? codeChallengeMethod,
    required Map<String, dynamic> otherParams,
  }) {
    return Uri.https(
      authUrlAuthority,
      authUrlPath,
      {
        'client_id': clientId,
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
  }
}
