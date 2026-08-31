import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/logging/app_logger.dart';
import '../models/user_profile.dart';

abstract interface class UserRemoteDataSource {
  Future<UserProfile> getCurrentUser();
  Future<UserProfile> updateProfile({
    required String name,
    required String bio,
    required String status,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({required this.dio});

  // Reserved for remote backend sync
  final Dio dio;

  UserProfile _inMemoryUser = const UserProfile(
    id: 'user_me',
    name: 'Kautsar Albana',
    username: '@kautsar',
    email: 'kautsar@kineticastudios.com',
    avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
    bio: 'Senior Flutter Engineer & System Architect 🚀',
    status: 'Building with Impeller & Riverpod ⚡️',
    isOnline: true,
  );

  @override
  Future<UserProfile> getCurrentUser() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return _inMemoryUser;
    } catch (e, stack) {
      AppLogger.error('Failed to get current user', e, stack);
      throw const ServerException(message: 'Failed to fetch user profile');
    }
  }

  @override
  Future<UserProfile> updateProfile({
    required String name,
    required String bio,
    required String status,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _inMemoryUser = _inMemoryUser.copyWith(
        name: name,
        bio: bio,
        status: status,
      );
      return _inMemoryUser;
    } catch (e, stack) {
      AppLogger.error('Failed to update user profile', e, stack);
      throw const ServerException(message: 'Failed to update profile');
    }
  }
}
