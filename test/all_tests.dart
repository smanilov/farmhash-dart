import 'dart:convert';

import 'package:farmhash/farmhash.dart';
import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';

void main() {
  group('fingerprint64', () {
    test('test really simple fingerprints', () {
      expect(fingerprint64(utf8.encode("test")), Int64(8581389452482819506));
    });
  });
}
