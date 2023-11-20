# native_oauth2

A Flutter plugin for authenticating with OAuth 2.0 providers using native
platform APIs.

This package provides a simple interface for authenticating with OAuth 2.0
providers on both iOS (using SFAuthenticationSession) and Android
(using Chrome Custom Tabs).


## Installation

Add `native_oauth2` as a dependency in your `pubspec.yaml` file

```yaml
dependencies:
  native_oauth2: ^0.1.1
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

## Web Setup
This plugin provides two modes when running as a web app: same tab, and popup

### Same Tab
The auth url will be opened in the same tab as the application.
This has the unfortunate side effect that all application state is lost.
In order to use this mode, you should check the `nativeOAuth2SameTabAuthResult`
global variable for redirects (see example). If you use PKCE, the code verifier
should be persisted in SessionStorage *before* running `authenticate`.

### Popup
The auth url will be opened in a popup window. Once authentication is complete,
the redirect must be handled by a static html page that posts a message to the
origin window. You should create an html file like this and put it in the root of
your web/ directory, and then set up your redirect uri to point to that page.
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logged In</title>
</head>
<body>
<h1>You have been logged in. You will be redirected shortly</h1>

<script>
    // This is the important bit
    // You can also run this inside setTimeout make the process feel less jumpy for the user
    // The message must have a redirect property, which must be window.location.href
    window.opener.postMessage({redirect: window.location.href}, window.location.origin)
    window.close()
</script>
</body>
</html>
```

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