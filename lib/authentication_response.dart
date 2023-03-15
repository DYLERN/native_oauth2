class AuthenticationResponse {
  final String? code;

  AuthenticationResponse({
    this.code,
  });

  @override
  String toString() {
    return 'AuthenticationResponse(code=$code)';
  }
}
