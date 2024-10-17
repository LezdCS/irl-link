class SeCredentials {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String scopes;

  const SeCredentials({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.scopes,
  });

  Map toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'scopes': scopes,
      };
}
