import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_profile.dart';

/// Provider for [UserRemoteDataSource]
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRemoteDataSourceImpl(dio: dio);
});

/// Provider for [UserRepository]
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource: remoteDataSource);
});

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required this.remoteDataSource,
  });

  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Result<UserProfile>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Result.success(user);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserProfile>> updateProfile({
    required String name,
    required String bio,
    required String status,
  }) async {
    try {
      final updated = await remoteDataSource.updateProfile(
        name: name,
        bio: bio,
        status: status,
      );
      return Result.success(updated);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
