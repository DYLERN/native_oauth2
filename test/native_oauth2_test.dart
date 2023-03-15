import 'package:flutter_test/flutter_test.dart';
import 'package:native_oauth2/native_oauth2.dart';
import 'package:native_oauth2/native_oauth2_platform_interface.dart';
import 'package:native_oauth2/native_oauth2_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeOauth2Platform
    with MockPlatformInterfaceMixin
    implements NativeOauth2Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeOauth2Platform initialPlatform = NativeOauth2Platform.instance;

  test('$MethodChannelNativeOauth2 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeOauth2>());
  });

  test('getPlatformVersion', () async {
    NativeOauth2 nativeOauth2Plugin = NativeOauth2();
    MockNativeOauth2Platform fakePlatform = MockNativeOauth2Platform();
    NativeOauth2Platform.instance = fakePlatform;

    expect(await nativeOauth2Plugin.getPlatformVersion(), '42');
  });
}
