import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://localhost:$port';

  setUp(() async {
    await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
  });

  test('Root', () async {
    final response = await get(Uri.parse(host + '/'));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello, World!\n');
  });

  test('404', () async {
    final response = await get(Uri.parse(host + '/foobar'));
    expect(response.statusCode, 404);
  });

  test('POST articles', () async {
    final response = await post(
      Uri.parse(host + '/articles'),
      body: '{"title" : "My super article", "content" : "My super content"}',
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '{"title":"My super article","content":"My super content"}');
  });

  test('POST articles with empty string', () async {
    final response = await post(
      Uri.parse(host + '/articles'),
      body: '',
    );
    expect(response.statusCode, 400);
  });

  test('GET articles', () async {
    final response = await get(
      Uri.parse(host + "/articles"),
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '[{"title":"My super article","content":"My super content"}]');
  });
}
