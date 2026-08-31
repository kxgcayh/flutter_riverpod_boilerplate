import '../../../../core/network/network_result.dart';
import '../../data/models/user_profile.dart';

/// Domain interface for user/profile repository
abstract interface class UserRepository {
  Future<Result<UserProfile>> getCurrentUser();
  Future<Result<UserProfile>> updateProfile({
    required String name,
    required String bio,
    required String status,
  });
}
