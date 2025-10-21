import 'package:dio/dio.dart';
import 'package:flutter_riverpod_boilerplate/src/api/api_client.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.ref) : client = ref.read(apiClientProvider('https://jsonplaceholder.typicode.com'));

  final Ref ref;
  final ApiClient client;

  @override
  Future<List<PostModel>> posts() async {
    final Response<dynamic> response = await client.get('/posts');
    return List<PostModel>.from(response.data.map((x) => PostModel.fromJson(x)));
  }

  @override
  Future<PostModel> post(String id, [CancelToken? cancel]) async {
    final Response<dynamic> response = await client.get('/posts/$id', cancel: cancel);
    return PostModel.fromJson(response.data);
  }
}

abstract class PostRepository {
  Future<List<PostModel>> posts();
  Future<PostModel> post(String id, [CancelToken? cancel]);
}
