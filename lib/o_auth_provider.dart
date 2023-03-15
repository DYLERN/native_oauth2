class OAuthProvider {
  final String authUrlAuthority;
  final String authUrlPath;
  final String clientId;

  const OAuthProvider({
    required this.authUrlAuthority,
    required this.authUrlPath,
    required this.clientId,
  });
}
