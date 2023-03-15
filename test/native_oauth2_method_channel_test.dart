import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_oauth2/native_oauth2_method_channel.dart';

void main() {
  MethodChannelNativeOauth2 platform = MethodChannelNativeOauth2();
  const MethodChannel channel = MethodChannel('native_oauth2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
