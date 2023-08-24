import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_boilerplate/src/api/api_client.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';

class PostRepository {
  PostRepository(this.ref) : client = ref.read(apiClientProvider('https://jsonplaceholder.typicode.com'));

  final Ref ref;
  final ApiClient client;

  Future<List<PostModel>> posts() async {
    final Response<dynamic> response = await client.get('/posts');
    return List<PostModel>.from(response.data.map((x) => PostModel.fromJson(x)));
  }
}
