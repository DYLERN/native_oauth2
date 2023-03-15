# native_oauth2

A Flutter plugin for authenticating with OAuth 2.0 providers using native platform APIs.

This package provides a simple interface for authenticating with OAuth 2.0 providers on both iOS (using SFAuthenticationSession) and Android (using Chrome Custom Tabs).


## Installation

Add `native_oauth2` as a dependency in your `pubspec.yaml` file

```yaml
dependencies:
  native_oauth2: ^0.0.1
```

Then run `flutter pub get` to install

## Android Setup

Add an intent-filter within the `activity` tag in your `AndroidManifest.xml`

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW"/>

    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>

    <data
            android:scheme="custom-scheme"
            android:host="custom.host"
            android:path="/custom/path"/>
</intent-filter>
```

## iOS Setup
No additional setup required

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
    redirectUri: Uri.parse('custom-scheme://custom.host/custom/path'),
    scope: ['openid', 'Some.Other.Scope'],
  );
}
```