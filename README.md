# native_oauth2

A Flutter plugin for authenticating with OAuth 2.0 providers using native platform APIs.

This package provides a simple interface for authenticating with OAuth 2.0 providers on both iOS (using SFWebAuthentication) and Android (using Chrome Custom Tabs).


## Installation

Add `native_oauth2` as a dependency in your `pubspec.yaml` file

```yaml
dependencies:
  native_oauth2: ^0.0.1
```

Then run `flutter pub get` to install

## Usage

Authenticate with an arbitrary OAuth 2.0 provider:

```dart
import 'package:native_oauth2/native_oauth2.dart';

void login() async {
  final plugin = NativeOAuth2();

  final provider = OAuthProvider(
    authUrlAuthority: authority,
    authUrlPath: path,
    clientId: clientId,
  );

  final result = await plugin.authenticate(
    provider: provider,
    redirectUri: Uri.parse('custom-scheme://custom/path'),
    scope: ['openid', 'Some.Other.Scope'],
  );
}
```