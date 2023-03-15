class AuthenticationResult {
  final String? code;

  AuthenticationResult({
    this.code,
  });

  @override
  String toString() {
    return 'AuthenticationResponse(code=$code)';
  }
}
