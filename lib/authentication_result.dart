class AuthenticationResult {
  final Uri redirect;

  const AuthenticationResult({required this.redirect});

  Map<String, String> get redirectParams => redirect.queryParameters;

  String? get code => redirectParams['code'];

  String? get state => redirectParams['state'];

  @override
  String toString() {
    return 'AuthenticationResponse(redirect=$redirect)';
  }
}
