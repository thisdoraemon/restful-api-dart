import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

import '../bin/article.dart';

void main() {
  List<Article> articles = [];
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
      body: '{"title" : "HEY UMJI HERE!", "content" : "NICE TO MEET YOU"}',
    );
    expect(response.statusCode, 200);
    expect(response.body,
        '{"title":"HEY UMJI HERE!","content":"NICE TO MEET YOU"}');
  });

  test('POST articles with empty string', () async {
    final response = await post(
      Uri.parse(host + '/articles'),
      body: '',
    );
    expect(response.statusCode, 400);
  });

  // DEBUGGING
  test('GET articles', () async {
    final response = await get(
      Uri.parse(host + '/articles'),
    );

    final articles = articlesFromJson(response.body);

    // Expect that there is only one article.
    expect(articles.length, 1);

    // Expect that the article is correct.
    expect(articles[0].title, 'HEY UMJI HERE!');
    expect(articles[0].content, 'NICE TO MEET YOU');
  });
}
