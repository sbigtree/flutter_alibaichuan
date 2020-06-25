import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alibaichuan/alibaichuan.dart';

void main() {
  const MethodChannel channel = MethodChannel('alibaichuan');

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
    expect(await Alibaichuan.platformVersion, '42');
  });
}
