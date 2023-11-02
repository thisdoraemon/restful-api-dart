import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'article.dart';

Future<void> main(List<String> args) async {
  final articles = <Article>[];
  final router = Router()
    ..get('/', (Request req) => Response.ok('Hello, World!\n'))
    ..get('/articles', (Request req) => Response.ok(articlesToJson(articles)))
    ..post('/articles', (Request request) async {
      try {
        final body = await request.readAsString();
        final article = articleFromJson(body);
        articles.add(article);
        return Response.ok(articleToJson(article));
      } catch (e) {
        return Response(400);
      }
    });

  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}